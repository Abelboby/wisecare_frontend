part of '../wallet_screen.dart';

class _WalletLimitsSection extends StatelessWidget {
  const _WalletLimitsSection({
    required this.dailyLimit,
    required this.monthlyLimit,
  });

  final WalletLimitModel dailyLimit;
  final WalletLimitModel monthlyLimit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Your Limits',
            style: GoogleFonts.lexend(
              fontSize: _WalletDimens.sectionTitleFontSize,
              fontWeight: FontWeight.w700,
              height: _WalletDimens.sectionTitleLineHeight / _WalletDimens.sectionTitleFontSize,
              color: _WalletColors.headingText,
            ),
          ),
        ),
        const SizedBox(height: _WalletDimens.limitsGap),
        _SpendingLimitCard(
          label: 'Daily Spending',
          spent: dailyLimit.spent,
          limit: dailyLimit.limit,
          remaining: dailyLimit.remaining,
        ),
        const SizedBox(height: _WalletDimens.limitsGap),
        _SpendingLimitCard(
          label: 'Monthly Spending',
          spent: monthlyLimit.spent,
          limit: monthlyLimit.limit,
          remaining: monthlyLimit.remaining,
        ),
      ],
    );
  }
}

class _SpendingLimitCard extends StatelessWidget {
  const _SpendingLimitCard({
    required this.label,
    required this.spent,
    required this.limit,
    required this.remaining,
  });

  final String label;
  final int spent;
  final int limit;
  final int remaining;

  double get _progress => limit > 0 ? spent / limit : 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_WalletDimens.limitCardPadding),
      decoration: BoxDecoration(
        color: _WalletColors.cardBackground,
        border: Border.all(color: _WalletColors.cardBorder),
        borderRadius: BorderRadius.circular(_WalletDimens.limitCardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 24 / 16,
                        color: _WalletColors.labelText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '₹$spent',
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 28 / 20,
                            color: _WalletColors.headingText,
                          ),
                        ),
                        Text(
                          ' / ₹$limit',
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 20 / 14,
                            color: _WalletColors.subText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _WalletColors.remainingBadgeBg,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  '₹$remaining Left',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 20 / 14,
                    color: _WalletColors.remainingBadgeText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: _WalletDimens.limitCardGap),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: SizedBox(
              height: _WalletDimens.progressBarHeight,
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: _WalletColors.progressTrack,
                valueColor: const AlwaysStoppedAnimation<Color>(_WalletColors.progressFill),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
