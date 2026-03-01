import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'splash_provider.dart';
import 'home_provider.dart';

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
    ];
  }

  /// Clear providers on logout or leave.
  static void clearProviders(BuildContext context) {
    // Add providers that should be cleared on logout or leave:
    // e.g. context.read<SomeProvider>().clear();
  }
}
