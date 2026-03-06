part of '../meds_tab_screen.dart';

/// Single card that opens the refill prescription dialog when tapped.
class _RefillPrescriptionCard extends StatelessWidget {
  const _RefillPrescriptionCard({
    required this.onTap,
    this.medicineCount,
  });

  final VoidCallback onTap;
  final int? medicineCount;

  @override
  Widget build(BuildContext context) {
    final subtitle = medicineCount != null && medicineCount! > 0
        ? '$medicineCount ${medicineCount == 1 ? 'medicine' : 'medicines'} to request refill'
        : 'Select medicines to request refill';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _MedsColors.cardBackground,
          border: Border.all(color: const Color(0xFFFFEDD5)),
          borderRadius: BorderRadius.circular(_MedsDimens.cardRadius),
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
              width: _MedsDimens.refillIconCircleSize,
              height: _MedsDimens.refillIconCircleSize,
              decoration: const BoxDecoration(
                color: _MedsColors.refillIconBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: _MedsColors.refillIcon,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Refill prescription',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 28 / 18,
                      color: _MedsColors.refillTitleText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 20 / 14,
                      color: _MedsColors.refillSubText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            const Icon(
              Icons.chevron_right_rounded,
              color: _MedsColors.refillArrow,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
