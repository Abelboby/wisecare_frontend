part of '../health_tab_screen.dart';

class _HealthTimeRangeFilter extends StatelessWidget {
  const _HealthTimeRangeFilter();

  static int _hoursFor(_HealthTimeRange range) {
    switch (range) {
      case _HealthTimeRange.sevenDays:
        return 24;
      case _HealthTimeRange.thirtyDays:
      case _HealthTimeRange.threeMonths:
        return 48;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfileProvider, VitalsHistoryProvider>(
      builder: (context, profile, historyProvider, _) {
        final selectedRange =
            _HealthTimeRange.values[historyProvider.selectedRangeIndex.clamp(0, _HealthTimeRange.values.length - 1)];
        final timeRange = historyProvider.history?.timeRange;
        final dateRangeText = _formatDateRange(timeRange?.start, timeRange?.end);

        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _HealthTabColors.cardBg,
            border: Border.all(color: _HealthTabColors.cardBorder),
            borderRadius: BorderRadius.circular(_HealthTabDimens.cardRadius),
            boxShadow: const [
              BoxShadow(
                color: _HealthTabColors.cardShadow,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildChip(
                      context,
                      '7 Days',
                      _HealthTimeRange.sevenDays,
                      selectedRange,
                      profile.profile?.userId ?? '',
                      historyProvider,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _buildChip(
                      context,
                      '30 Days',
                      _HealthTimeRange.thirtyDays,
                      selectedRange,
                      profile.profile?.userId ?? '',
                      historyProvider,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _buildChip(
                      context,
                      '3 Months',
                      _HealthTimeRange.threeMonths,
                      selectedRange,
                      profile.profile?.userId ?? '',
                      historyProvider,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const SizedBox(width: 8),
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: _HealthTabColors.dateRangeText,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      dateRangeText,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 20 / 14,
                        color: _HealthTabColors.dateRangeText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  static String _formatDateRange(String? start, String? end) {
    if (start == null || end == null || start.isEmpty || end.isEmpty) {
      return 'Select range';
    }
    try {
      final s = DateTime.parse(start);
      final e = DateTime.parse(end);
      return '${_formatDate(s)} - ${_formatDate(e)}';
    } catch (_) {
      return 'Select range';
    }
  }

  static String _formatDate(DateTime d) {
    final now = DateTime.now();
    if (d.year == now.year && d.month == now.month && d.day == now.day) {
      return 'Today';
    }
    const months = 'Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec';
    final i = (d.month - 1) * 4;
    final mon = months.substring(i, i + 3);
    return '$mon ${d.day}, ${d.year}';
  }

  Widget _buildChip(
    BuildContext context,
    String label,
    _HealthTimeRange range,
    _HealthTimeRange selectedRange,
    String userId,
    VitalsHistoryProvider historyProvider,
  ) {
    final isSelected = selectedRange == range;
    final hours = _hoursFor(range);
    return GestureDetector(
      onTap: () {
        if (selectedRange == range) return;
        historyProvider.setSelectedRange(range.index, hours);
        if (userId.isNotEmpty) {
          historyProvider.fetchHistory(userId, hours: hours);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: _HealthTabDimens.filterChipPaddingH,
          vertical: _HealthTabDimens.filterChipPaddingV,
        ),
        decoration: BoxDecoration(
          color: isSelected ? _HealthTabColors.filterChipSelectedBg : Colors.transparent,
          borderRadius: BorderRadius.circular(_HealthTabDimens.filterChipRadius),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: _HealthTabColors.cardShadow,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 20 / 14,
            color: isSelected ? _HealthTabColors.filterChipSelectedText : _HealthTabColors.filterChipUnselectedText,
          ),
        ),
      ),
    );
  }
}
