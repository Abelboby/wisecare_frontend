part of '../health_tab_screen.dart';

class _BloodPressureTrendCard extends StatelessWidget {
  const _BloodPressureTrendCard();

  static const int _maxPoints = 7;

  @override
  Widget build(BuildContext context) {
    return Consumer<VitalsHistoryProvider>(
      builder: (context, historyProvider, _) {
        final snapshots = historyProvider.history?.snapshots ?? [];
        final systolicValues = snapshots.take(_maxPoints).map((s) => s.bpSystolic.toDouble()).toList();
        final diastolicValues = snapshots.take(_maxPoints).map((s) => s.bpDiastolic.toDouble()).toList();
        final labels = _axisLabels(snapshots.take(_maxPoints).toList());
        final hasData = systolicValues.isNotEmpty;

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
                    'Blood Pressure (Systolic)',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 28 / 18,
                      color: _HealthTabColors.valuePrimary,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: _HealthTabColors.chartLineSystolic,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'SYSTOLIC',
                            style: GoogleFonts.lexend(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _HealthTabColors.riskLabel,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: _HealthTabColors.chartLineDiastolic,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'DIASTOLIC',
                            style: GoogleFonts.lexend(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _HealthTabColors.riskLabel,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (!hasData)
                SizedBox(
                  height: _HealthTabDimens.chartHeight,
                  child: Center(
                    child: Text(
                      'No blood pressure data in this range.',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        color: _HealthTabColors.riskFooter,
                      ),
                    ),
                  ),
                )
              else
                SizedBox(
                  height: _HealthTabDimens.chartHeight,
                  child: CustomPaint(
                    painter: _BloodPressureChartPainter(
                      systolicValues: systolicValues,
                      diastolicValues: diastolicValues,
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
        );
      },
    );
  }

  static List<String> _axisLabels(List<VitalsHistorySnapshot> snapshots) {
    if (snapshots.isEmpty) return ['—'];
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final result = <String>[];
    for (var i = 0; i < snapshots.length && i < _maxPoints; i++) {
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

class _BloodPressureChartPainter extends CustomPainter {
  _BloodPressureChartPainter({
    required this.systolicValues,
    required this.diastolicValues,
  });

  final List<double> systolicValues;
  final List<double> diastolicValues;

  @override
  void paint(Canvas canvas, Size size) {
    if (systolicValues.isEmpty || diastolicValues.isEmpty) return;
    final n = systolicValues.length;
    if (n == 0) return;
    final sysMin = systolicValues.reduce((a, b) => a < b ? a : b);
    final sysMax = systolicValues.reduce((a, b) => a > b ? a : b);
    final diaMin = diastolicValues.reduce((a, b) => a < b ? a : b);
    final diaMax = diastolicValues.reduce((a, b) => a > b ? a : b);
    final yMin = (diaMin < sysMin ? diaMin : sysMin) - 5;
    final yMax = (diaMax > sysMax ? diaMax : sysMax) + 5;
    final range = yMax - yMin;
    if (range <= 0) return;
    final stepX = n > 1 ? size.width / (n - 1) : size.width;

    final systolicPoints = <Offset>[];
    final diastolicPoints = <Offset>[];
    for (var i = 0; i < n; i++) {
      final x = i * stepX;
      systolicPoints.add(Offset(
        x,
        size.height - ((systolicValues[i] - yMin) / range) * size.height,
      ));
      diastolicPoints.add(Offset(
        x,
        size.height - ((diastolicValues[i] - yMin) / range) * size.height,
      ));
    }

    final systolicPath = Path()..moveTo(systolicPoints.first.dx, systolicPoints.first.dy);
    for (var i = 1; i < systolicPoints.length; i++) {
      systolicPath.lineTo(systolicPoints[i].dx, systolicPoints[i].dy);
    }
    final diastolicPath = Path()..moveTo(diastolicPoints.first.dx, diastolicPoints.first.dy);
    for (var i = 1; i < diastolicPoints.length; i++) {
      diastolicPath.lineTo(diastolicPoints[i].dx, diastolicPoints[i].dy);
    }
    final dashPaint = Paint()
      ..color = _HealthTabColors.chartLineDiastolic
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final solidPaint = Paint()
      ..color = _HealthTabColors.chartLineSystolic
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;
    canvas.drawPath(diastolicPath, dashPaint);
    canvas.drawPath(systolicPath, solidPaint);
  }

  @override
  bool shouldRepaint(covariant _BloodPressureChartPainter oldDelegate) =>
      oldDelegate.systolicValues != systolicValues || oldDelegate.diastolicValues != diastolicValues;
}
