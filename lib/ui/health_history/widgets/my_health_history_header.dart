part of '../my_health_history_screen.dart';

class _MyHealthHistoryHeader extends StatelessWidget {
  const _MyHealthHistoryHeader({this.dateRangeLabel = 'Last 30 Days'});

  final String dateRangeLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _MyHealthHistoryDimens.headerHeight,
      decoration: BoxDecoration(
        color: Skin.color(Co.gradientTop),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(_MyHealthHistoryDimens.headerRadius),
          bottomRight: Radius.circular(_MyHealthHistoryDimens.headerRadius),
        ),
        boxShadow: const [
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
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            _MyHealthHistoryDimens.screenPaddingHorizontal,
            0,
            _MyHealthHistoryDimens.screenPaddingHorizontal,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _BackButton(),
                  _TimeHistoryButton(),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'My Health History',
                style: GoogleFonts.lexend(
                  fontSize: _MyHealthHistoryDimens.headerTitleSize,
                  fontWeight: FontWeight.w700,
                  height: 36 / 30,
                  letterSpacing: -0.75,
                  color: Skin.color(Co.onPrimary),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dateRangeLabel,
                style: GoogleFonts.lexend(
                  fontSize: _MyHealthHistoryDimens.headerSubtitleSize,
                  fontWeight: FontWeight.w400,
                  height: 28 / 18,
                  color: Skin.color(Co.onPrimaryMuted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.mounted) {
          context.pop();
        }
      },
      child: Container(
        width: _MyHealthHistoryDimens.headerButtonSize,
        height: _MyHealthHistoryDimens.headerButtonSize,
        decoration: BoxDecoration(
          color: Skin.color(Co.headerButtonOverlay),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Skin.color(Co.onPrimary),
          size: 20,
        ),
      ),
    );
  }
}

class _TimeHistoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.mounted) {
          context.push(AppRoutes.healthTimeline.path);
        }
      },
      child: Container(
        width: _MyHealthHistoryDimens.headerButtonSize,
        height: _MyHealthHistoryDimens.headerButtonSize,
        decoration: BoxDecoration(
          color: Skin.color(Co.headerButtonOverlay),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.calendar_today_rounded,
          color: Skin.color(Co.onPrimary),
          size: 20,
        ),
      ),
    );
  }
}
