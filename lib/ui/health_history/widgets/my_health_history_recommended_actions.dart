part of '../my_health_history_screen.dart';

class _MyHealthHistoryRecommendedActions extends StatelessWidget {
  const _MyHealthHistoryRecommendedActions({
    this.recommendations = const [],
  });

  final List<HealthRecommendationModel> recommendations;

  static IconData _iconForType(String type) {
    switch (type.toUpperCase()) {
      case 'DOCTOR_VISIT':
        return Icons.calendar_today_rounded;
      case 'MEDICATION':
      case 'REFILL':
        return Icons.medication_rounded;
      case 'MONITOR':
        return Icons.monitor_heart_rounded;
      default:
        return Icons.lightbulb_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _MyHealthHistoryDimens.screenPaddingHorizontal,
          ),
          child: Text(
            'Recommended Actions',
            style: GoogleFonts.lexend(
              fontSize: _MyHealthHistoryDimens.sectionTitleSize,
              fontWeight: FontWeight.w700,
              height: 28 / 20,
              color: Skin.color(Co.onBackground),
            ),
          ),
        ),
        const SizedBox(height: _MyHealthHistoryDimens.sectionGap),
        SizedBox(
          height: 88,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: _MyHealthHistoryDimens.screenPaddingHorizontal,
            ),
            children: [
              for (int i = 0; i < recommendations.length; i++) ...[
                if (i > 0) const SizedBox(width: 16),
                _ActionCard(
                  title: recommendations[i].action.isNotEmpty ? recommendations[i].action : recommendations[i].type,
                  subtitle: recommendations[i].reason,
                  icon: _iconForType(recommendations[i].type),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Skin.color(Co.cardSurface),
        border: Border(
          left: BorderSide(
            color: Skin.color(Co.primary),
            width: _MyHealthHistoryDimens.actionCardBorderWidth,
          ),
        ),
        borderRadius: BorderRadius.circular(_MyHealthHistoryDimens.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Skin.color(Co.primaryTint),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Skin.color(Co.primary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 20 / 14,
                    color: Skin.color(Co.onBackground),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 16 / 12,
                    color: Skin.color(Co.textSecondary),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: Skin.color(Co.textSecondary),
            size: 24,
          ),
        ],
      ),
    );
  }
}
