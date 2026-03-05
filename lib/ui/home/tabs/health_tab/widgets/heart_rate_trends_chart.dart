part of '../health_tab_screen.dart';

class _HeartRateTrendsChart extends StatelessWidget {
  const _HeartRateTrendsChart();

  static const List<_ChartBarData> _bars = [
    _ChartBarData(day: 'Mon', value: 75, isActive: false),
    _ChartBarData(day: 'Tue', value: 88, isActive: false),
    _ChartBarData(day: 'Wed', value: 62, isActive: false),
    _ChartBarData(day: 'Thu', value: 100, isActive: false),
    _ChartBarData(day: 'Fri', value: 75, isActive: false),
    _ChartBarData(day: 'Sat', value: 0, isActive: false),
    _ChartBarData(day: 'Sun', value: 72, isActive: true),
  ];

  static const double _maxValue = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: _HealthTabDimens.chartPaddingHorizontal,
        right: _HealthTabDimens.chartPaddingHorizontal,
        bottom: _HealthTabDimens.chartPaddingBottom,
      ),
      decoration: BoxDecoration(
        color: _HealthTabColors.cardBackground,
        border: Border.all(
          color: _HealthTabColors.cardBorder,
          width: _HealthTabDimens.cardBorderWidth,
        ),
        borderRadius: BorderRadius.circular(_HealthTabDimens.cardRadius),
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
          _buildChartHeader(),
          const SizedBox(height: 24),
          _buildChart(),
        ],
      ),
    );
  }

  Widget _buildChartHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Heart Rate Trends',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 28 / 18,
              color: _HealthTabColors.sectionTitle,
            ),
          ),
          _buildFilterChip(),
        ],
      ),
    );
  }

  Widget _buildFilterChip() {
    return Container(
      height: _HealthTabDimens.chartFilterChipHeight,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: _HealthTabColors.filterChipBg,
        borderRadius: BorderRadius.circular(_HealthTabDimens.chartFilterChipRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Last 7 Days',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 20 / 14,
              color: _HealthTabColors.filterChipText,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: _HealthTabColors.filterChipIcon,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return SizedBox(
      height: 168,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _bars.asMap().entries.map((entry) {
          final index = entry.key;
          final bar = entry.value;
          final isLast = index == _bars.length - 1;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: isLast ? 0 : _HealthTabDimens.chartBarGap / 2,
                left: index == 0 ? 0 : _HealthTabDimens.chartBarGap / 2,
              ),
              child: _ChartBar(
                data: bar,
                maxValue: _maxValue,
                maxBarHeight: _HealthTabDimens.chartMaxBarHeight,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ChartBarData {
  const _ChartBarData({
    required this.day,
    required this.value,
    required this.isActive,
  });

  final String day;
  final double value;
  final bool isActive;
}

class _ChartBar extends StatelessWidget {
  const _ChartBar({
    required this.data,
    required this.maxValue,
    required this.maxBarHeight,
  });

  final _ChartBarData data;
  final double maxValue;
  final double maxBarHeight;

  @override
  Widget build(BuildContext context) {
    final barHeight = data.value == 0 ? 0.0 : (data.value / maxValue) * maxBarHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (data.isActive)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: _HealthTabColors.chartTooltipBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${data.value.toInt()}',
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 16 / 12,
                color: _HealthTabColors.chartTooltipText,
              ),
            ),
          )
        else
          const SizedBox(height: 30),
        Container(
          height: barHeight,
          decoration: BoxDecoration(
            color: data.isActive
                ? const Color(0xFFFF6933).withValues(alpha: 0.4)
                : _HealthTabColors.chartBarFill,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          data.day,
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: data.isActive ? FontWeight.w700 : FontWeight.w500,
            height: 16 / 12,
            color: data.isActive
                ? _HealthTabColors.chartActiveDayLabel
                : _HealthTabColors.chartDayLabel,
          ),
        ),
      ],
    );
  }
}
