part of '../home_tab_screen.dart';

class _FloatingVitalsCard extends StatelessWidget {
  const _FloatingVitalsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: _HomeTabColors.vitalsCardBg,
        borderRadius: BorderRadius.circular(_HomeTabDimens.floatingCardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 25,
            offset: Offset(0, 20),
          ),
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _VitalsSection(
              icon: Icons.favorite,
              iconColor: _HomeTabColors.heartIcon,
              value: '72',
              label: 'BPM',
            ),
          ),
          Container(width: 1, height: 60, color: _HomeTabColors.vitalsDivider),
          Expanded(
            child: _VitalsSection(
              icon: Icons.water_drop_outlined,
              iconColor: _HomeTabColors.bpIcon,
              value: '120/80',
              label: 'BP',
            ),
          ),
          Container(width: 1, height: 60, color: _HomeTabColors.vitalsDivider),
          Expanded(
            child: _VitalsSection(
              icon: Icons.shield_outlined,
              iconColor: _HomeTabColors.riskIcon,
              value: 'Low',
              label: 'RISK',
            ),
          ),
        ],
      ),
    );
  }
}

class _VitalsSection extends StatelessWidget {
  const _VitalsSection({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.lexend(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 32 / 24,
            color: _HomeTabColors.vitalsValue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 16 / 12,
            letterSpacing: 0.6,
            color: _HomeTabColors.vitalsLabel,
          ),
        ),
      ],
    );
  }
}
