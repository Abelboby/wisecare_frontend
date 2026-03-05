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
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: _ProfileTabDimens.logoutButtonHeight,
          decoration: BoxDecoration(
            color: _ProfileTabColors.logoutButton,
            borderRadius: BorderRadius.circular(_ProfileTabDimens.logoutButtonRadius),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33F27F0D),
                blurRadius: 25,
                offset: Offset(0, 20),
              ),
              BoxShadow(
                color: Color(0x33F27F0D),
                blurRadius: 10,
                offset: Offset(0, 8),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading ? null : onTap,
            borderRadius: BorderRadius.circular(_ProfileTabDimens.logoutButtonRadius),
            child: SizedBox(
              height: _ProfileTabDimens.logoutButtonHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading)
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  else ...[
                    const Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                      size: _ProfileTabDimens.logoutIconSize,
                    ),
                    const SizedBox(width: _ProfileTabDimens.logoutGap),
                    Text(
                      'Logout',
                      style: GoogleFonts.lexend(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 32 / 24,
                        color: _ProfileTabColors.logoutText,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
