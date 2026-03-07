part of 'splash_screen.dart';

extension _SplashScreenFunctions on _SplashScreenState {
  Future<void> _initApp() async {
    final provider = context.read<SplashProvider>();
    await provider.loadInitialData();
    if (!mounted) return;
    if (provider.error != null) return;
    final hasToken = await AuthStorageService.hasStoredAuthToken();
    if (!mounted) return;
    if (hasToken) {
      await _navigateByOnboardingStep();
    } else {
      AppNavigator.navigate(AppRoutes.login);
    }
  }

  /// Fetches GET /users/me and routes to onboarding or home based on onboardingStep.
  Future<void> _navigateByOnboardingStep() async {
    try {
      final profile = await ProfileRepository().getProfile();
      if (!mounted) return;
      final step = profile.onboardingStep.trim().toUpperCase();
      if (step.isNotEmpty && step != 'COMPLETE') {
        AppNavigator.navigateToOnboarding(step);
      } else {
        AppNavigator.navigate(AppRoutes.home);
      }
    } catch (_) {
      if (!mounted) return;
      AppNavigator.navigate(AppRoutes.home);
    }
  }
}
