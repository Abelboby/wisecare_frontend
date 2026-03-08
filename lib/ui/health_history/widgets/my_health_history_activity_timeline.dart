part of '../my_health_history_screen.dart';

class _MyHealthHistoryActivityTimeline extends StatelessWidget {
  const _MyHealthHistoryActivityTimeline({this.timeline = const []});

  final List<HealthTimelineItemModel> timeline;

  @override
  Widget build(BuildContext context) {
    final List<Widget> columnChildren = [];
    String? lastDate;
    for (final item in timeline) {
      if (lastDate != null && item.date != lastDate) {
        columnChildren.add(const SizedBox(height: 32));
        columnChildren.add(
          _TimelineDateMarker(label: formatDateMarkerLabel(item.date)),
        );
        columnChildren.add(const SizedBox(height: 32));
      }
      lastDate = item.date;
      final isHighConfidence = item.confidence.toUpperCase() == 'HIGH';
      columnChildren.add(
        _TimelineEntry(
          time: formatTimelineDisplayTime(item.date, item.time),
          confidence: formatConfidenceLabel(item.confidence),
          title: item.event,
          source: formatSourceDisplay(item.source),
          dotColor: isHighConfidence ? Skin.color(Co.gradientTop) : Skin.color(Co.timelineMuted),
          icon: timelineIconForSource(item.source),
        ),
      );
      columnChildren.add(const SizedBox(height: 32));
    }
    if (columnChildren.isNotEmpty) columnChildren.removeLast();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _MyHealthHistoryDimens.screenPaddingHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity Timeline',
            style: GoogleFonts.lexend(
              fontSize: _MyHealthHistoryDimens.sectionTitleSize,
              fontWeight: FontWeight.w700,
              height: 28 / 20,
              color: Skin.color(Co.onBackground),
            ),
          ),
          const SizedBox(height: 24),
          if (columnChildren.isEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 48),
              child: Text(
                'No activity in this period.',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  color: Skin.color(Co.textSecondary),
                ),
              ),
            )
          else
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: _MyHealthHistoryDimens.timelineDotSize / 2 - _MyHealthHistoryDimens.timelineLineWidth / 2,
                  top: _MyHealthHistoryDimens.timelineDotSize / 2,
                  bottom: _MyHealthHistoryDimens.timelineDotSize / 2,
                  width: _MyHealthHistoryDimens.timelineLineWidth,
                  child: ColoredBox(
                    color: Skin.color(Co.timelineMuted),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: columnChildren,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _TimelineDateMarker extends StatelessWidget {
  const _TimelineDateMarker({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 48),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Skin.color(Co.contentBackground),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 16 / 12,
                letterSpacing: 1.2,
                color: Skin.color(Co.textTertiary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.time,
    required this.confidence,
    required this.title,
    required this.source,
    required this.dotColor,
    required this.icon,
  });

  final String time;
  final String confidence;
  final String title;
  final String source;
  final Color dotColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: _MyHealthHistoryDimens.timelineDotSize,
              height: _MyHealthHistoryDimens.timelineDotSize,
              decoration: BoxDecoration(
                color: dotColor,
                border: Border.all(
                  color: Skin.color(Co.cardSurface),
                  width: 4,
                ),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 18,
                color: dotColor == Skin.color(Co.gradientTop) ? Skin.color(Co.onPrimary) : Skin.color(Co.textSecondary),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        height: 16 / 12,
                        color: Skin.color(Co.primary),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Skin.color(Co.borderSubtle),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        confidence,
                        style: GoogleFonts.lexend(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          height: 15 / 10,
                          color: Skin.color(Co.textSecondary),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 24 / 16,
                    color: Skin.color(Co.onBackground),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  source,
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 16 / 12,
                    color: Skin.color(Co.textTertiary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
