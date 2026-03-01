part of '../home_screen.dart';

class _HomeBottomNav extends StatelessWidget {
  const _HomeBottomNav();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return BottomNavigationBar(
          currentIndex: provider.currentTab.index,
          onTap: (index) {
            final tab = AppTab.values[index];
            context.read<HomeProvider>().switchTab(tab);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }
}
