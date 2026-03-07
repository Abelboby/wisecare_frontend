part of '../invite_slide_screen.dart';

class _InviteHeader extends StatelessWidget {
  const _InviteHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect Family',
          style: GoogleFonts.lexend(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            height: 38 / 30,
            letterSpacing: -0.75,
            color: OnboardingColors.medicationsTextDark,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        Text(
          'Share this code so your family can connect with you.',
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 29 / 18,
            color: OnboardingColors.textSecondary,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class _InviteIllustration extends StatefulWidget {
  const _InviteIllustration();

  @override
  State<_InviteIllustration> createState() => _InviteIllustrationState();
}

class _InviteIllustrationState extends State<_InviteIllustration> with TickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final AnimationController _pulseController;
  late final AnimationController _badgePulseController;
  late final Animation<double> _pulseAnimation;
  late final Animation<double> _badgePulseAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.92, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _badgePulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _badgePulseAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _badgePulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _badgePulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double overlay = InviteSlideDimens.illustrationSize;
    const double dashed = InviteSlideDimens.dashedCircleSize;
    const double offset = InviteSlideDimens.dashedCircleOffset;
    return Center(
      child: SizedBox(
        width: dashed,
        height: dashed,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              left: offset,
              top: offset,
              width: overlay,
              height: overlay,
              child: Container(
                decoration: BoxDecoration(
                  color: OnboardingColors.medicationsPrimary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              width: dashed,
              height: dashed,
              child: AnimatedBuilder(
                animation: _rotationController,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _rotationController.value * 2 * 3.14159265359,
                    child: child,
                  );
                },
                child: CustomPaint(
                  painter: _DashedCirclePainter(
                    color: OnboardingColors.medicationsPrimary.withValues(alpha: 0.3),
                    strokeWidth: 4,
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: child,
                );
              },
              child: Icon(
                Icons.people_rounded,
                size: InviteSlideDimens.centerIconSize,
                color: OnboardingColors.medicationsPrimary,
              ),
            ),
            Positioned(
              right: offset - 8,
              bottom: offset - 8,
              child: AnimatedBuilder(
                animation: _badgePulseAnimation,
                builder: (BuildContext context, Widget? child) {
                  return Transform.scale(
                    scale: _badgePulseAnimation.value,
                    child: child,
                  );
                },
                child: Container(
                  width: InviteSlideDimens.badgeSize,
                  height: InviteSlideDimens.badgeSize,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: OnboardingColors.medicationsPrimary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        offset: const Offset(0, 10),
                        blurRadius: 15,
                        spreadRadius: -3,
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 6,
                        spreadRadius: -4,
                      ),
                    ],
                  ),
                  child: Icon(Icons.link_rounded, size: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  _DashedCirclePainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2 - strokeWidth / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: r);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    const dashRad = 0.25;
    const gapRad = 0.15;
    const twoPi = 2 * 3.14159265359;
    double start = 0;
    while (start < twoPi) {
      final sweep = (start + dashRad > twoPi) ? twoPi - start : dashRad;
      if (sweep > 0) canvas.drawArc(rect, start, sweep, false, paint);
      start += dashRad + gapRad;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _InviteCodeCard extends StatelessWidget {
  const _InviteCodeCard({
    required this.code,
    this.expiresAt,
    required this.onCopy,
    required this.onShare,
  });

  final String code;
  final String? expiresAt;
  final VoidCallback onCopy;
  final VoidCallback onShare;

  static String _formatExpiresAt(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return 'Expires: ${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return 'Expires: $iso';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: OnboardingColors.surface,
        border: Border.all(
          color: OnboardingColors.medicationsPrimary.withValues(alpha: 0.2),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(InviteSlideDimens.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'YOUR FAMILY ACCESS CODE',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 20 / 14,
              letterSpacing: 1.4,
              color: OnboardingColors.medicationsIconMuted,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: OnboardingColors.medicationsPrimary.withValues(alpha: 0.05),
              border: Border.all(color: OnboardingColors.medicationsPrimary.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              code,
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                height: 40 / 36,
                letterSpacing: 7.2,
                color: OnboardingColors.medicationsPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
          if (expiresAt != null && expiresAt!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              _formatExpiresAt(expiresAt!),
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: OnboardingColors.medicationsTimeChipText,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InviteActionButton(
                  icon: Icons.copy_rounded,
                  label: 'Copy Code',
                  onTap: onCopy,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InviteActionButton(
                  icon: Icons.share_rounded,
                  label: 'Share',
                  onTap: onShare,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InviteActionButton extends StatelessWidget {
  const _InviteActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: OnboardingColors.medicationsPrimary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: OnboardingColors.medicationsPrimary),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 24 / 16,
                color: OnboardingColors.medicationsPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InviteTrustIndicator extends StatelessWidget {
  const _InviteTrustIndicator();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle_outline_rounded,
          size: 16,
          color: OnboardingColors.medicationsTimeChipText,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Your data is secure and only visible to connected family.',
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 16 / 12,
              color: OnboardingColors.medicationsTimeChipText,
            ),
          ),
        ),
      ],
    );
  }
}
