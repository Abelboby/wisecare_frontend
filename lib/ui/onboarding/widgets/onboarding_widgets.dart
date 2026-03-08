part of '../onboarding_screen.dart';

class _OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _OnboardingAppBar({
    required this.title,
    required this.onBack,
    required this.onSkip,
  });

  final String title;
  final VoidCallback onBack;
  final VoidCallback onSkip;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: OnboardingColors.surface,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(
            left: OnboardingDimens.headerPaddingH,
            right: OnboardingDimens.headerPaddingH,
            top: OnboardingDimens.headerPaddingTop,
            bottom: OnboardingDimens.headerPaddingBottom,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onBack,
                behavior: HitTestBehavior.opaque,
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: OnboardingColors.textPrimary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 22 / 18,
                    letterSpacing: -0.45,
                    color: OnboardingColors.textPrimary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onSkip,
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Text(
                      'Skip',
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: OnboardingColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingBottomBar extends StatelessWidget {
  const _OnboardingBottomBar({
    required this.onSaveAndNext,
    this.isLoading = false,
  });

  final VoidCallback onSaveAndNext;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: OnboardingDimens.bottomButtonPadding,
        vertical: 20,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            OnboardingColors.background,
            OnboardingColors.background,
            Color(0x00F8F9FF),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onSaveAndNext,
          borderRadius: BorderRadius.circular(OnboardingDimens.bottomButtonRadius),
          child: Container(
            height: OnboardingDimens.bottomButtonHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isLoading ? OnboardingColors.primary.withValues(alpha: 0.7) : OnboardingColors.primary,
              borderRadius: BorderRadius.circular(OnboardingDimens.bottomButtonRadius),
              boxShadow: [
                BoxShadow(
                  color: OnboardingColors.primary.withValues(alpha: 0.2),
                  offset: const Offset(0, 10),
                  blurRadius: 15,
                  spreadRadius: -3,
                ),
                BoxShadow(
                  color: OnboardingColors.primary.withValues(alpha: 0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -4,
                ),
              ],
            ),
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Save & Next',
                        style: GoogleFonts.lexend(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 28 / 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.arrow_forward_rounded, size: 20, color: Colors.white),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _InviteSlideFooter extends StatelessWidget {
  const _InviteSlideFooter({
    required this.onComplete,
    this.isLoading = false,
  });

  final VoidCallback onComplete;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            OnboardingColors.background,
            OnboardingColors.background,
            Color(0x00F8F9FF),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onComplete,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isLoading
                  ? OnboardingColors.medicationsPrimary.withValues(alpha: 0.7)
                  : OnboardingColors.medicationsPrimary,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: OnboardingColors.medicationsPrimary.withValues(alpha: 0.2),
                  offset: const Offset(0, 10),
                  blurRadius: 15,
                  spreadRadius: -3,
                ),
                BoxShadow(
                  color: OnboardingColors.medicationsPrimary.withValues(alpha: 0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -4,
                ),
              ],
            ),
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Text(
                    'Complete Onboarding',
                    style: GoogleFonts.lexend(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 28 / 20,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
