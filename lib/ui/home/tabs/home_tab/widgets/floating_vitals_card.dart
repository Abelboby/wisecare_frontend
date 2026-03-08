part of '../home_tab_screen.dart';

class _FloatingVitalsCard extends StatelessWidget {
  const _FloatingVitalsCard();

  @override
  Widget build(BuildContext context) {
    return Consumer<VitalsProvider>(
      builder: (context, vitalsProvider, _) {
        final vitals = vitalsProvider.vitals;
        final heartRate = vitals?.heartRateLabel ?? '--';
        final bp = vitals?.bpLabel ?? '--';
        final risk = vitals?.riskLabel ?? '--';
        final isConnected = vitalsProvider.isConnected;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => context.read<HomeProvider>().switchTab(AppTab.health),
            borderRadius: BorderRadius.circular(_HomeTabDimens.floatingCardRadius),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
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
                          value: heartRate,
                          label: 'BPM',
                        ),
                      ),
                      Container(width: 1, height: 60, color: _HomeTabColors.vitalsDivider),
                      Expanded(
                        child: _VitalsSection(
                          icon: Icons.water_drop_outlined,
                          iconColor: _HomeTabColors.bpIcon,
                          value: bp,
                          label: 'BP',
                        ),
                      ),
                      Container(width: 1, height: 60, color: _HomeTabColors.vitalsDivider),
                      Expanded(
                        child: _VitalsSection(
                          icon: Icons.shield_outlined,
                          iconColor: _HomeTabColors.riskIcon,
                          value: risk,
                          label: 'RISK',
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: _PulsingConnectionIndicator(connected: isConnected),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PulsingConnectionIndicator extends StatefulWidget {
  const _PulsingConnectionIndicator({required this.connected});

  final bool connected;

  @override
  State<_PulsingConnectionIndicator> createState() => _PulsingConnectionIndicatorState();
}

class _PulsingConnectionIndicatorState extends State<_PulsingConnectionIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.connected ? _HomeTabColors.connectionConnected : _HomeTabColors.connectionDisconnected;
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.5),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
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
