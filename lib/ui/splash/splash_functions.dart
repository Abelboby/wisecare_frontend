part of 'splash_screen.dart';

extension _SplashScreenFunctions on _SplashScreenState {
  Future<void> _initApp() async {
    final provider = context.read<SplashProvider>();
    await provider.loadInitialData();
    if (!mounted) return;
    AppNavigator.navigate(AppRoutes.home);
  }
}
