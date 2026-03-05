part of '../health_tab_screen.dart';

class _HealthHeader extends StatelessWidget {
  const _HealthHeader();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topInset + 16,
        left: _HealthTabDimens.headerPaddingHorizontal,
        right: _HealthTabDimens.headerPaddingHorizontal,
        bottom: _HealthTabDimens.headerPaddingBottom,
      ),
      decoration: const BoxDecoration(
        color: _HealthTabColors.headerNavy,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _HealthBackButton(),
          Text(
            'My Health Vitals',
            style: GoogleFonts.lexend(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 28 / 20,
              letterSpacing: 0.5,
              color: _HealthTabColors.headerTitle,
            ),
          ),
          _HealthNotificationButton(),
        ],
      ),
    );
  }
}

class _HealthBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<HomeProvider>().switchTab(AppTab.home),
      child: Container(
        width: _HealthTabDimens.headerButtonSize,
        height: _HealthTabDimens.headerButtonSize,
        decoration: const BoxDecoration(
          color: _HealthTabColors.headerButtonBg,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.chevron_left_rounded,
          color: _HealthTabColors.headerIcon,
          size: 28,
        ),
      ),
    );
  }
}

class _HealthNotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _HealthTabDimens.headerButtonSize,
      height: _HealthTabDimens.headerButtonSize,
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.notifications_outlined,
              color: _HealthTabColors.headerIcon,
              size: 24,
            ),
          ),
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _HealthTabColors.notificationBadge,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
