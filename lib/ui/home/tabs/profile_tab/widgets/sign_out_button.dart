part of '../profile_tab_screen.dart';

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({
    required this.isLoading,
    required this.onTap,
  });

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppThemeMode>(
      valueListenable: Skin.themeMode,
      builder: (_, __, ___) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: Skin.color(Co.primary),
                borderRadius: BorderRadius.circular(_ProfileTabDimens.buttonRadius),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4DFF6933),
                    blurRadius: 15,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Color(0x4DFF6933),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isLoading ? null : onTap,
                borderRadius: BorderRadius.circular(_ProfileTabDimens.buttonRadius),
                child: Container(
                  height: 56,
                  alignment: Alignment.center,
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Sign out',
                          style: GoogleFonts.lexend(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 28 / 18,
                          ),
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
