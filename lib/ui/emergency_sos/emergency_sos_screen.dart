import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:wisecare_frontend/provider/sos_provider.dart';

part 'emergency_sos_variables.dart';

class EmergencySosScreen extends StatefulWidget {
  const EmergencySosScreen({super.key});

  @override
  State<EmergencySosScreen> createState() => _EmergencySosScreenState();
}

class _EmergencySosScreenState extends State<EmergencySosScreen> {
  SosProvider? _sosProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sosProvider ??= context.read<SosProvider>();
  }

  @override
  void dispose() {
    _sosProvider?.reset();
    super.dispose();
  }

  void _openEmergencyContactsSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _EmergencyContactsSheetContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _EmergencySosColors.bodyBackground,
      body: SafeArea(
        child: Column(
          children: [
            const _EmergencySosHeader(),
            Expanded(
              child: Consumer<SosProvider>(
                builder: (context, provider, _) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: _EmergencySosDimens.contentPaddingHorizontal,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        _GreetingSection(phase: provider.phase),
                        const _SosButtonSection(),
                        const SizedBox(height: _EmergencySosDimens.alertPaddingTop),
                        _StatusFeed(
                          phase: provider.phase,
                          statusMessage: provider.statusMessage,
                          errorMessage: provider.errorMessage,
                          onClearError: () => provider.clearError(),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
            _CollapsedContactsBar(onTap: () => _openEmergencyContactsSheet(context)),
            const _BottomLocationIndicator(),
          ],
        ),
      ),
    );
  }
}

// ─── Header ──────────────────────────────────────────────────────────────────

class _EmergencySosHeader extends StatelessWidget {
  const _EmergencySosHeader();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          padding: const EdgeInsets.all(_EmergencySosDimens.headerPadding),
          decoration: const BoxDecoration(
            color: _EmergencySosColors.headerBackground,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: SizedBox(
                  width: _EmergencySosDimens.backButtonSize,
                  height: _EmergencySosDimens.backButtonSize,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: _EmergencySosDimens.backIconSize,
                    color: _EmergencySosColors.backIcon,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Emergency SOS',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    fontSize: _EmergencySosDimens.sectionTitleFontSize,
                    fontWeight: FontWeight.w700,
                    height: _EmergencySosDimens.sectionTitleLineHeight / _EmergencySosDimens.sectionTitleFontSize,
                    letterSpacing: -0.5,
                    color: _EmergencySosColors.headingText,
                  ),
                ),
              ),
              const SizedBox(width: _EmergencySosDimens.backButtonSize),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Greeting ────────────────────────────────────────────────────────────────

class _GreetingSection extends StatelessWidget {
  const _GreetingSection({required this.phase});

  final SosPhase phase;

