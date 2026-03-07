part of 'onboarding_screen.dart';

/// Onboarding steps from backend: BASIC_INFO → slide 0, MEDICATIONS → 1, INVITE → 2.
class OnboardingStaticValues {
  OnboardingStaticValues._();

  static const List<String> stepKeys = ['BASIC_INFO', 'MEDICATIONS', 'INVITE_FAMILY'];
  static const int totalSlides = 3;

  static int pageIndexFromStep(String step) {
    final i = stepKeys.indexOf(step);
    return i >= 0 ? i : 0;
  }

  static String stepFromPageIndex(int index) {
    if (index < 0 || index >= stepKeys.length) return stepKeys[0];
    return stepKeys[index];
  }

  static String stepTitle(int index) {
    switch (index) {
      case 0:
        return 'Basic Info';
      case 1:
        return 'My Medications';
      case 2:
        return 'Connect Family';
      default:
        return 'Basic Info';
    }
  }
}
