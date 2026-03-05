part of '../home_tab_screen.dart';

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  static const double _gap = 16;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cellSize = (constraints.maxWidth - _gap) / 2;
        final gridHeight = cellSize * 2 + _gap;
        return SizedBox(
          height: gridHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _QuickActionCard(
                        backgroundColor: _HomeTabColors.sosBg,
                        borderColor: _HomeTabColors.sosBorder,
                        iconBackgroundColor: _HomeTabColors.sosIconBg,
                        iconColor: _HomeTabColors.sosIcon,
                        icon: Icons.emergency,
                        label: 'Emergency SOS',
                        textColor: _HomeTabColors.sosText,
                        onTap: () => context.push(AppRoutes.emergencySos.path),
                      ),
                    ),
                    const SizedBox(height: _gap),
                    Expanded(
                      child: _QuickActionCard(
                        backgroundColor: _HomeTabColors.chatBg,
                        borderColor: _HomeTabColors.chatBorder,
                        iconBackgroundColor: _HomeTabColors.chatIconBg,
                        iconColor: _HomeTabColors.chatIcon,
                        icon: Icons.chat_bubble_outline,
                        label: 'Chat with Arya',
                        textColor: _HomeTabColors.chatText,
                        onTap: () => context.push(AppRoutes.chatWithArya.path),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: _gap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _QuickActionCard(
                        backgroundColor: _HomeTabColors.medicineBg,
                        borderColor: _HomeTabColors.medicineBorder,
                        iconBackgroundColor: _HomeTabColors.medicineIconBg,
                        iconColor: _HomeTabColors.medicineIcon,
                        icon: Icons.medication_outlined,
                        label: 'My Medicine',
                        textColor: _HomeTabColors.medicineText,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: _gap),
                    Expanded(
                      child: _QuickActionCard(
                        backgroundColor: _HomeTabColors.vitalsCardBgGreen,
                        borderColor: _HomeTabColors.vitalsCardBorderGreen,
                        iconBackgroundColor: _HomeTabColors.vitalsCardIconBgGreen,
                        iconColor: _HomeTabColors.vitalsCardIconGreen,
                        icon: Icons.favorite,
                        label: 'My Vitals',
                        textColor: _HomeTabColors.vitalsCardTextGreen,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.icon,
    required this.label,
    required this.textColor,
    required this.onTap,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final IconData icon;
  final String label;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(_HomeTabDimens.quickActionCardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_HomeTabDimens.quickActionCardRadius),
        child: Container(
          padding: const EdgeInsets.all(_HomeTabDimens.quickActionCardPadding),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(_HomeTabDimens.quickActionCardRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _HomeTabDimens.quickActionIconSize,
                height: _HomeTabDimens.quickActionIconSize,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(height: _HomeTabDimens.quickActionIconGap),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 22 / 18,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
