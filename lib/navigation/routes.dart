import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:wisecare_frontend/navigation/app_route_model.dart';
import 'package:wisecare_frontend/ui/chat/chat_with_arya_screen.dart';
import 'package:wisecare_frontend/ui/emergency_sos/emergency_sos_screen.dart';
import 'package:wisecare_frontend/ui/health_history/my_health_history_screen.dart';
import 'package:wisecare_frontend/ui/home/home_screen.dart';
import 'package:wisecare_frontend/ui/login/login_screen.dart';
import 'package:wisecare_frontend/ui/signup/signup_screen.dart';
import 'package:wisecare_frontend/ui/splash/splash_screen.dart';
import 'package:wisecare_frontend/ui/wallet/wallet_screen.dart';
import 'package:wisecare_frontend/ui/onboarding/onboarding_screen.dart';
import 'package:wisecare_frontend/ui/wallet/wallet_transaction_history_screen.dart';

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

  static final AppRoute signup = AppRoute(
    path: '/signup',
    name: 'Signup',
    builder: (BuildContext context, GoRouterState state) => const SignupScreen(),
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

  static final AppRoute walletTransactions = AppRoute(
    path: '/wallet/transactions',
    name: 'WalletTransactions',
    builder: (BuildContext context, GoRouterState state) => const WalletTransactionHistoryScreen(),
  );

  static final AppRoute onboarding = AppRoute(
    path: '/onboarding',
    name: 'Onboarding',
    builder: (BuildContext context, GoRouterState state) {
      final step = state.uri.queryParameters['step'] ?? 'BASIC_INFO';
      return OnboardingScreen(initialStep: step);
    },
  );

  static final AppRoute myHealthHistory = AppRoute(
    path: '/my-health-history',
    name: 'MyHealthHistory',
    builder: (BuildContext context, GoRouterState state) =>
        const MyHealthHistoryScreen(),
  );

  static List<AppRoute> get all => [
        splash,
        home,
        login,
        signup,
        chatWithArya,
        emergencySos,
        wallet,
        walletTransactions,
        onboarding,
        myHealthHistory,
      ];

  static List<AppRoute> get testableRoutes => [home, login, signup];
}
