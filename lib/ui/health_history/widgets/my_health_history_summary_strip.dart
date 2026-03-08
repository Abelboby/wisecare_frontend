part of '../my_health_history_screen.dart';

class _MyHealthHistorySummaryStrip extends StatelessWidget {
  const _MyHealthHistorySummaryStrip({
    this.totalEvents = 0,
    this.patternsCount = 0,
  });

  final int totalEvents;
  final int patternsCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        _MyHealthHistoryDimens.screenPaddingHorizontal,
        24,
        _MyHealthHistoryDimens.screenPaddingHorizontal,
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryCard(
              label: 'Total Events',
              value: totalEvents.toString(),
            ),
          ),
          const SizedBox(width: _MyHealthHistoryDimens.summaryStripGap),
          Expanded(
            child: _SummaryCard(
              label: 'Patterns',
              value: patternsCount.toString(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_MyHealthHistoryDimens.cardPadding),
      decoration: BoxDecoration(
        color: Skin.color(Co.cardSurface),
        border: Border.all(color: Skin.color(Co.borderSubtle)),
        borderRadius: BorderRadius.circular(_MyHealthHistoryDimens.cardRadius),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 20 / 14,
              color: Skin.color(Co.textSecondary),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.lexend(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              height: 36 / 30,
              color: Skin.color(Co.onBackground),
            ),
          ),
        ],
      ),
    );
  }
}
