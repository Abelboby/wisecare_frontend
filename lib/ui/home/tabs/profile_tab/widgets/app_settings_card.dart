part of '../profile_tab_screen.dart';

class _AppSettingsSectionTitle extends StatelessWidget {
  const _AppSettingsSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _ProfileTabDimens.sectionTitleLeftPadding,
      ),
      child: Text(
        title,
        style: GoogleFonts.lexend(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 28 / 20,
          color: Skin.color(Co.onBackground),
        ),
      ),
    );
  }
}

class _AppSettingsCard extends StatelessWidget {
  const _AppSettingsCard({
    required this.settings,
    required this.onSettingsChanged,
  });

  final ProfileSettings? settings;
  final Future<void> Function(ProfileSettings) onSettingsChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _AppSettingsSectionTitle(title: 'App Settings'),
        const SizedBox(height: _ProfileTabDimens.sectionGap),
        Container(
          decoration: BoxDecoration(
            color: Skin.color(Co.cardSurface),
            border: Border.all(color: Skin.color(Co.outline)),
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
              _AppSettingsNotificationRow(
                settings: settings,
                onSettingsChanged: onSettingsChanged,
              ),
              const Divider(
                color: Color(0xFFF8FAFC),
                thickness: 1,
                height: 1,
                indent: 20,
                endIndent: 20,
              ),
              _AppSettingsFontSizeRow(settings: settings),
            ],
          ),
        ),
      ],
    );
  }
}

class _AppSettingsNotificationRow extends StatelessWidget {
  const _AppSettingsNotificationRow({
    required this.settings,
    required this.onSettingsChanged,
  });

  final ProfileSettings? settings;
  final Future<void> Function(ProfileSettings) onSettingsChanged;

  @override
  Widget build(BuildContext context) {
    final enabled = settings?.notificationSoundsEnabled ?? true;
    return InkWell(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(_ProfileTabDimens.cardRadius),
      ),
      onTap: () {
        if (settings == null) return;
        onSettingsChanged(
          ProfileSettings(
            notificationSoundsEnabled: !enabled,
            fontSize: settings!.fontSize,
          ),
        );
      },
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
                Icon(
                  Icons.volume_up_rounded,
                  color: Skin.color(Co.textMuted),
                  size: 22.5,
                ),
                const SizedBox(width: _ProfileTabDimens.settingsIconGap),
                Text(
                  'Notification Sounds',
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 28 / 20,
                    color: Skin.color(Co.onBackground),
                  ),
                ),
              ],
            ),
            Switch(
              value: enabled,
              activeColor: Skin.color(Co.primary),
              onChanged: settings == null
                  ? null
                  : (value) {
                      onSettingsChanged(
                        ProfileSettings(
                          notificationSoundsEnabled: value,
                          fontSize: settings!.fontSize,
                        ),
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}

class _AppSettingsFontSizeRow extends StatelessWidget {
  const _AppSettingsFontSizeRow({required this.settings});

  final ProfileSettings? settings;

  @override
  Widget build(BuildContext context) {
    final fontSize = settings?.fontSize ?? '—';
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
                Icon(
                  Icons.text_fields_rounded,
                  color: Skin.color(Co.textMuted),
                  size: 25,
                ),
                const SizedBox(width: _ProfileTabDimens.settingsIconGap),
                Text(
                  'Font Size',
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 28 / 20,
                    color: Skin.color(Co.onBackground),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  fontSize,
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 28 / 18,
                    color: Skin.color(Co.primary),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Skin.color(Co.textMuted),
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
