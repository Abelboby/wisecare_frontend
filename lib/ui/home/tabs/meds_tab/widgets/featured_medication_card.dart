part of '../meds_tab_screen.dart';

class _FeaturedMedicationCard extends StatelessWidget {
  const _FeaturedMedicationCard({
    required this.medication,
    required this.onMarkAsTaken,
  });

  final MedicationModel medication;
  final VoidCallback onMarkAsTaken;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FeaturedMedicationImageSection(whenToTake: medication.whenToTake),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      medication.name,
                      style: GoogleFonts.lexend(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 32 / 24,
                        color: _MedsColors.drugNameText,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _MedsColors.dosageBadgeBg,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        medication.dosageDisplay,
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 20 / 14,
                          color: _MedsColors.dosageBadgeText,
                        ),
                      ),
                    ),
                  ],
                ),
                if (medication.instruction != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    medication.instruction!,
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 29 / 18,
                      color: _MedsColors.instructionText,
                    ),
                  ),
                ],
                if (medication.pillsRemaining != null) ...[
                  const SizedBox(height: 8),
                  _MedsLowStockWarning(pillsRemaining: medication.pillsRemaining!),
                ],
                const SizedBox(height: 16),
                _MarkAsTakenButton(onTap: onMarkAsTaken),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedMedicationImageSection extends StatelessWidget {
  const _FeaturedMedicationImageSection({required this.whenToTake});

  final String whenToTake;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _MedsDimens.imageHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE8761A),
                  Color(0xFFC45A0A),
                ],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.medication_rounded,
                color: Colors.white,
                size: 80,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0x99000000),
                    Color(0x00000000),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: _MedsColors.afterBreakfastBadgeBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                whenToTake,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 20 / 14,
                  color: _MedsColors.afterBreakfastBadgeText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedsLowStockWarning extends StatelessWidget {
  const _MedsLowStockWarning({required this.pillsRemaining});

  final int pillsRemaining;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
      decoration: const BoxDecoration(
        color: _MedsColors.warningBg,
        border: Border(
          left: BorderSide(color: _MedsColors.warningBorder, width: 4),
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: _MedsColors.warningIcon,
            size: 22,
          ),
          const SizedBox(width: 12),
          Text(
            '$pillsRemaining pills left - Reorder soon',
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 24 / 16,
              color: _MedsColors.warningText,
            ),
          ),
        ],
      ),
    );
  }
}

class _MarkAsTakenButton extends StatelessWidget {
  const _MarkAsTakenButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: _MedsColors.markTakenBorder, width: 2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                color: _MedsColors.markTakenIcon,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Mark as Taken',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 28 / 18,
                  color: _MedsColors.markTakenText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
