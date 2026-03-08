part of '../health_tab_screen.dart';

class _HealthHeader extends StatelessWidget {
  const _HealthHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _HealthTabDimens.headerHeight,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: _HealthTabDimens.headerPadding,
        right: _HealthTabDimens.headerPadding,
        bottom: _HealthTabDimens.headerPadding,
      ),
      decoration: const BoxDecoration(
        color: _HealthTabColors.headerBg,
        border: Border(
          bottom: BorderSide(color: _HealthTabColors.headerBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Text(
            'Health Vitals',
            style: GoogleFonts.lexend(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 25 / 20,
              letterSpacing: -0.5,
              color: _HealthTabColors.headerTitle,
            ),
          ),
          const Spacer(),
          _NotificationButton(),
        ],
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.myHealthHistory.path);
      },
      child: SizedBox(
        width: 48,
        height: 48,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Icon(
                Icons.history_rounded,
                color: _HealthTabColors.headerIconMuted,
                size: 32,
              ),
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _HealthTabColors.notificationBadge,
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
