import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wisecare_frontend/navigation/app_navigator.dart';
import 'package:wisecare_frontend/navigation/routes.dart';
import 'package:wisecare_frontend/services/onboarding_service.dart';
import 'package:wisecare_frontend/ui/onboarding/onboarding_shared.dart';
import 'package:wisecare_frontend/ui/onboarding/slides/basic_info/basic_info_slide_screen.dart';
import 'package:wisecare_frontend/ui/onboarding/slides/invite/invite_slide_screen.dart';
import 'package:wisecare_frontend/ui/onboarding/slides/medications/medications_slide_screen.dart';

part 'onboarding_functions.dart';
part 'onboarding_variables.dart';
part 'widgets/onboarding_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.initialStep});

  final String initialStep;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  late int _currentIndex;
  bool _isSubmitting = false;
  String? _inviteCode;
  String? _inviteExpiresAt;

  final GlobalKey<BasicInfoSlideScreenState> _basicInfoKey = GlobalKey<BasicInfoSlideScreenState>();
  final GlobalKey<MedicationsSlideScreenState> _medicationsKey = GlobalKey<MedicationsSlideScreenState>();

  @override
  void initState() {
    super.initState();
    _currentIndex = OnboardingStaticValues.pageIndexFromStep(widget.initialStep);
    _pageController = PageController(initialPage: _currentIndex);
    if (_currentIndex == OnboardingStaticValues.totalSlides - 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _fetchInviteCodeIfNeeded());
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    if (index == _currentIndex) return;
    if (mounted) setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onSkip() {
    AppNavigator.navigate(AppRoutes.home);
  }

  void _onBack() {
    if (_currentIndex > 0) {
      _goToPage(_currentIndex - 1);
    } else {
      AppNavigator.goBack();
    }
  }

  Future<void> _onSaveAndNext() async {
    if (_isSubmitting || !mounted) return;
    setState(() => _isSubmitting = true);
    try {
      if (_currentIndex == 0) {
        final slideState = _basicInfoKey.currentState;
        if (slideState == null) {
          if (mounted) setState(() => _isSubmitting = false);
          return;
        }
        final (payload, error) = slideState.getBasicInfoForSubmit();
        if (error != null) {
          if (mounted) {
            setState(() => _isSubmitting = false);
            showOnboardingError(context, error);
          }
          return;
        }
        if (payload == null) {
          if (mounted) setState(() => _isSubmitting = false);
          return;
        }
        await OnboardingService.postBasicInfo(
          dob: payload['dob'] as String,
          gender: payload['gender'] as String,
          address: payload['address'] as String,
          emergencyContact: payload['emergencyContact'] as Map<String, dynamic>,
          bloodGroup: payload['bloodGroup'] as String?,
          preExistingConditions: (payload['preExistingConditions'] as List<dynamic>?)?.cast<String>(),
        );
        if (mounted) {
          setState(() => _isSubmitting = false);
          _goToPage(1);
        }
      } else if (_currentIndex == 1) {
        final slideState = _medicationsKey.currentState;
        if (slideState == null) {
          if (mounted) {
            setState(() => _isSubmitting = false);
            showOnboardingError(context, 'Form not ready.');
          }
          return;
        }
        final (payload, error) = slideState.getMedicationsForSubmit();
        if (error != null) {
          if (mounted) {
            setState(() => _isSubmitting = false);
            showOnboardingError(context, error);
          }
          return;
        }
        if (payload == null) {
          if (mounted) setState(() => _isSubmitting = false);
          return;
        }
        await OnboardingService.postMedications(medications: payload);
        if (mounted) {
          setState(() => _isSubmitting = false);
          _goToPage(2);
          _fetchInviteCodeIfNeeded();
        }
      }
    } catch (e) {
      final message = e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString();
      if (mounted) {
        setState(() => _isSubmitting = false);
        showOnboardingError(context, message);
      }
    }
  }

  /// Calls POST /onboarding/elderly/generate-invite when user is on the third slide and code not yet loaded.
  Future<void> _fetchInviteCodeIfNeeded() async {
    if (!mounted) return;
    final isInviteSlide = _currentIndex == OnboardingStaticValues.totalSlides - 1;
    if (!isInviteSlide || _inviteCode != null || _isSubmitting) return;
    setState(() => _isSubmitting = true);
    try {
      final result = await OnboardingService.postGenerateInvite();
      final code = result['inviteCode'] as String?;
      final expiresAt = result['expiresAt'] as String?;
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _inviteCode = code ?? '';
          _inviteExpiresAt = expiresAt;
        });
      }
      if ((code == null || code.isEmpty) && mounted) {
        showOnboardingError(context, 'Could not generate invite code.');
      }
    } catch (e) {
      final message = e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString();
      if (mounted) {
        setState(() => _isSubmitting = false);
        showOnboardingError(context, message);
      }
    }
  }

  Future<void> _onCompleteOnboarding() async {
    if (_isSubmitting || !mounted) return;
    if (_inviteCode != null && _inviteCode!.isNotEmpty) {
      AppNavigator.navigate(AppRoutes.home);
      return;
    }
    await _fetchInviteCodeIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: OnboardingColors.background,
      appBar: _OnboardingAppBar(
        title: 'Step ${_currentIndex + 1} of ${OnboardingStaticValues.totalSlides}',
        onBack: _onBack,
        onSkip: _onSkip,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                if (mounted) {
                  setState(() => _currentIndex = index);
                  if (index == OnboardingStaticValues.totalSlides - 1) {
                    _fetchInviteCodeIfNeeded();
                  }
                }
              },
              children: [
                BasicInfoSlideScreen(key: _basicInfoKey),
                MedicationsSlideScreen(key: _medicationsKey),
                InviteSlideScreen(inviteCode: _inviteCode, expiresAt: _inviteExpiresAt),
              ],
            ),
          ),
          if (_currentIndex == OnboardingStaticValues.totalSlides - 1)
            _InviteSlideFooter(
              onComplete: _onCompleteOnboarding,
              isLoading: _isSubmitting,
            )
          else
            _OnboardingBottomBar(
              onSaveAndNext: _onSaveAndNext,
              isLoading: _isSubmitting,
            ),
        ],
      ),
    );
  }
}
