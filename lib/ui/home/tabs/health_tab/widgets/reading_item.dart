part of '../health_tab_screen.dart';

class _ReadingItem extends StatelessWidget {
  const _ReadingItem({
    required this.iconData,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.statusLabel,
  });

  final IconData iconData;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final String value;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_HealthTabDimens.readingItemPadding),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: _HealthTabDimens.readingIconCircleSize,
                height: _HealthTabDimens.readingIconCircleSize,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: iconColor, size: 22),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 28 / 18,
                      color: _HealthTabColors.valuePrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 20 / 14,
                      color: _HealthTabColors.labelText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.lexend(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 28 / 20,
                  color: _HealthTabColors.valuePrimary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: _HealthTabDimens.statusDotSize,
                    height: _HealthTabDimens.statusDotSize,
                    decoration: const BoxDecoration(
                      color: _HealthTabColors.statusGreenDot,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    statusLabel,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 16 / 12,
                      color: _HealthTabColors.statusGreenText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
