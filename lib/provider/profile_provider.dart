import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:wisecare_frontend/utils/file_reader_stub.dart'
    if (dart.library.io) 'package:wisecare_frontend/utils/file_reader_io.dart'
    as file_reader;

import 'package:wisecare_frontend/models/profile/profile_model.dart';
import 'package:wisecare_frontend/navigation/app_navigator.dart';
import 'package:wisecare_frontend/navigation/routes.dart';
import 'package:wisecare_frontend/repositories/profile_repository.dart';
import 'package:wisecare_frontend/services/auth_service.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({ProfileRepository? profileRepository})
      : _profileRepository = profileRepository ?? ProfileRepository();

  final ProfileRepository _profileRepository;

  ProfileModel? _profile;
  ProfileModel? get profile => _profile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isUploadingPhoto = false;
  bool get isUploadingPhoto => _isUploadingPhoto;

  bool _isProfileLoading = false;
  bool get isProfileLoading => _isProfileLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _profileLoaded = false;

  /// Loads the user profile from the API. Safe to call multiple times;
  /// subsequent calls after the first successful load are no-ops.
  Future<void> loadProfile() async {
    if (_profileLoaded || _isProfileLoading) return;
    _isProfileLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _profile = await _profileRepository.getProfile();
      _profileLoaded = true;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
    } finally {
      _isProfileLoading = false;
      notifyListeners();
    }
  }

  /// Picks an image, uploads via POST /uploads, then updates profile with the URL.
  Future<void> uploadProfilePhoto() async {
    if (_isLoading) return;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );
      if (result == null || result.files.isEmpty) return;
      final file = result.files.single;
      List<int>? bytes = file.bytes;
      if (bytes == null && file.path != null) {
        bytes = await file_reader.readFileBytes(file.path!);
      }
      if (bytes == null || bytes.isEmpty) {
        _errorMessage = 'Could not read file.';
        notifyListeners();
        return;
      }
      final base64Data = base64Encode(bytes);
      final fileName = file.name.isNotEmpty ? file.name : 'profile-photo.jpg';
      final fileType = _mimeFromExtension(fileName);
      _isLoading = true;
      _isUploadingPhoto = true;
      _errorMessage = null;
      notifyListeners();
      final url = await _profileRepository.uploadFile(
        base64Data: base64Data,
        fileType: fileType,
        fileName: fileName,
        folder: 'profile-photos',
      );
      _profile = await _profileRepository.updateProfile(
        UpdateProfileRequest(profilePhotoUrl: url),
      );
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
    } finally {
      _isLoading = false;
      _isUploadingPhoto = false;
      notifyListeners();
    }
  }

  static String _mimeFromExtension(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg';
    }
  }

  /// Updates profile fields via PUT /users/me.
  Future<void> updateProfileDetails(UpdateProfileRequest request) async {
    if (_isLoading) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _profile = await _profileRepository.updateProfile(request);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Updates emergency contacts list via PUT /users/me/emergency-contact, then refreshes profile.
  Future<void> updateEmergencyContacts(List<EmergencyContact> contacts) async {
    if (_isLoading) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _profileRepository.updateEmergencyContacts(contacts);
      _profile = await _profileRepository.getProfile();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Updates app settings (notification sounds and font size) via the API.
  Future<void> updateSettings(ProfileSettings settings) async {
    if (_isLoading) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final updated = await _profileRepository.updateSettings(settings);
      if (_profile != null) {
        _profile = ProfileModel(
          userId: _profile!.userId,
          email: _profile!.email,
          name: _profile!.name,
          role: _profile!.role,
          phone: _profile!.phone,
          profilePhotoUrl: _profile!.profilePhotoUrl,
          createdAt: _profile!.createdAt,
          dateOfBirth: _profile!.dateOfBirth,
          age: _profile!.age,
          city: _profile!.city,
          cityImageUrl: _profile!.cityImageUrl,
          address: _profile!.address,
          gender: _profile!.gender,
          bloodGroup: _profile!.bloodGroup,
          emergencyContacts: _profile!.emergencyContacts,
          preExistingConditions: _profile!.preExistingConditions,
          profileComplete: _profile!.profileComplete,
          onboardingStep: _profile!.onboardingStep,
          settings: updated,
        );
      }
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    if (_isLoading) return;
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    try {
      await AuthService.signOut();
      _profile = null;
      _profileLoaded = false;
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      AppNavigator.navigate(AppRoutes.login);
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
