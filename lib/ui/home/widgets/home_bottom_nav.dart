part of '../home_screen.dart';

class _HomeBottomNav extends StatelessWidget {
  const _HomeBottomNav();

  static const List<_NavItemData> _items = [
    _NavItemData(icon: Icons.home_rounded, label: 'Home'),
    _NavItemData(icon: Icons.medication_outlined, label: 'Meds'),
    _NavItemData(icon: Icons.favorite_border, label: 'Health'),
    _NavItemData(icon: Icons.person_outline, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return Container(
          padding: EdgeInsets.only(
            top: _HomeDimens.navBarPaddingTop,
            left: _HomeDimens.navBarPaddingHorizontal,
            right: _HomeDimens.navBarPaddingHorizontal,
            bottom: _HomeDimens.navBarPaddingBottom,
          ),
          constraints: const BoxConstraints(
            minHeight: _HomeDimens.navBarHeight,
          ),
          decoration: const BoxDecoration(
            color: _HomeColors.navBarBackground,
            border: Border(
              top: BorderSide(color: _HomeColors.navBarBorderTop, width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isSelected = provider.currentTab.index == index;
              return _NavLink(
                icon: item.icon,
                label: item.label,
                isSelected: isSelected,
                onTap: () {
                  context.read<HomeProvider>().switchTab(AppTab.values[index]);
                },
              );
            }),
          ),
        );
      },
    );
  }
}

class _NavItemData {
  const _NavItemData({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconSize = isSelected ? _HomeDimens.navBarIconSizeActive : _HomeDimens.navBarIconSizeInactive;
    final iconColor = isSelected ? _HomeColors.navBarIconActive : _HomeColors.navBarIconInactive;
    final labelStyle = GoogleFonts.lexend(
      fontSize: 12,
      height: 16 / 12,
      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
      color: isSelected ? _HomeColors.navBarLabelActive : _HomeColors.navBarLabelInactive,
    );

    final iconWidget = Icon(icon, size: iconSize, color: iconColor);
    final labelWidget = Text(label, style: labelStyle);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: _HomeDimens.navBarItemWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected
                ? Container(
                    width: _HomeDimens.navBarSelectedPillWidth,
                    height: _HomeDimens.navBarSelectedPillHeight,
                    decoration: BoxDecoration(
                      color: _HomeColors.navBarSelectedPillBg,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: iconWidget,
                  )
                : iconWidget,
            const SizedBox(height: _HomeDimens.navBarIconLabelGap),
            labelWidget,
          ],
        ),
      ),
    );
  }
}
