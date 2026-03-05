import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:wisecare_frontend/navigation/app_route_model.dart';
import 'package:wisecare_frontend/ui/chat/chat_with_arya_screen.dart';
import 'package:wisecare_frontend/ui/emergency_sos/emergency_sos_screen.dart';
import 'package:wisecare_frontend/ui/home/home_screen.dart';
import 'package:wisecare_frontend/ui/login/login_screen.dart';
import 'package:wisecare_frontend/ui/splash/splash_screen.dart';
import 'package:wisecare_frontend/ui/wallet/wallet_screen.dart';

/// All app routes. Register here and add to [all].
abstract class AppRoutes {
  AppRoutes._();

  static final AppRoute splash = AppRoute(
    path: '/',
    name: 'Splash',
    builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
  );

  static final AppRoute home = AppRoute(
    path: '/home',
    name: 'Home',
    builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
  );

  static final AppRoute login = AppRoute(
    path: '/login',
    name: 'Login',
    builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
  );

  static final AppRoute chatWithArya = AppRoute(
    path: '/chat-with-arya',
    name: 'ChatWithArya',
    builder: (BuildContext context, GoRouterState state) => const ChatWithAryaScreen(),
  );

  static final AppRoute emergencySos = AppRoute(
    path: '/emergency-sos',
    name: 'EmergencySos',
    builder: (BuildContext context, GoRouterState state) => const EmergencySosScreen(),
  );

  static final AppRoute wallet = AppRoute(
    path: '/wallet',
    name: 'Wallet',
    builder: (BuildContext context, GoRouterState state) => const WalletScreen(),
  );

  static List<AppRoute> get all => [splash, home, login, chatWithArya, emergencySos, wallet];

  static List<AppRoute> get testableRoutes => [home, login];
}
