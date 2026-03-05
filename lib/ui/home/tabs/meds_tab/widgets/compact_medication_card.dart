part of '../meds_tab_screen.dart';

class _CompactMedicationCard extends StatelessWidget {
  const _CompactMedicationCard({required this.medication});

  final MedicationModel medication;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _MedsColors.cardBackground,
        border: Border.all(color: const Color(0xFFF1F5F9)),
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
            width: _MedsDimens.aspirinImageSize,
            height: _MedsDimens.aspirinImageSize,
            decoration: BoxDecoration(
              color: _MedsColors.aspirinImageBg,
              borderRadius: BorderRadius.circular(_MedsDimens.aspirinImageRadius),
            ),
            child: const Icon(
              Icons.medication_liquid_rounded,
              color: Color(0xFF94A3B8),
              size: 40,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication.name,
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 28 / 20,
                    color: _MedsColors.aspirinNameText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${medication.dosageDisplay} \u2022 ${medication.whenToTake}',
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16,
                    color: _MedsColors.aspirinSubText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: _MedsDimens.aspirinCheckSize,
            height: _MedsDimens.aspirinCheckSize,
            decoration: BoxDecoration(
              border: Border.all(
                color: medication.isTakenToday
                    ? _MedsColors.markTakenIcon
                    : _MedsColors.aspirinCheckBorder,
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: medication.isTakenToday
                  ? _MedsColors.markTakenIcon
                  : _MedsColors.aspirinCheckIcon,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
