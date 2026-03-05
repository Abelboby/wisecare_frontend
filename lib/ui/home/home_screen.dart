import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wisecare_frontend/enums/app_enums.dart';
import 'package:wisecare_frontend/provider/home_provider.dart';
import 'package:wisecare_frontend/ui/home/tabs/health_tab/health_tab_screen.dart';
import 'package:wisecare_frontend/ui/home/tabs/home_tab/home_tab_screen.dart';
import 'package:wisecare_frontend/ui/home/tabs/meds_tab/meds_tab_screen.dart';
import 'package:wisecare_frontend/ui/home/tabs/profile_tab/profile_tab_screen.dart';

part 'home_functions.dart';
part 'home_variables.dart';
part 'widgets/home_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          switch (provider.currentTab) {
            case AppTab.home:
              return const HomeTabScreen();
            case AppTab.meds:
              return const MedsTabScreen();
            case AppTab.health:
              return const HealthTabScreen();
            case AppTab.profile:
              return const ProfileTabScreen();
          }
        },
      ),
      bottomNavigationBar: const _HomeBottomNav(),
    );
  }
}
