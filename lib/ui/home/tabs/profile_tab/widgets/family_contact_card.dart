part of '../profile_tab_screen.dart';

class _FamilyContactCard extends StatelessWidget {
  const _FamilyContactCard({
    required this.name,
    required this.initials,
    required this.relationship,
  });

  final String name;
  final String initials;
  final String relationship;

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
        'Family Contact',
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
      child: Padding(
        padding: const EdgeInsets.all(_ProfileTabDimens.cardPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildInitialsAvatar(),
                const SizedBox(width: _ProfileTabDimens.detailIconGap),
                _buildContactInfo(),
              ],
            ),
            _buildCallButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialsAvatar() {
    return Container(
      width: _ProfileTabDimens.contactAvatarSize,
      height: _ProfileTabDimens.contactAvatarSize,
      decoration: const BoxDecoration(
        color: _ProfileTabColors.contactAvatarBg,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: GoogleFonts.lexend(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 28 / 20,
          color: _ProfileTabColors.contactAvatarText,
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: GoogleFonts.lexend(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 28 / 20,
            color: _ProfileTabColors.valueText,
          ),
        ),
        Text(
          relationship,
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 24 / 16,
            color: _ProfileTabColors.labelText,
          ),
        ),
      ],
    );
  }

  Widget _buildCallButton() {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        color: _ProfileTabColors.callButtonBg,
        shape: BoxShape.circle,
        boxShadow: [
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
      child: const Icon(
        Icons.phone_rounded,
        color: Colors.white,
        size: 22.5,
      ),
    );
  }
}
