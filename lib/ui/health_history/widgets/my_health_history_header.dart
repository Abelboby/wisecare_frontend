part of '../my_health_history_screen.dart';

class _MyHealthHistoryHeader extends StatelessWidget {
  const _MyHealthHistoryHeader({
    this.dateRangeLabel = 'Last 30 Days',
    this.selectedDays = 30,
    this.onDaysChanged,
  });

  final String dateRangeLabel;
  final int selectedDays;
  final void Function(int days)? onDaysChanged;

  static const List<int> _daysOptions = [7, 14, 30];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Skin.color(Co.gradientTop),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(_MyHealthHistoryDimens.headerRadius),
          bottomRight: Radius.circular(_MyHealthHistoryDimens.headerRadius),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            _MyHealthHistoryDimens.screenPaddingHorizontal,
            16,
            _MyHealthHistoryDimens.screenPaddingHorizontal,
            16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BackButton(),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      'My Health History',
                      style: GoogleFonts.lexend(
                        fontSize: _MyHealthHistoryDimens.headerTitleSize,
                        fontWeight: FontWeight.w700,
                        height: 36 / 30,
                        letterSpacing: -0.75,
                        color: Skin.color(Co.onPrimary),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dateRangeLabel,
                      style: GoogleFonts.lexend(
                        fontSize: _MyHealthHistoryDimens.headerSubtitleSize,
                        fontWeight: FontWeight.w400,
                        height: 28 / 18,
                        color: Skin.color(Co.onPrimaryMuted),
                      ),
                    ),
                    if (onDaysChanged != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          for (final days in _daysOptions)
                            Padding(
                              padding: EdgeInsets.only(
                                right: days != _daysOptions.last ? 8 : 0,
                              ),
                              child: GestureDetector(
                                onTap: () => onDaysChanged!(days),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selectedDays == days
                                        ? Skin.color(Co.primary)
                                        : Skin.color(Co.headerButtonOverlay),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '$days days',
                                    style: GoogleFonts.lexend(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Skin.color(Co.onPrimary),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.mounted) {
          context.pop();
        }
      },
      child: Container(
        width: _MyHealthHistoryDimens.headerButtonSize,
        height: _MyHealthHistoryDimens.headerButtonSize,
        decoration: BoxDecoration(
          color: Skin.color(Co.headerButtonOverlay),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Skin.color(Co.onPrimary),
          size: 20,
        ),
      ),
    );
  }
}
