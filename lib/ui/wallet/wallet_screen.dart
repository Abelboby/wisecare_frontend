import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:wisecare_frontend/models/wallet/wallet_limit_model.dart';
import 'package:wisecare_frontend/models/wallet/wallet_transaction_model.dart';
import 'package:wisecare_frontend/provider/profile_provider.dart';
import 'package:wisecare_frontend/provider/wallet_provider.dart';

part 'wallet_variables.dart';
part 'widgets/wallet_header.dart';
part 'widgets/wallet_balance_card.dart';
part 'widgets/wallet_limits_section.dart';
part 'widgets/wallet_topup_section.dart';
part 'widgets/wallet_recent_activity.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();

  /// Formats transaction timestamp for display (e.g. "Today, 10:30 AM", "Yesterday").
  static String formatTransactionTime(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) return '';
    try {
      final dt = DateTime.parse(timestamp).toLocal();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final date = DateTime(dt.year, dt.month, dt.day);
      if (date == today) {
        return 'Today, ${DateFormat.jm().format(dt)}';
      }
      if (date == yesterday) {
        return 'Yesterday';
      }
      final diff = today.difference(date).inDays;
      if (diff < 7) return '$diff days ago';
      return DateFormat.yMMMd().format(dt);
    } catch (_) {
      return timestamp;
    }
  }
}

class _WalletScreenState extends State<WalletScreen> {
  bool _walletLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_walletLoaded) {
      _walletLoaded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.read<WalletProvider>().loadWallet();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _WalletColors.background,
      body: Consumer<WalletProvider>(
        builder: (context, walletProvider, _) {
          if (walletProvider.isLoading && walletProvider.summary == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (walletProvider.errorMessage != null && walletProvider.summary == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  walletProvider.errorMessage!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    color: _WalletColors.headingText,
                  ),
                ),
              ),
            );
          }
          final profile = context.read<ProfileProvider>().profile;
          final userName = profile?.name ?? 'User';
          final summary = walletProvider.summary;
          final accountLabel = summary?.accountLabel ?? 'WISECARE ACCOUNT';
          return Column(
            children: [
              _WalletHeader(userName: userName, accountLabel: accountLabel),
              Expanded(
                child: summary == null
                    ? const SizedBox.shrink()
                    : SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          top: _WalletDimens.contentPaddingVertical,
                          left: _WalletDimens.contentPaddingHorizontal,
                          right: _WalletDimens.contentPaddingHorizontal,
                          bottom: _WalletDimens.contentPaddingVertical,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _WalletBalanceCard(
                              balance: summary.balance,
                              currency: summary.currency,
                            ),
                            const SizedBox(height: _WalletDimens.contentGap),
                            _WalletLimitsSection(
                              dailyLimit: summary.dailyLimit,
                              monthlyLimit: summary.monthlyLimit,
                            ),
                            const SizedBox(height: _WalletDimens.contentGap),
                            _WalletTopupSection(
                              isTopupLoading: walletProvider.isTopupLoading,
                              onRequestTopup: () => _showTopupDialog(context, walletProvider),
                            ),
                            const SizedBox(height: _WalletDimens.contentGap),
                            _WalletRecentActivity(
                              transactions: walletProvider.transactions,
                              onViewAll: () => context.push('/wallet/transactions'),
                            ),
                            const SizedBox(height: 48),
                          ],
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  static void _showTopupDialog(BuildContext context, WalletProvider walletProvider) {
    final amountController = TextEditingController();
    final messageController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            'Request Top-up',
            style: GoogleFonts.lexend(fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Amount (₹)',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _WalletColors.labelText,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'e.g. 1000',
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Message (optional)',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _WalletColors.labelText,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: messageController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'e.g. Need funds for medicines',
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('Cancel', style: GoogleFonts.lexend()),
            ),
            FilledButton(
              onPressed: () async {
                final amountStr = amountController.text.trim();
                final amount = int.tryParse(amountStr);
                if (amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid amount.'),
                    ),
                  );
                  return;
                }
                Navigator.of(dialogContext).pop();
                final successMessage = await walletProvider.requestTopup(
                  amount,
                  messageController.text.trim().isEmpty ? null : messageController.text.trim(),
                );
                if (context.mounted && successMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(successMessage),
                      backgroundColor: _WalletColors.creditGreen,
                    ),
                  );
                }
              },
              child: Text('Request', style: GoogleFonts.lexend()),
            ),
          ],
        );
      },
    );
  }
}
