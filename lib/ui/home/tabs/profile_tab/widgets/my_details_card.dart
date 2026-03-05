part of '../profile_tab_screen.dart';

class _MyDetailsCard extends StatelessWidget {
  const _MyDetailsCard({
    required this.age,
    required this.city,
  });

  final String age;
  final String city;

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
        'My Details',
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
        child: Column(
          children: [
            _buildAgeRow(),
            const Divider(
              color: _ProfileTabColors.cardDivider,
              thickness: 1,
              height: 1,
            ),
            _buildCityRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: _ProfileTabDimens.detailRowVerticalPadding,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.cake_rounded,
            color: _ProfileTabColors.iconOrange,
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
                  color: _ProfileTabColors.labelText,
                ),
              ),
              Text(
                age,
                style: GoogleFonts.lexend(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 28 / 20,
                  color: _ProfileTabColors.valueText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCityRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: _ProfileTabDimens.detailRowVerticalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: _ProfileTabColors.iconOrange,
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
                      color: _ProfileTabColors.labelText,
                    ),
                  ),
                  Text(
                    city,
                    style: GoogleFonts.lexend(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 28 / 20,
                      color: _ProfileTabColors.valueText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          _buildCityImage(),
        ],
      ),
    );
  }

  Widget _buildCityImage() {
    return Container(
      width: _ProfileTabDimens.cityImageSize,
      height: _ProfileTabDimens.cityImageSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: _ProfileTabColors.cityImageBorder),
        color: const Color(0xFFE2E8F0),
      ),
      child: const ClipOval(
        child: Icon(
          Icons.location_city_rounded,
          size: 32,
          color: Color(0xFF94A3B8),
        ),
      ),
    );
  }
}
