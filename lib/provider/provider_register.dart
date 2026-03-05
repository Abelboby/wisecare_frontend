import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:wisecare_frontend/provider/chat_provider.dart';
import 'package:wisecare_frontend/provider/home_provider.dart';
import 'package:wisecare_frontend/provider/login_provider.dart';
import 'package:wisecare_frontend/provider/meds_provider.dart';
import 'package:wisecare_frontend/provider/profile_provider.dart';
import 'package:wisecare_frontend/provider/sos_provider.dart';
import 'package:wisecare_frontend/provider/splash_provider.dart';

/// Centralized provider registration.
/// Theme is NOT managed via Provider — see Skin (theme/theme_manager.dart).
class ProviderRegister {
  ProviderRegister._();

  /// Get all providers for MultiProvider.
  static List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider<SplashProvider>(
        create: (_) => SplashProvider(),
      ),
      ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(),
      ),
      ChangeNotifierProvider<MedsProvider>(
        create: (_) => MedsProvider(),
      ),
      ChangeNotifierProvider<ChatProvider>(
        create: (_) => ChatProvider(),
      ),
      ChangeNotifierProvider<SosProvider>(
        create: (_) => SosProvider(),
      ),
      ChangeNotifierProvider<LoginProvider>(
        create: (_) => LoginProvider(),
      ),
      ChangeNotifierProvider<ProfileProvider>(
        create: (_) => ProfileProvider(),
      ),
    ];
  }

  /// Clear providers on logout or leave.
  static void clearProviders(BuildContext context) {
    context.read<LoginProvider>().clearError();
  }
}
