part of '../health_tab_screen.dart';

class _VitalCard extends StatelessWidget {
  const _VitalCard({
    required this.icon,
    required this.label,
    required this.value,
    this.valueUnit,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? valueUnit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_HealthTabDimens.vitalCardPadding),
      decoration: BoxDecoration(
        color: _HealthTabColors.cardBackground,
        border: Border.all(
          color: _HealthTabColors.cardBorder,
          width: _HealthTabDimens.cardBorderWidth,
        ),
        borderRadius: BorderRadius.circular(_HealthTabDimens.cardRadius),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: _HealthTabDimens.vitalIconCircleSize,
                height: _HealthTabDimens.vitalIconCircleSize,
                decoration: const BoxDecoration(
                  color: _HealthTabColors.cardIconOrangeBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: _HealthTabColors.cardIconOrange,
                  size: _HealthTabDimens.vitalIconSize,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: _HealthTabColors.normalBadgeBg,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'Normal',
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 16 / 12,
                    color: _HealthTabColors.normalBadgeText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  color: _HealthTabColors.labelText,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.lexend(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      height: 36 / 30,
                      color: _HealthTabColors.valuePrimary,
                    ),
                  ),
                  if (valueUnit != null) ...[
                    const SizedBox(width: 2),
                    Text(
                      valueUnit!,
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 24 / 16,
                        color: _HealthTabColors.valueUnit,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
