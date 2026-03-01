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
      AppNavigator.navigate(AppRoutes.home);
    } else {
      AppNavigator.navigate(AppRoutes.login);
    }
  }
}
