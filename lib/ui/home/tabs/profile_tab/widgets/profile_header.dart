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
      decoration: BoxDecoration(
        color: Skin.color(Co.loginHeader),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(_ProfileTabDimens.headerBorderRadius),
          bottomRight: Radius.circular(_ProfileTabDimens.headerBorderRadius),
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
            _ProfileTabDimens.headerHorizontalPadding,
            _ProfileTabDimens.headerTopPadding,
            _ProfileTabDimens.headerHorizontalPadding,
            _ProfileTabDimens.headerBottomPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ProfileHeaderTopRow(),
              const SizedBox(height: 24),
              _ProfileHeaderAvatarSection(
                name: name,
                memberSince: memberSince,
                imageUrl: imageUrl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeaderTopRow extends StatelessWidget {
  const _ProfileHeaderTopRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _ProfileHeaderBackButton(),
        const SizedBox(width: _ProfileTabDimens.headerTitleLeftPadding),
        Text(
          'Profile',
          style: GoogleFonts.lexend(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 32 / 24,
            color: Skin.color(Co.onPrimary),
          ),
        ),
      ],
    );
  }
}

class _ProfileHeaderBackButton extends StatelessWidget {
  const _ProfileHeaderBackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: _ProfileTabDimens.headerBackButtonSize,
        height: _ProfileTabDimens.headerBackButtonSize,
        decoration: BoxDecoration(
          color: Skin.color(Co.onPrimary).withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          color: Skin.color(Co.onPrimary),
          size: _ProfileTabDimens.headerBackButtonIconSize,
        ),
      ),
    );
  }
}

class _ProfileHeaderAvatarSection extends StatelessWidget {
  const _ProfileHeaderAvatarSection({
    required this.name,
    required this.memberSince,
    required this.imageUrl,
  });

  final String name;
  final String memberSince;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: _ProfileHeaderAvatar(imageUrl: imageUrl),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            name,
            style: GoogleFonts.lexend(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              height: 36 / 30,
              letterSpacing: -0.75,
              color: Skin.color(Co.onPrimary),
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
              color: Skin.color(Co.headerSubtitle),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileHeaderAvatar extends StatelessWidget {
  const _ProfileHeaderAvatar({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
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
              color: Skin.color(Co.surface),
              border: Border.all(
                color: Skin.color(Co.primary).withValues(alpha: 0.5),
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
                      errorBuilder: (_, __, ___) => const _ProfileHeaderAvatarFallback(),
                    )
                  : const _ProfileHeaderAvatarFallback(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeaderAvatarFallback extends StatelessWidget {
  const _ProfileHeaderAvatarFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Skin.color(Co.surface),
      child: Icon(
        Icons.person_rounded,
        size: 80,
        color: Skin.color(Co.textMuted),
      ),
    );
  }
}

