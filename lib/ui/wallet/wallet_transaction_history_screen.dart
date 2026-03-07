import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:wisecare_frontend/provider/wallet_provider.dart';
import 'package:wisecare_frontend/ui/wallet/widgets/wallet_transaction_tile.dart';

/// Full transaction history with infinite scroll.
class WalletTransactionHistoryScreen extends StatefulWidget {
  const WalletTransactionHistoryScreen({super.key});

  @override
  State<WalletTransactionHistoryScreen> createState() => _WalletTransactionHistoryScreenState();
}

class _WalletTransactionHistoryScreenState extends State<WalletTransactionHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _initialLoadDone = false;

  static const Color _background = Color(0xFFF8F9FA);
  static const Color _headingText = Color(0xFF0F172A);
  static const Color _labelText = Color(0xFF64748B);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialLoadDone) {
      _initialLoadDone = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.read<WalletProvider>().loadTransactionHistory();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final provider = context.read<WalletProvider>();
    if (!provider.historyHasMore || provider.historyLoadingMore) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      provider.loadMoreTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Transaction History',
          style: GoogleFonts.lexend(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: Consumer<WalletProvider>(
        builder: (context, walletProvider, _) {
          if (walletProvider.historyInitialLoading && walletProvider.historyTransactions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (walletProvider.historyError != null && walletProvider.historyTransactions.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  walletProvider.historyError!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    color: _headingText,
                  ),
                ),
              ),
            );
          }
          final list = walletProvider.historyTransactions;
          if (list.isEmpty) {
            return Center(
              child: Text(
                'No transactions yet.',
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  color: _labelText,
                ),
              ),
            );
          }
          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            itemCount: list.length + (walletProvider.historyHasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= list.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child:
                        walletProvider.historyLoadingMore ? const CircularProgressIndicator() : const SizedBox.shrink(),
                  ),
                );
              }
              final tx = list[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: WalletTransactionTile(transaction: tx),
              );
            },
          );
        },
      ),
    );
  }
}
