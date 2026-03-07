part of '../wallet_screen.dart';

class _WalletRecentActivity extends StatelessWidget {
  const _WalletRecentActivity({
    required this.transactions,
    required this.onViewAll,
  });

  final List<WalletTransactionModel> transactions;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: GoogleFonts.lexend(
                  fontSize: _WalletDimens.sectionTitleFontSize,
                  fontWeight: FontWeight.w700,
                  height: _WalletDimens.sectionTitleLineHeight / _WalletDimens.sectionTitleFontSize,
                  color: _WalletColors.headingText,
                ),
              ),
              GestureDetector(
                onTap: onViewAll,
                child: Text(
                  'View All',
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 24 / 16,
                    color: _WalletColors.balanceText,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (transactions.isEmpty)
          Padding(
            padding: const EdgeInsets.all(_WalletDimens.activityItemPadding),
            child: Text(
              'No recent activity.',
              style: GoogleFonts.lexend(
                fontSize: 14,
                color: _WalletColors.labelText,
              ),
            ),
          )
        else
          ...transactions.map((tx) {
            final style = _activityStyleForCategory(tx.category);
            final title = tx.description?.isNotEmpty == true ? tx.description! : _titleForCategory(tx.category);
            final subtitle = WalletScreen.formatTransactionTime(tx.timestamp);
            final amount = tx.isCredit ? '+${_formatAmount(tx.amount)}' : '-${_formatAmount(tx.amount.abs())}';
            return Padding(
              padding: const EdgeInsets.only(bottom: _WalletDimens.activityGap),
              child: _ActivityItem(
                icon: style.icon,
                iconBgColor: style.iconBgColor,
                iconColor: style.iconColor,
                title: title,
                subtitle: subtitle,
                amount: amount,
                isCredit: tx.isCredit,
              ),
            );
          }),
      ],
    );
  }

  static String _formatAmount(num value) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    ).format(value);
  }

  static String _titleForCategory(String category) {
    switch (category.toUpperCase()) {
      case 'GROCERY':
        return 'Grocery Order';
      case 'TOP_UP':
        return 'Family Top-up';
      case 'PHARMACY':
      case 'MEDICAL':
        return 'Pharmacy Bill';
      default:
        return 'Transaction';
    }
  }

  static ({IconData icon, Color iconBgColor, Color iconColor}) _activityStyleForCategory(String category) {
    switch (category.toUpperCase()) {
      case 'GROCERY':
        return (
          icon: Icons.shopping_cart_outlined,
          iconBgColor: _WalletColors.activityIconBgBlue,
          iconColor: _WalletColors.activityIconBlue,
        );
      case 'TOP_UP':
        return (
          icon: Icons.favorite_outline,
          iconBgColor: _WalletColors.activityIconBgOrange,
          iconColor: _WalletColors.activityIconOrange,
        );
      case 'PHARMACY':
      case 'MEDICAL':
        return (
          icon: Icons.medical_services_outlined,
          iconBgColor: _WalletColors.activityIconBgBlue,
          iconColor: _WalletColors.activityIconBlue,
        );
      default:
        return (
          icon: Icons.receipt_long_outlined,
          iconBgColor: _WalletColors.activityIconBgBlue,
          iconColor: _WalletColors.activityIconBlue,
        );
    }
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
  });

  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String amount;
  final bool isCredit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_WalletDimens.activityItemPadding),
      decoration: BoxDecoration(
        color: _WalletColors.cardBackground,
        border: Border.all(color: _WalletColors.cardBorder),
        borderRadius: BorderRadius.circular(_WalletDimens.activityItemRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: _WalletDimens.activityIconCircle,
            height: _WalletDimens.activityIconCircle,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: _WalletDimens.activityIconSize,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 23 / 18,
                    color: _WalletColors.headingText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 20 / 14,
                    color: _WalletColors.labelText,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 28 / 18,
              color: isCredit ? _WalletColors.creditGreen : _WalletColors.debitRed,
            ),
          ),
        ],
      ),
    );
  }
}
