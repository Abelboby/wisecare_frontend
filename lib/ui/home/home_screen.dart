import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:wisecare_frontend/navigation/routes.dart';
import 'package:wisecare_frontend/provider/home_provider.dart';
import 'package:wisecare_frontend/provider/profile_provider.dart';
import 'package:wisecare_frontend/enums/app_enums.dart';
import 'package:wisecare_frontend/utils/theme/colors/app_color.dart';
import 'package:wisecare_frontend/utils/theme/theme_manager.dart';

part 'home_functions.dart';
part 'home_variables.dart';
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
            case AppTab.meds:
              return const _MedsTabContent();
            case AppTab.health:
              return const _HealthTabContent();
            case AppTab.profile:
              return const _ProfileTabContent();
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
    return Container(
      color: _HomeColors.background,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const _HomeHeader(),
                Positioned(
                  left: _HomeDimens.contentPaddingHorizontal,
                  right: _HomeDimens.contentPaddingHorizontal,
                  bottom: -(_HomeDimens.floatingCardApproxHeight - _HomeDimens.floatingCardHeaderOverlap),
                  child: const _FloatingVitalsCard(),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: _HomeDimens.contentPaddingTop + _HomeDimens.floatingCardHeaderOverlap + 16,
                left: _HomeDimens.contentPaddingHorizontal,
                right: _HomeDimens.contentPaddingHorizontal,
                bottom: _HomeDimens.contentPaddingBottom,
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
                      color: _HomeColors.quickActionsTitle,
                    ),
                  ),
                  const SizedBox(height: _HomeDimens.contentGap),
                  const _QuickActionsGrid(),
                  const SizedBox(height: _HomeDimens.contentGap),
                  const _HomeAIBanner(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topInset + _HomeDimens.headerPaddingTop,
        left: _HomeDimens.headerPaddingHorizontal,
        right: _HomeDimens.headerPaddingHorizontal,
        bottom: _HomeDimens.headerPaddingBottom,
      ),
      decoration: const BoxDecoration(
        color: _HomeColors.headerNavy,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_HomeDimens.headerBottomRadius),
          bottomRight: Radius.circular(_HomeDimens.headerBottomRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: _HomeDimens.avatarSize,
                    height: _HomeDimens.avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _HomeColors.headerBorderWhite,
                        width: 2,
                      ),
                      color: _HomeColors.vitalsDivider,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: _HomeColors.vitalsLabel,
                      size: 28,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: _HomeDimens.statusBadgeSize,
                      height: _HomeDimens.statusBadgeSize,
                      decoration: BoxDecoration(
                        color: _HomeColors.statusGreen,
                        border: Border.all(
                          color: _HomeColors.headerNavy,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: _HomeDimens.avatarSize,
                      height: _HomeDimens.avatarSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _HomeColors.headerBorderWhite,
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: _HomeDimens.notificationBadgeSize,
                        height: _HomeDimens.notificationBadgeSize,
                        decoration: BoxDecoration(
                          color: _HomeColors.notificationBadge,
                          border: Border.all(
                            color: _HomeColors.headerNavy,
                            width: 1,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: _HomeDimens.headerGap),
          Text(
            DateFormat('EEEE, dd MMMM').format(DateTime.now()),
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              height: 28 / 18,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 3.25),
          Text(
            'Good Morning, \nRaghav ji',
            style: GoogleFonts.lexend(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              height: 38 / 30,
              letterSpacing: -0.75,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingVitalsCard extends StatelessWidget {
  const _FloatingVitalsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: _HomeColors.vitalsCardBg,
        borderRadius: BorderRadius.circular(_HomeDimens.floatingCardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 25,
            offset: Offset(0, 20),
          ),
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _VitalsSection(
              icon: Icons.favorite,
              iconColor: _HomeColors.heartIcon,
              value: '72',
              label: 'BPM',
            ),
          ),
          Container(
            width: 1,
            height: 60,
            color: _HomeColors.vitalsDivider,
          ),
          Expanded(
            child: _VitalsSection(
              icon: Icons.water_drop_outlined,
              iconColor: _HomeColors.bpIcon,
              value: '120/80',
              label: 'BP',
            ),
          ),
          Container(
            width: 1,
            height: 60,
            color: _HomeColors.vitalsDivider,
          ),
          Expanded(
            child: _VitalsSection(
              icon: Icons.shield_outlined,
              iconColor: _HomeColors.riskIcon,
              value: 'Low',
              label: 'RISK',
            ),
          ),
        ],
      ),
    );
  }
}

