import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

part 'wallet_variables.dart';
part 'widgets/wallet_header.dart';
part 'widgets/wallet_balance_card.dart';
part 'widgets/wallet_limits_section.dart';
part 'widgets/wallet_topup_section.dart';
part 'widgets/wallet_recent_activity.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _WalletColors.background,
      body: Column(
        children: [
          const _WalletHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: _WalletDimens.contentPaddingVertical,
                left: _WalletDimens.contentPaddingHorizontal,
                right: _WalletDimens.contentPaddingHorizontal,
                bottom: _WalletDimens.contentPaddingVertical,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _WalletBalanceCard(),
                  SizedBox(height: _WalletDimens.contentGap),
                  _WalletLimitsSection(),
                  SizedBox(height: _WalletDimens.contentGap),
                  _WalletTopupSection(),
                  SizedBox(height: _WalletDimens.contentGap),
                  _WalletRecentActivity(),
                  SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
