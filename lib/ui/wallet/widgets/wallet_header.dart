part of '../wallet_screen.dart';

class _WalletHeader extends StatelessWidget {
  const _WalletHeader({
    required this.userName,
    required this.accountLabel,
  });

  final String userName;
  final String accountLabel;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topInset + _WalletDimens.headerPaddingTop,
        left: _WalletDimens.headerPaddingHorizontal,
        right: _WalletDimens.headerPaddingHorizontal,
        bottom: _WalletDimens.headerPaddingBottom,
      ),
      decoration: const BoxDecoration(
        color: _WalletColors.headerNavy,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_WalletDimens.headerBottomRadius),
          bottomRight: Radius.circular(_WalletDimens.headerBottomRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: const SizedBox(
                  width: 44,
                  height: 44,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'My Wallet',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 32 / 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 44),
            ],
          ),
          const SizedBox(height: _WalletDimens.headerGap),
          Text(
            'Namaste, ${userName.trim().isNotEmpty ? userName : 'User'} ji',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              height: 28 / 18,
              color: _WalletColors.greetingText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            accountLabel,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 16 / 12,
              letterSpacing: 1.2,
              color: _WalletColors.accountLabel,
            ),
          ),
        ],
      ),
    );
  }
}
