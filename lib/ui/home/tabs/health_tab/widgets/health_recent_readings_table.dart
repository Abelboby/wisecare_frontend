part of '../health_tab_screen.dart';

class _RecentReadingsTable extends StatelessWidget {
  const _RecentReadingsTable();

  static const double _blockSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<VitalsHistoryProvider>(
      builder: (context, historyProvider, _) {
        final snapshots = historyProvider.history?.snapshots ?? [];
        final items = _readingItemsFromSnapshots(snapshots);
        if (items.isEmpty) {
          return _buildEmptyCard(context);
        }
        return Container(
          padding: const EdgeInsets.all(_HealthTabDimens.chartPadding),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Significant Readings',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 28 / 18,
                      color: _HealthTabColors.valuePrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ...items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Column(
                  key: ValueKey('$index-${item.timestamp}'),
                  children: [
                    if (index > 0) ...[
                      const SizedBox(height: _blockSpacing),
                      const Divider(height: 1, thickness: 1, color: _HealthTabColors.riskDivider),
                      const SizedBox(height: _blockSpacing),
                    ],
                    _ReadingBlock(
                      icon: item.icon,
                      iconColor: item.iconColor,
                      vitalType: item.vitalType,
                      value: item.value,
                      status: item.status,
                      statusBg: item.statusBg,
                      statusText: item.statusText,
                      timestamp: item.timestamp,
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_HealthTabDimens.chartPadding),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Significant Readings',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 28 / 18,
              color: _HealthTabColors.valuePrimary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No readings in this range.',
            style: GoogleFonts.lexend(
              fontSize: 14,
              color: _HealthTabColors.riskFooter,
            ),
          ),
        ],
      ),
    );
  }

  static List<_ReadingItem> _readingItemsFromSnapshots(
    List<VitalsHistorySnapshot> snapshots,
  ) {
    const maxItems = 5;
    final list = <_ReadingItem>[];
    for (final s in snapshots) {
      if (list.length >= maxItems) break;
      list.add(_ReadingItem(
        vitalType: 'Heart Rate',
        value: '${s.heartRate} BPM',
        status: s.risk,
        timestamp: _formatTimestamp(s.timestamp),
        icon: Icons.favorite_rounded,
        iconColor: _HealthTabColors.iconHeart,
        statusBg: _statusBg(s.risk),
        statusText: _statusText(s.risk),
      ));
      if (list.length >= maxItems) break;
      list.add(_ReadingItem(
        vitalType: 'Blood Pressure',
        value: '${s.bpSystolic}/${s.bpDiastolic}',
        status: s.risk,
        timestamp: _formatTimestamp(s.timestamp),
        icon: Icons.water_drop_outlined,
        iconColor: _HealthTabColors.iconBp,
        statusBg: _statusBg(s.risk),
        statusText: _statusText(s.risk),
      ));
      if (list.length >= maxItems) break;
      list.add(_ReadingItem(
        vitalType: 'SpO2',
        value: '${s.oxygenSaturation.round()}%',
        status: s.risk,
        timestamp: _formatTimestamp(s.timestamp),
        icon: Icons.nightlight_round_outlined,
        iconColor: const Color(0xFFA855F7),
        statusBg: _statusBg(s.risk),
        statusText: _statusText(s.risk),
      ));
    }
    return list;
  }

  static String _formatTimestamp(String iso) {
    try {
      final dt = DateTime.parse(iso);
      final now = DateTime.now();
      if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
        return 'Today ${DateFormat.jm().format(dt)}';
      }
      final yesterday = now.subtract(const Duration(days: 1));
      if (dt.year == yesterday.year && dt.month == yesterday.month && dt.day == yesterday.day) {
        return 'Yesterday ${DateFormat.jm().format(dt)}';
      }
      return DateFormat('MMM d h:mm a').format(dt);
    } catch (_) {
      return iso;
    }
  }

  static Color _statusBg(String risk) {
    switch (risk.toUpperCase()) {
      case 'LOW':
        return _HealthTabColors.statusHealthyBg;
      case 'MEDIUM':
        return _HealthTabColors.statusNormalBg;
      case 'HIGH':
      case 'CRITICAL':
        return _HealthTabColors.statusFeverBg;
      default:
        return _HealthTabColors.statusHealthyBg;
    }
  }

  static Color _statusText(String risk) {
    switch (risk.toUpperCase()) {
      case 'LOW':
        return _HealthTabColors.statusHealthyText;
      case 'MEDIUM':
        return _HealthTabColors.statusNormalText;
      case 'HIGH':
      case 'CRITICAL':
        return _HealthTabColors.statusFeverText;
      default:
        return _HealthTabColors.statusHealthyText;
    }
  }
}

class _ReadingItem {
  _ReadingItem({
    required this.vitalType,
    required this.value,
    required this.status,
    required this.timestamp,
    required this.icon,
    required this.iconColor,
    required this.statusBg,
    required this.statusText,
  });

  final String vitalType;
  final String value;
  final String status;
  final String timestamp;
  final IconData icon;
  final Color iconColor;
  final Color statusBg;
  final Color statusText;
}

class _ReadingBlock extends StatelessWidget {
  const _ReadingBlock({
    required this.icon,
    required this.iconColor,
    required this.vitalType,
    required this.value,
    required this.status,
    required this.statusBg,
    required this.statusText,
    required this.timestamp,
  });

  final IconData icon;
  final Color iconColor;
  final String vitalType;
  final String value;
  final String status;
  final Color statusBg;
  final Color statusText;
  final String timestamp;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                vitalType,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 20 / 14,
                  color: _HealthTabColors.valuePrimary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              value,
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 20 / 14,
                color: _HealthTabColors.valuePrimary,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 0),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: _HealthTabDimens.tableStatusChipPaddingH,
                  vertical: _HealthTabDimens.tableStatusChipPaddingV,
                ),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(_HealthTabDimens.tableStatusChipRadius),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.lexend(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: statusText,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                timestamp,
                style: GoogleFonts.lexend(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 18 / 13,
                  color: _HealthTabColors.riskFooter,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
