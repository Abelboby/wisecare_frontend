part of '../health_tab_screen.dart';

class _VitalCard extends StatelessWidget {
  const _VitalCard({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.unit,
    this.unitColor,
    this.trendText,
    this.trendColor,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final String value;
  final String unit;
  final Color? unitColor;
  final String? trendText;
  final Color? trendColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_HealthTabDimens.statCardPadding),
      decoration: BoxDecoration(
        color: _HealthTabColors.cardBg,
        border: Border.all(color: _HealthTabColors.cardBorder),
        borderRadius: BorderRadius.circular(_HealthTabDimens.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: _HealthTabColors.cardShadow,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  color: _HealthTabColors.labelMuted,
                ),
              ),
              Icon(icon, color: iconColor, size: _HealthTabDimens.statIconSize),
            ],
          ),
          const SizedBox(height: _HealthTabDimens.statCardGap),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: GoogleFonts.lexend(
                  fontSize: _HealthTabDimens.statValueFontSize,
                  fontWeight: FontWeight.w700,
                  height: 36 / 30,
                  color: _HealthTabColors.valuePrimary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                unit,
                style: GoogleFonts.lexend(
                  fontSize: _HealthTabDimens.statUnitFontSize,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  color: unitColor ?? _HealthTabColors.valueUnitMuted,
                ),
              ),
            ],
          ),
          if (trendText != null && trendText!.isNotEmpty) ...[
            const SizedBox(height: _HealthTabDimens.statCardGap),
            Row(
              children: [
                Text(
                  trendText!,
                  style: GoogleFonts.lexend(
                    fontSize: _HealthTabDimens.statTrendFontSize,
                    fontWeight: FontWeight.w500,
                    height: 16 / 12,
                    color: trendColor ?? _HealthTabColors.trendMuted,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
