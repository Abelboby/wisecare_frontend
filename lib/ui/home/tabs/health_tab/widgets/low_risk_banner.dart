part of '../health_tab_screen.dart';

class _LowRiskBanner extends StatelessWidget {
  const _LowRiskBanner({required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: _HealthTabColors.bannerGreen,
        borderRadius: BorderRadius.circular(_HealthTabDimens.bannerRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_HealthTabDimens.bannerRadius),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: 0,
              bottom: 0,
              width: 160,
              child: Transform(
                transform: Matrix4.skewX(-0.21),
                child: Container(
                  decoration: const BoxDecoration(
                    color: _HealthTabColors.bannerOverlay,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(_HealthTabDimens.bannerPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        color: _HealthTabColors.bannerIcon,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'LOW RISK',
                        style: GoogleFonts.lexend(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 32 / 24,
                          letterSpacing: -0.6,
                          color: _HealthTabColors.bannerTitle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your vitals are stable today,\n$userName.',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 28 / 18,
                      color: _HealthTabColors.bannerSubtitle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
