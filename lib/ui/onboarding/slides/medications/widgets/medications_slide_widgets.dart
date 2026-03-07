part of '../medications_slide_screen.dart';

class _MedicationsSectionHeader extends StatelessWidget {
  const _MedicationsSectionHeader({required this.onAddNew});

  final VoidCallback onAddNew;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Current Medications',
          style: GoogleFonts.lexend(
            fontSize: MedicationsDimens.sectionTitleSize,
            fontWeight: FontWeight.w700,
            height: 32 / 24,
            color: OnboardingColors.medicationsTextDark,
          ),
        ),
      ],
    );
  }
}

class _MedicationCard extends StatelessWidget {
  const _MedicationCard({required this.entry, required this.onDelete});

  final MedicationEntry entry;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MedicationsDimens.cardPadding),
      decoration: BoxDecoration(
        color: OnboardingColors.surface,
        border: Border(
          left: BorderSide(
            width: MedicationsDimens.cardLeftBorderWidth,
            color: OnboardingColors.medicationsPrimary,
          ),
        ),
        borderRadius: BorderRadius.circular(MedicationsDimens.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MedicationsDimens.pillIconBgSize,
            height: MedicationsDimens.pillIconBgSize,
            decoration: BoxDecoration(
              color: OnboardingColors.medicationsPrimary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.medication_rounded,
              size: MedicationsDimens.pillIconSize,
              color: OnboardingColors.medicationsPrimary,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 28 / 20,
                    color: OnboardingColors.medicationsTextDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${entry.dosage} • ${entry.frequency}',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 28 / 18,
                    color: OnboardingColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: entry.times
                      .map((String t) => Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: MedicationsDimens.timeChipPaddingV,
                              horizontal: MedicationsDimens.timeChipPaddingH,
                            ),
                            decoration: BoxDecoration(
                              color: OnboardingColors.medicationsTimeChipBg,
                              borderRadius: BorderRadius.circular(MedicationsDimens.timeChipRadius),
                            ),
                            child: Text(
                              t,
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 20 / 14,
                                color: OnboardingColors.medicationsTimeChipText,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onDelete,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.delete_outline_rounded,
                size: 22,
                color: OnboardingColors.medicationsIconMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddMedicationForm extends StatelessWidget {
  const _AddMedicationForm({
    required this.nameController,
    required this.dosageController,
    required this.frequency,
    required this.onFrequencyChanged,
    required this.preferredTime,
    required this.onTimeTap,
    required this.onAddAnother,
  });

  final TextEditingController nameController;
  final TextEditingController dosageController;
  final String frequency;
  final ValueChanged<String?> onFrequencyChanged;
  final TimeOfDay preferredTime;
  final VoidCallback onTimeTap;
  final VoidCallback onAddAnother;

  @override
  Widget build(BuildContext context) {
    final timeStr = '${preferredTime.hourOfPeriod == 0 ? 12 : preferredTime.hourOfPeriod}'
        ':${preferredTime.minute.toString().padLeft(2, '0')} '
        '${preferredTime.period == DayPeriod.am ? 'AM' : 'PM'}';
    return Container(
      padding: const EdgeInsets.all(MedicationsDimens.mainPaddingV),
      decoration: BoxDecoration(
        color: OnboardingColors.surface,
        border: Border.all(color: OnboardingColors.border),
        borderRadius: BorderRadius.circular(MedicationsDimens.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.add_circle_outline_rounded, size: 20, color: OnboardingColors.medicationsPrimary),
              const SizedBox(width: 8),
              Text(
                'Add Medication Details',
                style: GoogleFonts.lexend(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 28 / 20,
                  color: OnboardingColors.medicationsTextDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: MedicationsDimens.mainGap),
          const _MedicationsFormLabel('Medication Name'),
          const SizedBox(height: 8),
          _MedicationsInput(controller: nameController, hint: 'e.g., Aspirin'),
          const SizedBox(height: MedicationsDimens.mainGap),
          const _MedicationsFormLabel('Dosage'),
          const SizedBox(height: 8),
          _MedicationsInput(controller: dosageController, hint: 'e.g., 500mg'),
          const SizedBox(height: MedicationsDimens.mainGap),
          const _MedicationsFormLabel('Frequency'),
          const SizedBox(height: 8),
          _MedicationsDropdown(
            value: frequency,
            options: _frequencyOptions,
            onChanged: onFrequencyChanged,
          ),
          const SizedBox(height: MedicationsDimens.mainGap),
          const _MedicationsFormLabel('Preferred Time'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTimeTap,
            child: Container(
              height: MedicationsDimens.formInputHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: OnboardingColors.medicationsInputBg,
                border: Border.all(color: OnboardingColors.border, width: 2),
                borderRadius: BorderRadius.circular(MedicationsDimens.formInputRadius),
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    timeStr,
                    style: GoogleFonts.lexend(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 28 / 20,
                      color: OnboardingColors.medicationsTextDark,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.keyboard_arrow_down_rounded, color: OnboardingColors.medicationsHint),
                ],
              ),
            ),
          ),
          const SizedBox(height: MedicationsDimens.mainGap),
          GestureDetector(
            onTap: onAddAnother,
            child: Container(
              height: MedicationsDimens.addAnotherButtonHeight,
              decoration: BoxDecoration(
                color: OnboardingColors.medicationsAddButtonBg,
                border: Border.all(color: OnboardingColors.medicationsDashedBorder, width: 2),
                borderRadius: BorderRadius.circular(MedicationsDimens.formInputRadius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_rounded, size: 20, color: OnboardingColors.medicationsAddButtonText),
                  const SizedBox(width: 12),
                  Text(
                    'Add Medication',
                    style: GoogleFonts.lexend(
                      fontSize: MedicationsDimens.formLabelSize,
                      fontWeight: FontWeight.w700,
                      height: 28 / 18,
                      color: OnboardingColors.medicationsAddButtonText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicationsFormLabel extends StatelessWidget {
  const _MedicationsFormLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lexend(
        fontSize: MedicationsDimens.formLabelSize,
        fontWeight: FontWeight.w600,
        height: 28 / 18,
        color: OnboardingColors.medicationsTextDark,
      ),
    );
  }
}

class _MedicationsInput extends StatelessWidget {
  const _MedicationsInput({required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MedicationsDimens.formInputHeight,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18.5),
      decoration: BoxDecoration(
        color: OnboardingColors.medicationsInputBg,
        border: Border.all(color: OnboardingColors.border, width: 2),
        borderRadius: BorderRadius.circular(MedicationsDimens.formInputRadius),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.lexend(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          height: 22 / 18,
          color: OnboardingColors.medicationsTextDark,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 22 / 18,
            color: OnboardingColors.medicationsHint,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _MedicationsDropdown extends StatelessWidget {
  const _MedicationsDropdown({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MedicationsDimens.formInputHeight,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: OnboardingColors.medicationsInputBg,
        border: Border.all(color: OnboardingColors.border, width: 2),
        borderRadius: BorderRadius.circular(MedicationsDimens.formInputRadius),
      ),
      alignment: Alignment.centerLeft,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: OnboardingColors.medicationsHint),
          items: options.map((s) => DropdownMenuItem<String>(value: s, child: Text(s))).toList(),
          onChanged: onChanged,
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 28 / 18,
            color: OnboardingColors.medicationsTextDark,
          ),
        ),
      ),
    );
  }
}
