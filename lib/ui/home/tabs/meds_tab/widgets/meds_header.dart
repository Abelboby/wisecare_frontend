part of '../meds_tab_screen.dart';

class _MedsHeader extends StatelessWidget {
  const _MedsHeader();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topInset + 16,
        left: _MedsDimens.headerPaddingHorizontal,
        right: _MedsDimens.headerPaddingHorizontal,
        bottom: _MedsDimens.headerPaddingBottom,
      ),
      decoration: const BoxDecoration(
        color: _MedsColors.headerNavy,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _MedsBackButton(),
          Expanded(
            child: Center(
              child: Text(
                'My Medicines',
                style: GoogleFonts.lexend(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 32 / 24,
                  letterSpacing: 0.6,
                  color: _MedsColors.headerTitle,
                ),
              ),
            ),
          ),
          const SizedBox(width: _MedsDimens.headerBackButtonSize),
        ],
      ),
    );
  }
}

class _MedsBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<HomeProvider>().switchTab(AppTab.home),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: _MedsColors.headerButtonBg,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.chevron_left_rounded,
          color: _MedsColors.headerIcon,
          size: 28,
        ),
      ),
    );
  }
}
