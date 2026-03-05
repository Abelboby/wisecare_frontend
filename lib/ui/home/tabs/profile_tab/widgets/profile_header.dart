part of '../profile_tab_screen.dart';

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.name,
    required this.memberSince,
    this.imageUrl,
  });

  final String name;
  final String memberSince;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _ProfileTabColors.navyHeader,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_ProfileTabDimens.headerBorderRadius),
          bottomRight: Radius.circular(_ProfileTabDimens.headerBorderRadius),
        ),
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
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            _ProfileTabDimens.headerHorizontalPadding,
            _ProfileTabDimens.headerTopPadding,
            _ProfileTabDimens.headerHorizontalPadding,
            _ProfileTabDimens.headerBottomPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopRow(context),
              const SizedBox(height: 24),
              _buildAvatarSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      children: [
        _buildBackButton(context),
        const SizedBox(width: _ProfileTabDimens.headerTitleLeftPadding),
        Text(
          'Profile',
          style: GoogleFonts.lexend(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 32 / 24,
            color: _ProfileTabColors.headerTitle,
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: _ProfileTabDimens.headerBackButtonSize,
        height: _ProfileTabDimens.headerBackButtonSize,
        decoration: const BoxDecoration(
          color: _ProfileTabColors.headerBackButtonBg,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          color: _ProfileTabColors.headerTitle,
          size: _ProfileTabDimens.headerBackButtonIconSize,
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Column(
      children: [
        Center(child: _buildAvatar()),
        const SizedBox(height: 16),
        Center(
          child: Text(
            name,
            style: GoogleFonts.lexend(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              height: 36 / 30,
              letterSpacing: -0.75,
              color: _ProfileTabColors.headerTitle,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            memberSince,
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              height: 28 / 18,
              color: _ProfileTabColors.headerSubtitle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: _ProfileTabDimens.avatarSize,
      height: _ProfileTabDimens.avatarSize,
      child: Stack(
        children: [
          Container(
            width: _ProfileTabDimens.avatarSize,
            height: _ProfileTabDimens.avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE2E8F0),
              border: Border.all(
                color: _ProfileTabColors.avatarBorder,
                width: _ProfileTabDimens.avatarBorderWidth,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 25,
                  offset: Offset(0, 20),
                ),
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 10,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: ClipOval(
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      imageUrl!,
                      width: _ProfileTabDimens.avatarImageSize,
                      height: _ProfileTabDimens.avatarImageSize,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildAvatarFallback(),
                    )
                  : _buildAvatarFallback(),
            ),
          ),
          Positioned(
            right: 8,
            bottom: 0,
            child: _buildEditButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarFallback() {
    return Container(
      color: const Color(0xFFE2E8F0),
      child: const Icon(
        Icons.person_rounded,
        size: 80,
        color: Color(0xFF94A3B8),
      ),
    );
  }

  Widget _buildEditButton() {
    return Container(
      width: _ProfileTabDimens.avatarEditButtonSize,
      height: _ProfileTabDimens.avatarEditButtonSize,
      decoration: BoxDecoration(
        color: _ProfileTabColors.avatarEditBg,
        shape: BoxShape.circle,
        border: Border.all(
          color: _ProfileTabColors.avatarEditBorder,
          width: _ProfileTabDimens.avatarEditBorderWidth,
        ),
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
      child: const Icon(
        Icons.edit_rounded,
        color: Colors.white,
        size: _ProfileTabDimens.avatarEditIconSize,
      ),
    );
  }
}
