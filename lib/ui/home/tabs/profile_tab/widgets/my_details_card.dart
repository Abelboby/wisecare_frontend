part of '../profile_tab_screen.dart';

class _MyDetailsSectionTitle extends StatelessWidget {
  const _MyDetailsSectionTitle({required this.title});

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

class _MyDetailsCard extends StatelessWidget {
  const _MyDetailsCard({
    required this.age,
    required this.city,
    this.cityImageUrl,
    this.onEditAge,
    this.onEditCity,
  });

  final String? age;
  final String? city;
  final String? cityImageUrl;
  final VoidCallback? onEditAge;
  final VoidCallback? onEditCity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _MyDetailsSectionTitle(title: 'My Details'),
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
          child: Padding(
            padding: const EdgeInsets.all(_ProfileTabDimens.cardPadding),
            child: Column(
              children: [
                _MyDetailsAgeRow(age: age, onTap: onEditAge),
                const Divider(
                  color: Color(0xFFF8FAFC),
                  thickness: 1,
                  height: 1,
                ),
                _MyDetailsCityRow(
                  city: city,
                  cityImageUrl: cityImageUrl,
                  onTap: onEditCity,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MyDetailsAgeRow extends StatelessWidget {
  const _MyDetailsAgeRow({required this.age, this.onTap});

  final String? age;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(
        vertical: _ProfileTabDimens.detailRowVerticalPadding,
      ),
      child: Row(
        children: [
          Icon(
            Icons.cake_rounded,
            color: Skin.color(Co.primary),
            size: 24,
          ),
          const SizedBox(width: _ProfileTabDimens.detailIconGap),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Age',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  color: Skin.color(Co.textMuted),
                ),
              ),
              Text(
                age ?? '—',
                style: GoogleFonts.lexend(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 28 / 20,
                  color: Skin.color(Co.onBackground),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: row,
      );
    }
    return row;
  }
}

class _MyDetailsCityRow extends StatelessWidget {
  const _MyDetailsCityRow({
    required this.city,
    required this.cityImageUrl,
    this.onTap,
  });

  final String? city;
  final String? cityImageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(
        vertical: _ProfileTabDimens.detailRowVerticalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: Skin.color(Co.primary),
                size: 24,
              ),
              const SizedBox(width: _ProfileTabDimens.detailIconGap),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'City',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 20 / 14,
                      color: Skin.color(Co.textMuted),
                    ),
                  ),
                  Text(
                    city ?? '—',
                    style: GoogleFonts.lexend(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 28 / 20,
                      color: Skin.color(Co.onBackground),
                    ),
                  ),
                ],
              ),
            ],
          ),
          _MyDetailsCityImage(cityImageUrl: cityImageUrl),
        ],
      ),
    );
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: row,
      );
    }
    return row;
  }
}

class _MyDetailsCityImage extends StatelessWidget {
  const _MyDetailsCityImage({required this.cityImageUrl});

  final String? cityImageUrl;

  @override
  Widget build(BuildContext context) {
    if (cityImageUrl != null && cityImageUrl!.isNotEmpty) {
      return Container(
        width: _ProfileTabDimens.cityImageSize,
        height: _ProfileTabDimens.cityImageSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Skin.color(Co.outline)),
        ),
        child: ClipOval(
          child: Image.network(
            cityImageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const _MyDetailsCityPlaceholder(),
          ),
        ),
      );
    }
    return const _MyDetailsCityPlaceholder();
  }
}

class _MyDetailsCityPlaceholder extends StatelessWidget {
  const _MyDetailsCityPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _ProfileTabDimens.cityImageSize,
      height: _ProfileTabDimens.cityImageSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Skin.color(Co.outline)),
        color: Skin.color(Co.surface),
      ),
      child: ClipOval(
        child: Icon(
          Icons.location_city_rounded,
          size: 32,
          color: Skin.color(Co.textMuted),
        ),
      ),
    );
  }
}
