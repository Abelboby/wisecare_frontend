part of '../basic_info_slide_screen.dart';

class _BasicInfoLabel extends StatelessWidget {
  const _BasicInfoLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lexend(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 24 / 16,
        color: OnboardingColors.textPrimary,
      ),
    );
  }
}

class _BasicInfoDatePickerField extends StatelessWidget {
  const _BasicInfoDatePickerField({
    required this.value,
    required this.hint,
    required this.onTap,
  });

  final DateTime? value;
  final String hint;
  final VoidCallback onTap;

  static String _formatDob(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final displayText = value != null ? _formatDob(value!) : null;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: OnboardingDimens.inputHeight,
        decoration: BoxDecoration(
          color: OnboardingColors.surface,
          border: Border.all(color: OnboardingColors.border),
          borderRadius: BorderRadius.circular(OnboardingDimens.inputBorderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 17),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              child: Text(
                displayText ?? hint,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: displayText != null ? OnboardingColors.textPrimary : OnboardingColors.textHint,
                ),
              ),
            ),
            Icon(
              Icons.calendar_today_rounded,
              size: 20,
              color: OnboardingColors.textHint,
            ),
          ],
        ),
      ),
    );
  }
}

class _BasicInfoInput extends StatelessWidget {
  const _BasicInfoInput({
    required this.controller,
    required this.hint,
  });

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: OnboardingDimens.inputHeight,
      decoration: BoxDecoration(
        color: OnboardingColors.surface,
        border: Border.all(color: OnboardingColors.border),
        borderRadius: BorderRadius.circular(OnboardingDimens.inputBorderRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        style: GoogleFonts.lexend(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: OnboardingColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.lexend(fontSize: 18, color: OnboardingColors.textHint),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _BasicInfoInputWithPrefix extends StatelessWidget {
  const _BasicInfoInputWithPrefix({
    required this.controller,
    required this.prefix,
    required this.hint,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String prefix;
  final String hint;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: OnboardingDimens.inputHeight,
      decoration: BoxDecoration(
        color: OnboardingColors.surface,
        border: Border.all(color: OnboardingColors.border),
        borderRadius: BorderRadius.circular(OnboardingDimens.inputBorderRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        children: [
          Text(
            prefix,
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: OnboardingColors.textHint,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: OnboardingColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.lexend(fontSize: 18, color: OnboardingColors.textHint),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BasicInfoTextArea extends StatelessWidget {
  const _BasicInfoTextArea({
    required this.controller,
    required this.hint,
  });

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: OnboardingDimens.textareaHeight,
      decoration: BoxDecoration(
        color: OnboardingColors.surface,
        border: Border.all(color: OnboardingColors.border),
        borderRadius: BorderRadius.circular(OnboardingDimens.inputBorderRadius),
      ),
      padding: const EdgeInsets.all(17),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: GoogleFonts.lexend(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: OnboardingColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.lexend(fontSize: 18, color: OnboardingColors.textHint),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}

class _BasicInfoDropdown extends StatelessWidget {
  const _BasicInfoDropdown({
    required this.value,
    required this.hint,
    required this.options,
    required this.onChanged,
  });

  final String? value;
  final String hint;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: OnboardingDimens.inputHeight,
      decoration: BoxDecoration(
        color: OnboardingColors.surface,
        border: Border.all(color: OnboardingColors.border),
        borderRadius: BorderRadius.circular(OnboardingDimens.inputBorderRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17),
      alignment: Alignment.centerLeft,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value?.isNotEmpty == true ? value : null,
          isExpanded: true,
          hint: Text(
            hint,
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: OnboardingColors.textPrimary,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: OnboardingColors.textHint,
          ),
          items: options.map((s) => DropdownMenuItem<String>(value: s, child: Text(s))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class BasicInfoGenderChip extends StatelessWidget {
  const BasicInfoGenderChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: OnboardingDimens.inputHeight,
        decoration: BoxDecoration(
          color: selected ? OnboardingColors.primary.withValues(alpha: 0.1) : OnboardingColors.surface,
          border: Border.all(
            color: selected ? OnboardingColors.primary : OnboardingColors.border,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(OnboardingDimens.inputBorderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              label == 'Male' ? Icons.male_rounded : Icons.female_rounded,
              size: 16,
              color: selected ? OnboardingColors.primary : OnboardingColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? OnboardingColors.primary : OnboardingColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BasicInfoConditionChip extends StatelessWidget {
  const BasicInfoConditionChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: OnboardingDimens.conditionsTagPaddingV,
          horizontal: OnboardingDimens.conditionsTagPaddingH,
        ),
        decoration: BoxDecoration(
          color: selected ? OnboardingColors.primary.withValues(alpha: 0.1) : OnboardingColors.surface,
          border: Border.all(
            color: selected ? OnboardingColors.primary : OnboardingColors.border,
          ),
          borderRadius: BorderRadius.circular(OnboardingDimens.conditionsTagRadius),
        ),
        child: Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? OnboardingColors.primary : OnboardingColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
