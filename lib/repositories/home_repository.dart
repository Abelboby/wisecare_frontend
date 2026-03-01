import 'package:wisecare_frontend/services/home_service.dart';

/// Home data orchestration. Only this layer talks to HomeService.
class HomeRepository {
  HomeRepository({HomeService? homeService})
      : _homeService = homeService ?? HomeService();

  final HomeService _homeService;

  Future<void> loadData() async {
    await _homeService.loadData();
  }
}
