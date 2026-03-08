part of '../my_health_history_screen.dart';

class _MyHealthHistoryDetectedPatterns extends StatelessWidget {
  const _MyHealthHistoryDetectedPatterns({this.patterns = const []});

  final List<HealthPatternModel> patterns;

  @override
  Widget build(BuildContext context) {
    if (patterns.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _MyHealthHistoryDimens.screenPaddingHorizontal,
          ),
          child: Text(
            'Detected Patterns',
            style: GoogleFonts.lexend(
              fontSize: _MyHealthHistoryDimens.sectionTitleSize,
              fontWeight: FontWeight.w700,
              height: 28 / 20,
              color: Skin.color(Co.onBackground),
            ),
          ),
        ),
        const SizedBox(height: _MyHealthHistoryDimens.sectionGap),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _MyHealthHistoryDimens.screenPaddingHorizontal,
          ),
          child: Row(
            children: [
              for (int i = 0; i < patterns.length; i++) ...[
                if (i > 0) const SizedBox(width: 16),
                Expanded(
                  child: _PatternCard(
                    badge: (patterns[i].severity ?? '').toUpperCase() == 'HIGH'
                        ? 'ALERT'
                        : 'WARNING',
                    badgeColor:
                        (patterns[i].severity ?? '').toUpperCase() == 'HIGH'
                            ? Skin.color(Co.alert)
                            : Skin.color(Co.warning),
                    title: patterns[i].symptom,
                    detail: patterns[i].frequency,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _PatternCard extends StatelessWidget {
  const _PatternCard({
    required this.badge,
    required this.badgeColor,
    required this.title,
    required this.detail,
  });

  final String badge;
  final Color badgeColor;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: Skin.color(Co.cardSurface),
        border: Border.all(color: Skin.color(Co.borderSubtle)),
        borderRadius: BorderRadius.circular(_MyHealthHistoryDimens.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                badge,
                style: GoogleFonts.lexend(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 16 / 12,
                  letterSpacing: 0.6,
                  color: badgeColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 20 / 16,
              color: Skin.color(Co.onBackground),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            detail,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 20 / 14,
              color: Skin.color(Co.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
