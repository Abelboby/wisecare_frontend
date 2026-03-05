part of '../wallet_screen.dart';

class _WalletRecentActivity extends StatelessWidget {
  const _WalletRecentActivity();

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
                style: GoogleFonts.poppins(
                  fontSize: _WalletDimens.sectionTitleFontSize,
                  fontWeight: FontWeight.w700,
                  height: _WalletDimens.sectionTitleLineHeight / _WalletDimens.sectionTitleFontSize,
                  color: _WalletColors.headingText,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View All',
                  style: GoogleFonts.poppins(
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
        const _ActivityItem(
          icon: Icons.shopping_cart_outlined,
          iconBgColor: _WalletColors.activityIconBgBlue,
          iconColor: _WalletColors.activityIconBlue,
          title: 'Grocery Order',
          subtitle: 'Today, 10:30 AM',
          amount: '-₹150',
          isCredit: false,
        ),
        const SizedBox(height: _WalletDimens.activityGap),
        const _ActivityItem(
          icon: Icons.favorite_outline,
          iconBgColor: _WalletColors.activityIconBgOrange,
          iconColor: _WalletColors.activityIconOrange,
          title: 'Family Top-up',
          subtitle: 'Yesterday',
          amount: '+₹1,000',
          isCredit: true,
        ),
        const SizedBox(height: _WalletDimens.activityGap),
        const _ActivityItem(
          icon: Icons.medical_services_outlined,
          iconBgColor: _WalletColors.activityIconBgBlue,
          iconColor: _WalletColors.activityIconBlue,
          title: 'Pharmacy Bill',
          subtitle: '2 days ago',
          amount: '-₹450',
          isCredit: false,
        ),
      ],
    );
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
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 23 / 18,
                    color: _WalletColors.headingText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
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
            style: GoogleFonts.poppins(
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
