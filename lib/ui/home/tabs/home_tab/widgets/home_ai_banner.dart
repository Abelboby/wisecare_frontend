part of '../home_tab_screen.dart';

class _HomeAIBanner extends StatelessWidget {
  const _HomeAIBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_HomeTabDimens.bannerPadding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            _HomeTabColors.bannerGradientStart,
            _HomeTabColors.bannerGradientEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(_HomeTabDimens.bannerRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33DDD6FE),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x26DDD6FE),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: _HomeTabDimens.avatarCircleSize,
                height: _HomeTabDimens.avatarCircleSize,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.smart_toy_outlined,
                  color: _HomeTabColors.bannerGradientEnd,
                  size: 32,
                ),
              ),
              Positioned(
                right: -4,
                bottom: -4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _HomeTabColors.statusGreenBanner,
                    border: Border.all(
                      color: _HomeTabColors.bannerGradientEnd,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: _HomeTabDimens.bannerPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Arya AI Assistant',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 20 / 14,
                    color: _HomeTabColors.bannerSubtitle,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  'Did you sleep well last night, Raghav ji?',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 22 / 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: _HomeTabDimens.micButtonSize,
              height: _HomeTabDimens.micButtonSize,
              decoration: BoxDecoration(
                color: _HomeTabColors.bannerMicBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.mic_none, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}
