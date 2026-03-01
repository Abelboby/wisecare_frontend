import '../services/splash_service.dart';

/// Splash data orchestration. Only this layer talks to SplashService.
class SplashRepository {
  SplashRepository({SplashService? splashService})
      : _splashService = splashService ?? SplashService();

  final SplashService _splashService;

  Future<void> initialize() async {
    await _splashService.initialize();
  }
}
