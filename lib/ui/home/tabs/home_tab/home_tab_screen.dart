import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wisecare_frontend/enums/app_enums.dart';
import 'package:wisecare_frontend/navigation/routes.dart';
import 'package:wisecare_frontend/provider/home_provider.dart';
import 'package:wisecare_frontend/provider/profile_provider.dart';
import 'package:wisecare_frontend/provider/vitals_provider.dart';

part 'home_tab_functions.dart';
part 'home_tab_variables.dart';
part 'widgets/home_header.dart';
part 'widgets/floating_vitals_card.dart';
part 'widgets/quick_actions_grid.dart';
part 'widgets/home_ai_banner.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  bool _profileRequested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_profileRequested) {
      _profileRequested = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.read<ProfileProvider>().loadProfile();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        final profile = profileProvider.profile;
        final profilePhotoUrl = profile?.profilePhotoUrl;
        final userName = profile?.name;

        // Wire vitals WebSocket once userId is known.
        if (profile != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              context.read<VitalsProvider>().init(profile.userId);
            }
          });
        }
        return Container(
          color: _HomeTabColors.background,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _HomeHeader(
                      profilePhotoUrl: profilePhotoUrl,
                      userName: userName,
                    ),
                    Positioned(
                      left: _HomeTabDimens.contentPaddingHorizontal,
                      right: _HomeTabDimens.contentPaddingHorizontal,
                      bottom: -(_HomeTabDimens.floatingCardApproxHeight - _HomeTabDimens.floatingCardHeaderOverlap),
                      child: const _FloatingVitalsCard(),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: _HomeTabDimens.contentPaddingTop + _HomeTabDimens.floatingCardHeaderOverlap + 16,
                    left: _HomeTabDimens.contentPaddingHorizontal,
                    right: _HomeTabDimens.contentPaddingHorizontal,
                    bottom: _HomeTabDimens.contentPaddingBottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Quick Actions',
                        style: GoogleFonts.lexend(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 28 / 20,
                          color: _HomeTabColors.quickActionsTitle,
                        ),
                      ),
                      const SizedBox(height: _HomeTabDimens.contentGap),
                      const _QuickActionsGrid(),
                      const SizedBox(height: _HomeTabDimens.contentGap),
                      _HomeAIBanner(userName: userName),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
