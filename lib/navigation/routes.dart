import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_route_model.dart';
import '../ui/splash/splash_screen.dart';
import '../ui/home/home_screen.dart';

/// All app routes. Register here and add to [all].
abstract class AppRoutes {
  AppRoutes._();

  static final AppRoute splash = AppRoute(
    path: '/',
    name: 'Splash',
    builder: (BuildContext context, GoRouterState state) =>
        const SplashScreen(),
  );

  static final AppRoute home = AppRoute(
    path: '/home',
    name: 'Home',
    builder: (BuildContext context, GoRouterState state) =>
        const HomeScreen(),
  );

  static List<AppRoute> get all => [splash, home];

  static List<AppRoute> get testableRoutes => [home];
}
