import 'package:be_board/core/core.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.child});

  final Widget child;

  static const List<_MainDestination> _destinations = [
    _MainDestination(
      route: AppRoutes.home,
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
    ),
    _MainDestination(
      route: AppRoutes.explore,
      label: 'Explore',
      icon: Icons.search_outlined,
      selectedIcon: Icons.search,
    ),
    _MainDestination(
      route: AppRoutes.cart,
      label: 'Cart',
      icon: Icons.shopping_bag_outlined,
      selectedIcon: Icons.shopping_bag,
    ),
    _MainDestination(
      route: AppRoutes.profile,
      label: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
    ),
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: AppBottomNavBar(
        items: List.generate(MainScreen._destinations.length, (index) {
          final destination = MainScreen._destinations[index];
          return AppBottomNavItem(
            icon: index == currentIndex
                ? destination.selectedIcon
                : destination.icon,
            label: destination.label,
          );
        }),
        currentIndex: currentIndex,
        onItemTap: (index) => _onItemTapped(index, context),
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    GoRouter.of(context).go(MainScreen._destinations[index].route);
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    final index = MainScreen._destinations.indexWhere((destination) {
      if (destination.route == '/' && location != '/') return false;
      return location.startsWith(destination.route);
    });

    return index != -1 ? index : 0;
  }
}

class _MainDestination {
  const _MainDestination({
    required this.route,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String route;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
