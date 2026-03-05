part of '../profile_tab_screen.dart';

class _AppSettingsCard extends StatelessWidget {
  const _AppSettingsCard();

  static const String _fontSizeLabel = 'Large';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(),
        const SizedBox(height: _ProfileTabDimens.sectionGap),
        _buildCard(),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _ProfileTabDimens.sectionTitleLeftPadding,
      ),
      child: Text(
        'App Settings',
        style: GoogleFonts.lexend(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 28 / 20,
          color: _ProfileTabColors.sectionTitle,
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      decoration: BoxDecoration(
        color: _ProfileTabColors.cardBackground,
        border: Border.all(color: _ProfileTabColors.cardBorder),
        borderRadius: BorderRadius.circular(_ProfileTabDimens.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildNotificationSoundsRow(),
          const Divider(
            color: _ProfileTabColors.cardDivider,
            thickness: 1,
            height: 1,
            indent: 20,
            endIndent: 20,
          ),
          _buildFontSizeRow(),
        ],
      ),
    );
  }

  Widget _buildNotificationSoundsRow() {
    return InkWell(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(_ProfileTabDimens.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _ProfileTabDimens.settingsRowVerticalPadding,
          vertical: _ProfileTabDimens.settingsRowVerticalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.volume_up_rounded,
                  color: _ProfileTabColors.iconGray,
                  size: 22.5,
                ),
                const SizedBox(width: _ProfileTabDimens.settingsIconGap),
                Text(
                  'Notification Sounds',
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 28 / 20,
                    color: _ProfileTabColors.valueText,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: _ProfileTabColors.chevronGray,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFontSizeRow() {
    return InkWell(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(_ProfileTabDimens.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _ProfileTabDimens.settingsRowVerticalPadding,
          vertical: _ProfileTabDimens.settingsRowVerticalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.text_fields_rounded,
                  color: _ProfileTabColors.iconGray,
                  size: 25,
                ),
                const SizedBox(width: _ProfileTabDimens.settingsIconGap),
                Text(
                  'Font Size',
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 28 / 20,
                    color: _ProfileTabColors.valueText,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  _fontSizeLabel,
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 28 / 18,
                    color: _ProfileTabColors.fontSizeValue,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: _ProfileTabColors.chevronGray,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
