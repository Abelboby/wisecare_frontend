part of '../home_tab_screen.dart';

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topInset + _HomeTabDimens.headerPaddingTop,
        left: _HomeTabDimens.headerPaddingHorizontal,
        right: _HomeTabDimens.headerPaddingHorizontal,
        bottom: _HomeTabDimens.headerPaddingBottom,
      ),
      decoration: const BoxDecoration(
        color: _HomeTabColors.headerNavy,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_HomeTabDimens.headerBottomRadius),
          bottomRight: Radius.circular(_HomeTabDimens.headerBottomRadius),
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
                    width: _HomeTabDimens.avatarSize,
                    height: _HomeTabDimens.avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _HomeTabColors.headerBorderWhite,
                        width: 2,
                      ),
                      color: _HomeTabColors.vitalsDivider,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: _HomeTabColors.vitalsLabel,
                      size: 28,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: _HomeTabDimens.statusBadgeSize,
                      height: _HomeTabDimens.statusBadgeSize,
                      decoration: BoxDecoration(
                        color: _HomeTabColors.statusGreen,
                        border: Border.all(
                          color: _HomeTabColors.headerNavy,
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
                      width: _HomeTabDimens.avatarSize,
                      height: _HomeTabDimens.avatarSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _HomeTabColors.headerBorderWhite,
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
                        width: _HomeTabDimens.notificationBadgeSize,
                        height: _HomeTabDimens.notificationBadgeSize,
                        decoration: BoxDecoration(
                          color: _HomeTabColors.notificationBadge,
                          border: Border.all(
                            color: _HomeTabColors.headerNavy,
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
          const SizedBox(height: _HomeTabDimens.headerGap),
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
