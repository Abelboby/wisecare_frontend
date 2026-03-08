part of '../health_tab_screen.dart';

class _HeartRateTrendsChart extends StatelessWidget {
  const _HeartRateTrendsChart();

  static const int _maxPoints = 7;

  @override
  Widget build(BuildContext context) {
    return Consumer<VitalsHistoryProvider>(
      builder: (context, historyProvider, _) {
        final history = historyProvider.history;
        final snapshots = history?.snapshots ?? [];
        final stats = history?.statistics.heartRate;
        final values = snapshots.take(_maxPoints).map((s) => s.heartRate.toDouble()).toList();
        final labels = _labelsFromSnapshots(snapshots.take(_maxPoints).toList());
        final minY = stats?.min ?? (values.isEmpty ? 60.0 : (values.reduce((a, b) => a < b ? a : b) - 5));
        final maxY = stats?.max ?? (values.isEmpty ? 100.0 : (values.reduce((a, b) => a > b ? a : b) + 5));
        final highLabel = stats?.max.round() != null ? 'HIGH: ${stats!.max.round()}' : 'HIGH: —';
        final lowLabel = stats?.min.round() != null ? 'LOW: ${stats!.min.round()}' : 'LOW: —';

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
                    'Heart Rate Trend',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 28 / 18,
                      color: _HealthTabColors.valuePrimary,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: _HealthTabDimens.chartLegendPillPaddingH,
                          vertical: _HealthTabDimens.chartLegendPillPaddingV,
                        ),
                        decoration: BoxDecoration(
                          color: _HealthTabColors.chartPillBg,
                          borderRadius: BorderRadius.circular(_HealthTabDimens.chartLegendPillRadius),
                        ),
                        child: Text(
                          highLabel,
                          style: GoogleFonts.lexend(
                            fontSize: _HealthTabDimens.chartLegendFontSize,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: _HealthTabColors.primaryOrange,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: _HealthTabDimens.chartLegendPillPaddingH,
                          vertical: _HealthTabDimens.chartLegendPillPaddingV,
                        ),
                        decoration: BoxDecoration(
                          color: _HealthTabColors.chartPillMuted,
                          borderRadius: BorderRadius.circular(_HealthTabDimens.chartLegendPillRadius),
                        ),
                        child: Text(
                          lowLabel,
                          style: GoogleFonts.lexend(
                            fontSize: _HealthTabDimens.chartLegendFontSize,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: _HealthTabColors.chartLow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (values.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: SizedBox(
                    height: _HealthTabDimens.chartHeight,
                    child: Center(
                      child: Text(
                        'No heart rate data in this range.',
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          color: _HealthTabColors.riskFooter,
                        ),
                      ),
                    ),
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    SizedBox(
                      height: _HealthTabDimens.chartHeight,
                      child: CustomPaint(
                        painter: _HeartRateLineChartPainter(
                          values: values,
                          maxY: maxY,
                          minY: minY,
                          lineColor: _HealthTabColors.chartHigh,
                          fillColor: _HealthTabColors.primaryOrange.withValues(alpha: 0.2),
                        ),
                        size: Size.infinite,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: labels.map((label) {
                        return Text(
                          label,
                          style: GoogleFonts.lexend(
                            fontSize: _HealthTabDimens.chartAxisFontSize,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            color: _HealthTabColors.chartAxisLabel,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  static List<String> _labelsFromSnapshots(List<VitalsHistorySnapshot> snapshots) {
    if (snapshots.isEmpty) return ['—'];
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final result = <String>[];
    for (var i = 0; i < snapshots.length; i++) {
      try {
        final dt = DateTime.parse(snapshots[i].timestamp);
        result.add(weekdays[dt.weekday - 1]);
      } catch (_) {
        result.add('—');
      }
    }
    while (result.length < _maxPoints) {
      result.add('—');
    }
    return result.take(_maxPoints).toList();
  }
}

class _HeartRateLineChartPainter extends CustomPainter {
  _HeartRateLineChartPainter({
    required this.values,
    required this.maxY,
    required this.minY,
    required this.lineColor,
    required this.fillColor,
  });

  final List<double> values;
  final double maxY;
  final double minY;
  final Color lineColor;
  final Color fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    final range = maxY - minY;
    if (range <= 0) return;
    final stepX = values.length > 1 ? size.width / (values.length - 1) : size.width;
    final points = <Offset>[];
    for (var i = 0; i < values.length; i++) {
      final x = i * stepX;
      final y = size.height - ((values[i] - minY) / range) * size.height;
      points.add(Offset(x, y));
    }
    final fillPath = Path()..moveTo(points.first.dx, size.height);
    for (final p in points) {
      fillPath.lineTo(p.dx, p.dy);
    }
    fillPath.lineTo(points.last.dx, size.height);
    fillPath.close();
    canvas.drawPath(
      fillPath,
      Paint()..color = fillColor,
    );
    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(
      linePath,
      Paint()
        ..color = lineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant _HeartRateLineChartPainter oldDelegate) => oldDelegate.values != values;
}
