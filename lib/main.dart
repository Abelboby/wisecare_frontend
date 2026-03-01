import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'provider/provider_register.dart';
import 'navigation/app_navigator.dart';
import 'utils/theme/app_theme.dart';
import 'utils/theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Hive.initFlutter();
  } catch (_) {}
  await Skin.loadSavedTheme();
  runApp(const WiseCareApp());
}

class WiseCareApp extends StatelessWidget {
  const WiseCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderRegister.getProviders(),
      child: ValueListenableBuilder<dynamic>(
        valueListenable: Skin.themeModeNotifier,
        builder: (_, __, ___) {
          final theme = AppTheme.currentTheme;
          return MaterialApp.router(
            title: 'WiseCare',
            debugShowCheckedModeBanner: false,
            theme: theme,
            routerConfig: AppNavigator.router,
          );
        },
      ),
    );
  }
}
