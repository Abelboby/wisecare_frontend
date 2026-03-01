import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wisecare_frontend/provider/home_provider.dart';
import 'package:wisecare_frontend/enums/app_enums.dart';

part 'home_functions.dart';
part 'widgets/home_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // void _refresh() => mounted ? setState(() {}) : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          switch (provider.currentTab) {
            case AppTab.home:
              return const _HomeTabContent();
            case AppTab.settings:
              return const _SettingsTabContent();
          }
        },
      ),
      bottomNavigationBar: const _HomeBottomNav(),
    );
  }
}

class _HomeTabContent extends StatelessWidget {
  const _HomeTabContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class _SettingsTabContent extends StatelessWidget {
  const _SettingsTabContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
