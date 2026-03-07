part of '../wallet_screen.dart';

class _WalletBalanceCard extends StatelessWidget {
  const _WalletBalanceCard({
    required this.balance,
    required this.currency,
  });

  final num balance;
  final String currency;

  static String _formatAmount(num value) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    ).format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_WalletDimens.balanceCardPadding),
      decoration: BoxDecoration(
        color: _WalletColors.cardBackground,
        border: Border.all(color: _WalletColors.cardBorder),
        borderRadius: BorderRadius.circular(_WalletDimens.balanceCardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Current Balance',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 28 / 18,
              color: _WalletColors.labelText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _formatAmount(balance),
            style: GoogleFonts.lexend(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              height: 60 / 40,
              color: _WalletColors.balanceText,
            ),
          ),
        ],
      ),
    );
  }
}
