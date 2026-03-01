import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/repositories/home_repository.dart';
import 'package:wisecare_frontend/enums/app_enums.dart';

/// Home screen state. currentTab and switchTab. Uses repository only.
class HomeProvider extends ChangeNotifier {
  HomeProvider({HomeRepository? repository})
      : _repository = repository ?? HomeRepository();

  final HomeRepository _repository;

  HomeRepository get repository => _repository;

  AppTab _currentTab = AppTab.home;
  AppTab get currentTab => _currentTab;

  void switchTab(AppTab tab) {
    if (_currentTab == tab) return;
    _currentTab = tab;
    notifyListeners();
  }
}
