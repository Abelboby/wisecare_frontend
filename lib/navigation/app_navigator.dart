import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:wisecare_frontend/navigation/app_route_model.dart';
import 'package:wisecare_frontend/navigation/routes.dart';

/// GoRouter wrapper. Use navigate(route) and goBack().
class AppNavigator {
  AppNavigator._();

  static final ValueNotifier<AppRoute?> selectedRouteNotifier =
      ValueNotifier<AppRoute?>(null);

  static AppRoute? get selectedRoute => selectedRouteNotifier.value;

  static final GoRouter router = _buildRouter();

  static GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: AppRoutes.splash.path,
      routes: _buildRoutes(AppRoutes.all),
      refreshListenable: _RouterRefresh(),
    );
  }

  static List<RouteBase> _buildRoutes(List<AppRoute> appRoutes) {
    return appRoutes
        .map<RouteBase>(
          (r) => GoRoute(
            path: r.path,
            name: r.name,
            builder: (context, state) => r.builder(context, state),
          ),
        )
        .toList();
  }

  static void navigate(AppRoute route) {
    selectedRouteNotifier.value = route;
    router.go(route.path);
  }

  /// Navigate to onboarding at the given step (BASIC_INFO, MEDICATIONS, INVITE).
  static void navigateToOnboarding(String step) {
    selectedRouteNotifier.value = AppRoutes.onboarding;
    router.go('${AppRoutes.onboarding.path}?step=$step');
  }

  static void goBack() {
    router.pop();
  }
}

class _RouterRefresh extends ChangeNotifier {}
