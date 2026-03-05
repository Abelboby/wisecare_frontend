part of '../meds_tab_screen.dart';

class _MedsDoseSectionHeader extends StatelessWidget {
  const _MedsDoseSectionHeader({
    required this.label,
    required this.time,
    required this.icon,
    required this.iconColor,
  });

  final String label;
  final String time;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: _MedsDimens.doseSectionIconSize,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 32 / 24,
              color: _MedsColors.doseSectionTitle,
            ),
          ),
          const Spacer(),
          Text(
            time,
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 28 / 18,
              color: _MedsColors.doseTimeText,
            ),
          ),
        ],
      ),
    );
  }
}
