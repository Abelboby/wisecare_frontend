part of '../health_tab_screen.dart';

class _RiskDistributionCard extends StatelessWidget {
  const _RiskDistributionCard();

  @override
  Widget build(BuildContext context) {
    return Consumer<VitalsHistoryProvider>(
      builder: (context, historyProvider, _) {
        final dist = historyProvider.history?.statistics.riskDistribution;
        final count = historyProvider.history?.count ?? 0;
        final total = dist?.total ?? 1;
        final normalPercent = dist != null && total > 0 ? (dist.low / total * 100).round() : 0;
        final mildPercent = dist != null && total > 0 ? (dist.medium / total * 100).round() : 0;
        final highPercent = dist != null && total > 0 ? ((dist.high + dist.critical) / total * 100).round() : 0;

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
                'Risk Distribution',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 28 / 18,
                  color: _HealthTabColors.valuePrimary,
                ),
              ),
              const SizedBox(height: 24),
              _RiskBar(label: 'NORMAL', percent: normalPercent, color: _HealthTabColors.riskNormal),
              const SizedBox(height: _HealthTabDimens.riskRowGap),
              _RiskBar(label: 'MILD CONCERN', percent: mildPercent, color: _HealthTabColors.riskMild),
              const SizedBox(height: _HealthTabDimens.riskRowGap),
              _RiskBar(label: 'HIGH RISK', percent: highPercent, color: _HealthTabColors.riskHigh),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.only(top: 24),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: _HealthTabColors.riskDivider)),
                ),
                child: Center(
                  child: Text(
                    count > 0 ? 'Based on $count data points' : 'Based on 0 data points',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 20 / 14,
                      color: _HealthTabColors.riskFooter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RiskBar extends StatelessWidget {
  const _RiskBar({
    required this.label,
    required this.percent,
    required this.color,
  });

  final String label;
  final int percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: _HealthTabDimens.riskLabelFontSize,
                fontWeight: FontWeight.w600,
                color: _HealthTabColors.riskLabel,
              ),
            ),
            Text(
              '$percent%',
              style: GoogleFonts.lexend(
                fontSize: _HealthTabDimens.riskLabelFontSize,
                fontWeight: FontWeight.w600,
                color: _HealthTabColors.riskValue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(_HealthTabDimens.riskBarRadius),
          child: LinearProgressIndicator(
            value: (percent / 100).clamp(0.0, 1.0),
            minHeight: _HealthTabDimens.riskBarHeight,
            backgroundColor: _HealthTabColors.riskBarTrack,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
