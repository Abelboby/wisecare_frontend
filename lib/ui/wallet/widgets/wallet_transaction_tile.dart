import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:wisecare_frontend/models/wallet/wallet_transaction_model.dart';

/// Reusable transaction row for wallet and transaction history screen.
class WalletTransactionTile extends StatelessWidget {
  const WalletTransactionTile({
    super.key,
    required this.transaction,
  });

  final WalletTransactionModel transaction;

  static const double _iconCircleSize = 56;
  static const double _iconSize = 25;
  static const double _itemPadding = 20;
  static const double _itemRadius = 16;
  static const Color _cardBackground = Color(0xFFFFFFFF);
  static const Color _cardBorder = Color(0xFFF1F5F9);
  static const Color _headingText = Color(0xFF0F172A);
  static const Color _labelText = Color(0xFF64748B);
  static const Color _creditGreen = Color(0xFF16A34A);
  static const Color _debitRed = Color(0xFFDC2626);
  static const Color _iconBgBlue = Color(0xFFEFF6FF);
  static const Color _iconBlue = Color(0xFF1A237E);
  static const Color _iconBgOrange = Color(0xFFFFF7ED);
  static const Color _iconOrange = Color(0xFFF57C00);

  static String formatTime(String? timestamp) {
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
      if (date == yesterday) return 'Yesterday';
      final diff = today.difference(date).inDays;
      if (diff < 7) return '$diff days ago';
      return DateFormat.yMMMd().format(dt);
    } catch (_) {
      return timestamp;
    }
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

  static ({IconData icon, Color iconBgColor, Color iconColor}) _styleForCategory(String category) {
    switch (category.toUpperCase()) {
      case 'GROCERY':
        return (icon: Icons.shopping_cart_outlined, iconBgColor: _iconBgBlue, iconColor: _iconBlue);
      case 'TOP_UP':
        return (icon: Icons.favorite_outline, iconBgColor: _iconBgOrange, iconColor: _iconOrange);
      case 'PHARMACY':
      case 'MEDICAL':
        return (icon: Icons.medical_services_outlined, iconBgColor: _iconBgBlue, iconColor: _iconBlue);
      default:
        return (icon: Icons.receipt_long_outlined, iconBgColor: _iconBgBlue, iconColor: _iconBlue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _styleForCategory(transaction.category);
    final title = transaction.description?.isNotEmpty == true
        ? transaction.description!
        : _titleForCategory(transaction.category);
    final subtitle = formatTime(transaction.timestamp);
    final amount =
        transaction.isCredit ? '+${_formatAmount(transaction.amount)}' : '-${_formatAmount(transaction.amount.abs())}';
    final amountColor = transaction.isCredit ? _creditGreen : _debitRed;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_itemPadding),
      decoration: BoxDecoration(
        color: _cardBackground,
        border: Border.all(color: _cardBorder),
        borderRadius: BorderRadius.circular(_itemRadius),
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
            width: _iconCircleSize,
            height: _iconCircleSize,
            decoration: BoxDecoration(
              color: style.iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(style.icon, color: style.iconColor, size: _iconSize),
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
                    color: _headingText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 20 / 14,
                    color: _labelText,
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
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}
