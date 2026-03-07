import 'package:dio/dio.dart';

import 'package:wisecare_frontend/network/dio_helper.dart';
import 'package:wisecare_frontend/network/endpoints.dart';

/// Elderly onboarding API. Auth via JwtInterceptor.
/// Flow: basic → medications → generate-invite (see docs/elderly-onboarding-api-integration.md).
class OnboardingService {
  OnboardingService._();

  static String _messageFromDioException(DioException e) {
    final response = e.response;
    if (response?.data is Map<String, dynamic>) {
      final data = response!.data as Map<String, dynamic>;
      final serverMsg = (data['error'] as String?)?.trim() ??
          (data['message'] as String?)?.trim();
      if (serverMsg != null && serverMsg.isNotEmpty) return serverMsg;
    }
    if (response?.statusCode != null) {
      switch (response!.statusCode!) {
        case 400:
          return 'Please check your details and try again.';
        case 401:
          return 'Session expired. Please sign in again.';
        case 403:
          return 'This action is only available for elderly accounts.';
        default:
          if (response.statusCode! >= 500) {
            return 'Server error. Please try again later.';
          }
      }
    }
    if (response == null ||
        e.type == DioExceptionType.connectionError ||
        (e.message?.contains('XMLHttpRequest') ?? false)) {
      return 'Network error. Please check your connection and try again.';
    }
    return e.message ?? 'Something went wrong. Please try again.';
  }

  /// POST /onboarding/elderly/basic. Returns next step (e.g. MEDICATIONS).
  /// [dob] YYYY-MM-DD. [emergencyContact] has name, relationship, number.
  static Future<Map<String, dynamic>> postBasicInfo({
    required String dob,
    required String gender,
    required String address,
    required Map<String, dynamic> emergencyContact,
    String? bloodGroup,
    List<String>? preExistingConditions,
  }) async {
    try {
      final body = <String, dynamic>{
        'dob': dob,
        'gender': gender,
        'address': address,
        'emergencyContact': emergencyContact,
      };
      if (bloodGroup != null && bloodGroup.isNotEmpty) body['bloodGroup'] = bloodGroup;
      if (preExistingConditions != null && preExistingConditions.isNotEmpty) {
        body['preExistingConditions'] = preExistingConditions;
      }
      final response = await DioHelper.instance.post<Map<String, dynamic>>(
        Endpoints.onboardingElderlyBasic,
        data: body,
        options: Options(contentType: Headers.jsonContentType),
      );
      final data = response.data;
      if (data == null) throw Exception('Invalid response from server.');
      return Map<String, dynamic>.from(data);
    } on DioException catch (e) {
      throw Exception(_messageFromDioException(e));
    }
  }

  /// POST /onboarding/elderly/medications. Each item: name, dosage, frequency, time (e.g. 08:00).
  static Future<Map<String, dynamic>> postMedications({
    required List<Map<String, String>> medications,
  }) async {
    try {
      final response = await DioHelper.instance.post<Map<String, dynamic>>(
        Endpoints.onboardingElderlyMedications,
        data: <String, dynamic>{'medications': medications},
        options: Options(contentType: Headers.jsonContentType),
      );
      final data = response.data;
      if (data == null) throw Exception('Invalid response from server.');
      return Map<String, dynamic>.from(data);
    } on DioException catch (e) {
      throw Exception(_messageFromDioException(e));
    }
  }

  /// Generate invite code (Elderly).
  /// POST {baseUrl}/onboarding/elderly/generate-invite
  /// Auth: Bearer accessToken (ELDERLY). Body: empty {} or no body.
  /// Response 200: { inviteCode, expiresAt (ISO datetime), onboardingStep: "COMPLETE" }.
  static Future<Map<String, dynamic>> postGenerateInvite() async {
    try {
      final response = await DioHelper.instance.post<Map<String, dynamic>>(
        Endpoints.onboardingElderlyGenerateInvite,
        data: <String, dynamic>{},
        options: Options(contentType: Headers.jsonContentType),
      );
      final data = response.data;
      if (data == null) throw Exception('Invalid response from server.');
      return Map<String, dynamic>.from(data);
    } on DioException catch (e) {
      throw Exception(_messageFromDioException(e));
    }
  }
}
