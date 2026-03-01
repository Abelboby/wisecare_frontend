import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:device_frame/device_frame.dart';

import 'package:wisecare_frontend/enums/app_enums.dart';
import 'package:wisecare_frontend/navigation/app_navigator.dart';
import 'package:wisecare_frontend/provider/provider_register.dart';
import 'package:wisecare_frontend/utils/theme/app_theme.dart';
import 'package:wisecare_frontend/utils/theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Hive.initFlutter();
  } catch (_) {}
  await Skin.retrieveTheme();
  runApp(const WiseCareApp());
}

class WiseCareApp extends StatelessWidget {
  const WiseCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderRegister.getProviders(),
      child: ValueListenableBuilder<AppThemeMode>(
        valueListenable: Skin.themeMode,
        builder: (_, mode, __) {
          final app = MaterialApp.router(
            key: Key(mode.name),
            title: 'WiseCare',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.commonThemeData,
            routerConfig: AppNavigator.router,
          );
          return kIsWeb
              ? Directionality(
                  textDirection: TextDirection.ltr,
                  child: DeviceFrame(
                    device: Devices.ios.iPhone15Pro,
                    screen: app,
                    orientation: Orientation.portrait,
                    isFrameVisible: true,
                  ),
                )
              : app;
        },
      ),
    );
  }
}