class _VitalsSection extends StatelessWidget {
  const _VitalsSection({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.lexend(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 32 / 24,
            color: _HomeColors.vitalsValue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 16 / 12,
            letterSpacing: 0.6,
            color: _HomeColors.vitalsLabel,
          ),
        ),
      ],
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  static const double _gap = 16;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cellSize = (constraints.maxWidth - _gap) / 2;
        final gridHeight = cellSize * 2 + _gap;
        return SizedBox(
          height: gridHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _QuickActionCard(
                        backgroundColor: _HomeColors.sosBg,
                        borderColor: _HomeColors.sosBorder,
                        iconBackgroundColor: _HomeColors.sosIconBg,
                        iconColor: _HomeColors.sosIcon,
                        icon: Icons.emergency,
                        label: 'Emergency SOS',
                        textColor: _HomeColors.sosText,
                        onTap: () => context.push(AppRoutes.emergencySos.path),
                      ),
                    ),
                    const SizedBox(height: _gap),
                    Expanded(
                      child: _QuickActionCard(
                        backgroundColor: _HomeColors.chatBg,
                        borderColor: _HomeColors.chatBorder,
                        iconBackgroundColor: _HomeColors.chatIconBg,
                        iconColor: _HomeColors.chatIcon,
                        icon: Icons.chat_bubble_outline,
                        label: 'Chat with Arya',
                        textColor: _HomeColors.chatText,
                        onTap: () => context.push(AppRoutes.chatWithArya.path),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: _gap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _QuickActionCard(
                        backgroundColor: _HomeColors.medicineBg,
                        borderColor: _HomeColors.medicineBorder,
                        iconBackgroundColor: _HomeColors.medicineIconBg,
                        iconColor: _HomeColors.medicineIcon,
                        icon: Icons.medication_outlined,
                        label: 'My Medicine',
                        textColor: _HomeColors.medicineText,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: _gap),
                    Expanded(
                      child: _QuickActionCard(
                        backgroundColor: _HomeColors.vitalsCardBgGreen,
                        borderColor: _HomeColors.vitalsCardBorderGreen,
                        iconBackgroundColor: _HomeColors.vitalsCardIconBgGreen,
                        iconColor: _HomeColors.vitalsCardIconGreen,
                        icon: Icons.favorite,
                        label: 'My Vitals',
                        textColor: _HomeColors.vitalsCardTextGreen,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.icon,
    required this.label,
    required this.textColor,
    required this.onTap,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final IconData icon;
  final String label;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(_HomeDimens.quickActionCardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_HomeDimens.quickActionCardRadius),
        child: Container(
          padding: const EdgeInsets.all(_HomeDimens.quickActionCardPadding),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(_HomeDimens.quickActionCardRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _HomeDimens.quickActionIconSize,
                height: _HomeDimens.quickActionIconSize,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(height: _HomeDimens.quickActionIconGap),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 22 / 18,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeAIBanner extends StatelessWidget {
  const _HomeAIBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_HomeDimens.bannerPadding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            _HomeColors.bannerGradientStart,
            _HomeColors.bannerGradientEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(_HomeDimens.bannerRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33DDD6FE),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x26DDD6FE),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: _HomeDimens.avatarCircleSize,
                height: _HomeDimens.avatarCircleSize,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.smart_toy_outlined,
                  color: _HomeColors.bannerGradientEnd,
                  size: 32,
                ),
              ),
              Positioned(
                right: -4,
                bottom: -4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _HomeColors.statusGreenBanner,
                    border: Border.all(
                      color: _HomeColors.bannerGradientEnd,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: _HomeDimens.bannerPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Arya AI Assistant',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 20 / 14,
                    color: _HomeColors.bannerSubtitle,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  'Did you sleep well last night, Raghav ji?',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 22 / 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: _HomeDimens.micButtonSize,
              height: _HomeDimens.micButtonSize,
              decoration: BoxDecoration(
                color: _HomeColors.bannerMicBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mic_none,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedsTabContent extends StatelessWidget {
  const _MedsTabContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Meds',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class _HealthTabContent extends StatelessWidget {
  const _HealthTabContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Health',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class _ProfileTabContent extends StatelessWidget {
  const _ProfileTabContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _HomeColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(_HomeDimens.contentPaddingHorizontal),
          child: Consumer<ProfileProvider>(
            builder: (context, provider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Profile',
                    style: GoogleFonts.lexend(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 32 / 24,
                      color: _HomeColors.quickActionsTitle,
                    ),
                  ),
                  const SizedBox(height: _HomeDimens.contentGap),
                  if (provider.errorMessage != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        provider.errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  _SignOutButton(
                    isLoading: provider.isLoading,
                    onTap: () => provider.signOut(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({
    required this.isLoading,
    required this.onTap,
  });

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppThemeMode>(
      valueListenable: Skin.themeMode,
      builder: (_, __, ___) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: Skin.color(Co.primary),
                borderRadius: BorderRadius.circular(_HomeDimens.quickActionCardRadius),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4DFF6933),
                    blurRadius: 15,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Color(0x4DFF6933),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isLoading ? null : onTap,
                borderRadius: BorderRadius.circular(_HomeDimens.quickActionCardRadius),
                child: Container(
                  height: 56,
                  alignment: Alignment.center,
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Sign out',
                          style: GoogleFonts.lexend(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 28 / 18,
                          ),
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