  @override
  Widget build(BuildContext context) {
    final bool isActive = phase != SosPhase.idle && phase != SosPhase.holding;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Column(
        key: ValueKey(isActive),
        children: [
          Text(
            isActive ? 'Help is Coming' : 'Need Help, Raghav?',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              fontSize: _EmergencySosDimens.heading1FontSize,
              fontWeight: FontWeight.w700,
              height: _EmergencySosDimens.heading1LineHeight / _EmergencySosDimens.heading1FontSize,
              color: _EmergencySosColors.headingText,
            ),
          ),
          const SizedBox(height: _EmergencySosDimens.instructionGap),
          Text(
            isActive ? 'Stay calm, we are here for you' : 'Press and hold for 3 seconds',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              fontSize: _EmergencySosDimens.instructionFontSize,
              fontWeight: FontWeight.w500,
              height: _EmergencySosDimens.instructionLineHeight / _EmergencySosDimens.instructionFontSize,
              color: _EmergencySosColors.instructionText,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Animated SOS Button ─────────────────────────────────────────────────────

class _SosButtonSection extends StatefulWidget {
  const _SosButtonSection();

  @override
  State<_SosButtonSection> createState() => _SosButtonSectionState();
}

class _SosButtonSectionState extends State<_SosButtonSection> with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _rippleController;
  late final AnimationController _pressController;

  late final Animation<double> _pulseAnim;
  late final Animation<double> _rippleAnim;
  late final Animation<double> _pressAnim;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();

    _rippleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _pressAnim = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rippleController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    final provider = context.read<SosProvider>();
    if (provider.phase != SosPhase.idle) return;
    _pressController.forward();
    provider.startHold();
  }

  void _onPointerUp(PointerUpEvent event) {
    _pressController.reverse();
    context.read<SosProvider>().cancelHold();
  }

  void _onPointerCancel(PointerCancelEvent event) {
    _pressController.reverse();
    context.read<SosProvider>().cancelHold();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Consumer<SosProvider>(
        builder: (context, provider, _) {
          final bool isIdle = provider.phase == SosPhase.idle;
          final bool isHolding = provider.phase == SosPhase.holding;
          final bool isActive = !isIdle && !isHolding && provider.phase != SosPhase.error;

          return Listener(
            onPointerDown: _onPointerDown,
            onPointerUp: _onPointerUp,
            onPointerCancel: _onPointerCancel,
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: _EmergencySosDimens.sosOuterRingSize + 40,
              height: _EmergencySosDimens.sosOuterRingSize + 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (isIdle || isHolding)
                    AnimatedBuilder(
                      animation: _rippleAnim,
                      builder: (context, _) => _RippleRing(
                        progress: _rippleAnim.value,
                      ),
                    ),
                  if (isActive) const _ActivePulseRings(),
                  AnimatedBuilder(
                    animation: _pulseAnim,
                    builder: (context, child) {
                      final scale = isIdle ? _pulseAnim.value : 1.0;
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Container(
                      width: _EmergencySosDimens.sosOuterRingSize,
                      height: _EmergencySosDimens.sosOuterRingSize,
                      decoration: BoxDecoration(
                        color: _EmergencySosColors.sosRingOuter,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Container(
                    width: _EmergencySosDimens.sosInnerRingSize,
                    height: _EmergencySosDimens.sosInnerRingSize,
                    decoration: BoxDecoration(
                      color: _EmergencySosColors.sosRingInner,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (isHolding)
                    SizedBox(
                      width: _EmergencySosDimens.sosButtonSize + 16,
                      height: _EmergencySosDimens.sosButtonSize + 16,
                      child: CircularProgressIndicator(
                        value: provider.holdProgress,
                        strokeWidth: 5,
                        backgroundColor: _EmergencySosColors.holdProgressTrack,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          _EmergencySosColors.holdProgressFill,
                        ),
                      ),
                    ),
                  ScaleTransition(
                    scale: _pressAnim,
                    child: Container(
                      width: _EmergencySosDimens.sosButtonSize,
                      height: _EmergencySosDimens.sosButtonSize,
                      decoration: BoxDecoration(
                        gradient: isActive
                            ? const RadialGradient(
                                colors: [
                                  Color(0xFFFF8A65),
                                  _EmergencySosColors.sosOrange,
                                ],
                              )
                            : null,
                        color: isActive ? null : _EmergencySosColors.sosOrange,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _EmergencySosColors.sosButtonShadow,
                            blurRadius: isActive ? 24 : 15,
                            offset: const Offset(0, 10),
                            spreadRadius: isActive ? 2 : -3,
                          ),
                          BoxShadow(
                            color: _EmergencySosColors.sosButtonShadow.withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                            spreadRadius: -4,
                          ),
                        ],
                      ),
                      child: _SosButtonContent(phase: provider.phase),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Expanding ripple ring that fades out.
class _RippleRing extends StatelessWidget {
  const _RippleRing({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final size = _EmergencySosDimens.sosOuterRingSize + (40 * progress);
    return Opacity(
      opacity: (1.0 - progress).clamp(0.0, 0.5),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _EmergencySosColors.sosOrange,
            width: 2,
          ),
        ),
      ),
    );
  }
}

/// Active state pulsing rings with staggered animations.
class _ActivePulseRings extends StatefulWidget {
  const _ActivePulseRings();

  @override
  State<_ActivePulseRings> createState() => _ActivePulseRingsState();
}

class _ActivePulseRingsState extends State<_ActivePulseRings> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          children: List.generate(3, (i) {
            final delay = i * 0.33;
            final t = (_controller.value + delay) % 1.0;
            final scale = 1.0 + (0.4 * t);
            final opacity = (1.0 - t).clamp(0.0, 0.35);
            return Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: opacity,
                child: Container(
                  width: _EmergencySosDimens.sosOuterRingSize,
                  height: _EmergencySosDimens.sosOuterRingSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _EmergencySosColors.sosOrange,
                      width: 2.5 - (1.5 * t),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Content inside the SOS button: icon + label or spinner.
class _SosButtonContent extends StatelessWidget {
  const _SosButtonContent({required this.phase});

  final SosPhase phase;

  @override
  Widget build(BuildContext context) {
    if (phase == SosPhase.sending) {
      return const Center(
        child: SizedBox(
          width: 36,
          height: 36,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              _EmergencySosColors.white,
            ),
          ),
        ),
      );
    }

    if (phase == SosPhase.completed) {
      return Center(
        child: Icon(
          Icons.check_rounded,
          size: 56,
          color: _EmergencySosColors.white,
        ),
      );
    }

    final bool isActive = phase == SosPhase.alerting ||
        phase == SosPhase.assigned ||
        phase == SosPhase.accepted ||
        phase == SosPhase.rejected ||
        phase == SosPhase.inProgress;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isActive ? Icons.wifi_tethering : Icons.gps_fixed,
          size: 40,
          color: _EmergencySosColors.white,
        ),
        const SizedBox(height: _EmergencySosDimens.sosIconTextGap),
        Text(
          'SOS',
          style: GoogleFonts.lexend(
            fontSize: _EmergencySosDimens.sosButtonFontSize,
            fontWeight: FontWeight.w700,
            height: _EmergencySosDimens.sosButtonLineHeight / _EmergencySosDimens.sosButtonFontSize,
            letterSpacing: 1,
            color: _EmergencySosColors.white,
          ),
        ),
      ],
    );
  }
}

// ─── Status Feed ─────────────────────────────────────────────────────────────

class _StatusFeed extends StatelessWidget {
  const _StatusFeed({
    required this.phase,
    required this.statusMessage,
    required this.errorMessage,
    required this.onClearError,
  });

  final SosPhase phase;
  final String? statusMessage;
  final String? errorMessage;
  final VoidCallback onClearError;

  @override
  Widget build(BuildContext context) {
    if (phase == SosPhase.idle || phase == SosPhase.holding) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 46.3),
        child: Text(
          'This will alert your emergency contacts and local services immediately.',
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
            fontSize: _EmergencySosDimens.alertFontSize,
            fontWeight: FontWeight.w400,
            height: _EmergencySosDimens.alertLineHeight / _EmergencySosDimens.alertFontSize,
            color: _EmergencySosColors.alertText,
          ),
        ),
      );
    }

    return Column(
      children: [
        if (phase == SosPhase.sending)
          _StatusCard(
            icon: Icons.cell_tower,
            iconColor: _EmergencySosColors.sosOrange,
            label: 'Sending SOS signal...',
            bgColor: _EmergencySosColors.statusCardBg,
            borderColor: _EmergencySosColors.statusCardBorder,
            showSpinner: true,
          ),
        if (phase == SosPhase.alerting) ...[
          _StatusCard(
            icon: Icons.cell_tower,
            iconColor: _EmergencySosColors.successGreen,
            label: 'SOS signal sent',
            bgColor: _EmergencySosColors.successCardBg,
            borderColor: _EmergencySosColors.successCardBorder,
            trailing: Icon(Icons.check_circle, size: 18, color: _EmergencySosColors.successGreen),
          ),
          const SizedBox(height: 8),
          _StatusCard(
            icon: Icons.notifications_active,
            iconColor: _EmergencySosColors.sosOrange,
            label: 'Alerting your family...',
            bgColor: _EmergencySosColors.statusCardBg,
            borderColor: _EmergencySosColors.statusCardBorder,
            showSpinner: true,
          ),
        ],
        // ── ASSIGNED ─────────────────────────────────────────────────────────
        if (phase == SosPhase.assigned) ...[
          _StatusCard(
            icon: Icons.cell_tower,
            iconColor: _EmergencySosColors.successGreen,
            label: 'SOS signal sent',
            bgColor: _EmergencySosColors.successCardBg,
            borderColor: _EmergencySosColors.successCardBorder,
            trailing: Icon(Icons.check_circle, size: 18, color: _EmergencySosColors.successGreen),
          ),
          const SizedBox(height: 8),
          _StatusCard(
            icon: Icons.notifications_active,
            iconColor: _EmergencySosColors.successGreen,
            label: 'Family alerted',
            bgColor: _EmergencySosColors.successCardBg,
            borderColor: _EmergencySosColors.successCardBorder,
            trailing: Icon(Icons.check_circle, size: 18, color: _EmergencySosColors.successGreen),
          ),
          const SizedBox(height: 8),
          _StatusCard(
            icon: Icons.local_taxi,
            iconColor: _EmergencySosColors.sosOrange,
            label: statusMessage ?? 'Agent has been assigned!',
            bgColor: _EmergencySosColors.statusCardBg,
            borderColor: _EmergencySosColors.statusCardBorder,
            showSpinner: true,
          ),
        ],

        // ── ACCEPTED ─────────────────────────────────────────────────────────
        if (phase == SosPhase.accepted) ...[
          _StatusCard(
            icon: Icons.cell_tower,
            iconColor: _EmergencySosColors.successGreen,
            label: 'SOS signal sent',
            bgColor: _EmergencySosColors.successCardBg,
            borderColor: _EmergencySosColors.successCardBorder,
            trailing: Icon(Icons.check_circle, size: 18, color: _EmergencySosColors.successGreen),
          ),
          const SizedBox(height: 8),
          _StatusCard(
            icon: Icons.notifications_active,
            iconColor: _EmergencySosColors.successGreen,
            label: 'Family alerted',
            bgColor: _EmergencySosColors.successCardBg,
            borderColor: _EmergencySosColors.successCardBorder,
            trailing: Icon(Icons.check_circle, size: 18, color: _EmergencySosColors.successGreen),
          ),
          const SizedBox(height: 8),
          _StatusCard(
            icon: Icons.directions_run,
            iconColor: _EmergencySosColors.sosOrange,
            label: statusMessage ?? 'Help is confirmed and coming!',
            bgColor: _EmergencySosColors.statusCardBg,
            borderColor: _EmergencySosColors.statusCardBorder,
            showSpinner: true,
          ),
        ],

        // ── REJECTED — being reassigned ──────────────────────────────────────
        if (phase == SosPhase.rejected) ...[
          _StatusCard(
            icon: Icons.cell_tower,
            iconColor: _EmergencySosColors.successGreen,
            label: 'SOS signal sent',
            bgColor: _EmergencySosColors.successCardBg,
            borderColor: _EmergencySosColors.successCardBorder,
            trailing: Icon(Icons.check_circle, size: 18, color: _EmergencySosColors.successGreen),
          ),
          const SizedBox(height: 8),
          _StatusCard(
            icon: Icons.sync,
            iconColor: _EmergencySosColors.sosOrange,
            label: 'This request is being reassigned. Please wait.',
            bgColor: _EmergencySosColors.statusCardBg,
            borderColor: _EmergencySosColors.statusCardBorder,
            showSpinner: true,
          ),
        ],

        // ── IN_PROGRESS ───────────────────────────────────────────────────────
        if (phase == SosPhase.inProgress) ...[
          _StatusCard(
            icon: Icons.cell_tower,
            iconColor: _EmergencySosColors.successGreen,
            label: 'SOS signal sent',
            bgColor: _EmergencySosColors.successCardBg,
            borderColor: _EmergencySosColors.successCardBorder,
            trailing: Icon(Icons.check_circle, size: 18, color: _EmergencySosColors.successGreen),
          ),
          const SizedBox(height: 8),
          _StatusCard(
            icon: Icons.notifications_active,
            iconColor: _EmergencySosColors.successGreen,
            label: 'Family alerted',
            bgColor: _EmergencySosColors.successCardBg,
            borderColor: _EmergencySosColors.successCardBorder,
            trailing: Icon(Icons.check_circle, size: 18, color: _EmergencySosColors.successGreen),
          ),
          const SizedBox(height: 8),
          _StatusCard(
            icon: Icons.local_taxi,
            iconColor: _EmergencySosColors.sosOrange,
            label: 'Help is almost there — stay calm.',
            bgColor: _EmergencySosColors.statusCardBg,
            borderColor: _EmergencySosColors.statusCardBorder,
            showSpinner: true,
          ),
        ],

        // ── COMPLETED ─────────────────────────────────────────────────────────
        if (phase == SosPhase.completed) ...[
          _StatusCard(
            icon: Icons.cell_tower,
            iconColor: _EmergencySosColors.successGreen,
            label: 'SOS signal sent',
            bgColor: _EmergencySosColors.successCardBg,
            borderColor: _EmergencySosColors.successCardBorder,
            trailing: Icon(Icons.check_circle, size: 18, color: _EmergencySosColors.successGreen),
          ),
          const SizedBox(height: 8),
          _StatusCard(
            icon: Icons.notifications_active,
            iconColor: _EmergencySosColors.successGreen,
            label: 'Family alerted',
            bgColor: _EmergencySosColors.successCardBg,
            borderColor: _EmergencySosColors.successCardBorder,
            trailing: Icon(Icons.check_circle, size: 18, color: _EmergencySosColors.successGreen),
          ),
          const SizedBox(height: 8),
          _StatusCard(
            icon: Icons.check_circle,
            iconColor: _EmergencySosColors.successGreen,
            label: "You're safe. The request has been resolved.",
            bgColor: _EmergencySosColors.successCardBg,
            borderColor: _EmergencySosColors.successCardBorder,
            trailing: Icon(Icons.check_circle, size: 18, color: _EmergencySosColors.successGreen),
          ),
        ],
        if (phase == SosPhase.error && errorMessage != null) ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onClearError,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                border: Border.all(color: const Color(0xFFFEE2E2)),
                borderRadius: BorderRadius.circular(_EmergencySosDimens.statusCardRadius),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline,
                      size: _EmergencySosDimens.statusIconSize, color: _EmergencySosColors.contact2Icon),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      errorMessage!,
                      style: GoogleFonts.lexend(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _EmergencySosColors.contact2Icon,
                      ),
                    ),
                  ),
                  Icon(Icons.close, size: 16, color: _EmergencySosColors.contact2Icon),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.bgColor,
    required this.borderColor,
    this.trailing,
    this.showSpinner = false,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final Color bgColor;
  final Color borderColor;
  final Widget? trailing;
  final bool showSpinner;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(_EmergencySosDimens.statusCardRadius),
        ),
        child: Row(
          children: [
            Icon(icon, size: _EmergencySosDimens.statusIconSize, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.lexend(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _EmergencySosColors.headingText,
                ),
              ),
            ),
            if (showSpinner)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                ),
              ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

// ─── Bottom bar / Contacts / Location (unchanged) ───────────────────────────

class _CollapsedContactsBar extends StatelessWidget {
  const _CollapsedContactsBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _EmergencySosColors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(_EmergencySosDimens.bottomSheetRadius),
        topRight: Radius.circular(_EmergencySosDimens.bottomSheetRadius),
      ),
      elevation: 8,
      shadowColor: Colors.black26,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(_EmergencySosDimens.bottomSheetRadius),
          topRight: Radius.circular(_EmergencySosDimens.bottomSheetRadius),
        ),
        child: Container(
          height: _EmergencySosDimens.collapsedBarHeight,
          padding: const EdgeInsets.symmetric(
            horizontal: _EmergencySosDimens.bottomSheetPadding,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_EmergencySosDimens.bottomSheetRadius),
              topRight: Radius.circular(_EmergencySosDimens.bottomSheetRadius),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _EmergencySosDimens.dragHandleWidth,
                height: _EmergencySosDimens.dragHandleHeight,
                decoration: BoxDecoration(
                  color: _EmergencySosColors.dragHandle,
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: _EmergencySosDimens.sectionTitleIconSize,
                    color: _EmergencySosColors.sectionTitleIcon,
                  ),
                  const SizedBox(width: _EmergencySosDimens.sectionTitleGap),
                  Text(
                    'Emergency Contacts',
                    style: GoogleFonts.lexend(
                      fontSize: _EmergencySosDimens.sectionTitleFontSize,
                      fontWeight: FontWeight.w700,
                      height: _EmergencySosDimens.sectionTitleLineHeight / _EmergencySosDimens.sectionTitleFontSize,
                      color: _EmergencySosColors.headingText,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 24,
                    color: _EmergencySosColors.instructionText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmergencyContactsSheetContent extends StatelessWidget {
  const _EmergencyContactsSheetContent();

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Container(
      decoration: const BoxDecoration(
        color: _EmergencySosColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_EmergencySosDimens.bottomSheetRadius),
          topRight: Radius.circular(_EmergencySosDimens.bottomSheetRadius),
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.55,
        minChildSize: 0.35,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return ListView(
            controller: scrollController,
            padding: EdgeInsets.fromLTRB(
              _EmergencySosDimens.bottomSheetPadding,
              _EmergencySosDimens.bottomSheetPadding,
              _EmergencySosDimens.bottomSheetPadding,
              _EmergencySosDimens.bottomSheetPaddingBottom + bottomPadding,
            ),
            children: [
              Center(
                child: Container(
                  width: _EmergencySosDimens.dragHandleWidth,
                  height: _EmergencySosDimens.dragHandleHeight,
                  decoration: BoxDecoration(
                    color: _EmergencySosColors.dragHandle,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.people_outline,
                    size: _EmergencySosDimens.sectionTitleIconSize,
                    color: _EmergencySosColors.sectionTitleIcon,
                  ),
                  const SizedBox(width: _EmergencySosDimens.sectionTitleGap),
                  Text(
                    'Emergency Contacts',
                    style: GoogleFonts.lexend(
                      fontSize: _EmergencySosDimens.sectionTitleFontSize,
                      fontWeight: FontWeight.w700,
                      height: _EmergencySosDimens.sectionTitleLineHeight / _EmergencySosDimens.sectionTitleFontSize,
                      color: _EmergencySosColors.headingText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: _EmergencySosDimens.contactsGap),
              const _ContactCard(
                name: 'Arjun Kumar',
                subtitle: 'Son • +91 98765 43210',
                avatarLabel: 'A',
                backgroundColor: _EmergencySosColors.contact1Background,
                borderColor: _EmergencySosColors.contact1Border,
                callButtonBg: _EmergencySosColors.callButtonGreenBg,
                callButtonIcon: _EmergencySosColors.callButtonGreenIcon,
                showAvatar: true,
              ),
              const SizedBox(height: _EmergencySosDimens.contactsGap),
              const _ContactCard(
                name: 'Emergency Services',
                subtitle: 'Ambulance, Police',
                avatarLabel: null,
                backgroundColor: _EmergencySosColors.contact2Background,
                borderColor: _EmergencySosColors.contact2Border,
                callButtonBg: _EmergencySosColors.callButtonRed,
                callButtonIcon: _EmergencySosColors.white,
                showAvatar: false,
                useShieldIcon: true,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.name,
    required this.subtitle,
    required this.backgroundColor,
    required this.borderColor,
    required this.callButtonBg,
    required this.callButtonIcon,
    required this.showAvatar,
    this.avatarLabel,
    this.useShieldIcon = false,
  });

  final String name;
  final String subtitle;
  final Color backgroundColor;
  final Color borderColor;
  final Color callButtonBg;
  final Color callButtonIcon;
  final bool showAvatar;
  final String? avatarLabel;
  final bool useShieldIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _EmergencySosDimens.contactCardHeight,
      padding: const EdgeInsets.all(_EmergencySosDimens.contactCardPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(_EmergencySosDimens.contactCardRadius),
      ),
      child: Row(
        children: [
          if (showAvatar && avatarLabel != null)
            Container(
              width: _EmergencySosDimens.contactAvatarSize,
              height: _EmergencySosDimens.contactAvatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _EmergencySosColors.avatarBorder,
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  avatarLabel!,
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: _EmergencySosColors.headingText,
                  ),
                ),
              ),
            )
          else if (useShieldIcon)
            Container(
              width: _EmergencySosDimens.contactAvatarSize,
              height: _EmergencySosDimens.contactAvatarSize,
              decoration: BoxDecoration(
                color: _EmergencySosColors.contact2IconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shield,
                color: _EmergencySosColors.contact2Icon,
                size: 26,
              ),
            ),
          if (showAvatar || useShieldIcon) const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.lexend(
                    fontSize: _EmergencySosDimens.contactNameFontSize,
                    fontWeight: FontWeight.w100,
                    height: _EmergencySosDimens.contactNameLineHeight / _EmergencySosDimens.contactNameFontSize,
                    color: _EmergencySosColors.headingText,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.lexend(
                    fontSize: _EmergencySosDimens.contactSubtitleFontSize,
                    fontWeight: FontWeight.w100,
                    height: _EmergencySosDimens.contactSubtitleLineHeight / _EmergencySosDimens.contactSubtitleFontSize,
                    color: _EmergencySosColors.alertText,
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: callButtonBg,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () {},
              customBorder: const CircleBorder(),
              child: Container(
                width: _EmergencySosDimens.contactCallButtonSize,
                height: _EmergencySosDimens.contactCallButtonSize,
                alignment: Alignment.center,
                decoration: useShieldIcon
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _EmergencySosColors.callButtonRedShadow,
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                            spreadRadius: -1,
                          ),
                          BoxShadow(
                            color: _EmergencySosColors.callButtonRedShadow,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                            spreadRadius: -2,
                          ),
                        ],
                      )
                    : null,
                child: Icon(
                  Icons.call,
                  size: 19,
                  color: callButtonIcon,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomLocationIndicator extends StatelessWidget {
  const _BottomLocationIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        _EmergencySosDimens.locationBarPadding,
        0,
        _EmergencySosDimens.locationBarPadding,
        _EmergencySosDimens.locationBarPadding,
      ),
      color: _EmergencySosColors.white,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: _EmergencySosDimens.locationPillPaddingH,
            vertical: _EmergencySosDimens.locationPillPaddingV,
          ),
          decoration: BoxDecoration(
            color: _EmergencySosColors.locationPillBg,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: _EmergencySosDimens.locationIconSize,
                color: _EmergencySosColors.locationText,
              ),
              const SizedBox(width: 8),
              Text(
                'Near Indiranagar, Bengaluru',
                style: GoogleFonts.lexend(
                  fontSize: _EmergencySosDimens.locationFontSize,
                  fontWeight: FontWeight.w500,
                  height: _EmergencySosDimens.locationLineHeight / _EmergencySosDimens.locationFontSize,
                  color: _EmergencySosColors.locationText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
