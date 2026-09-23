import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawtrol/src/shared/theme/app_colors.dart';
class FloatingNavBar extends StatelessWidget {
  final List<NavBarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  final Color borderColor;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final Color activePillColor;
  final Duration animationDuration;

  const FloatingNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
    this.borderColor = AppColors.primaryColor,
    this.backgroundColor = AppColors.backgroundColor,
    this.activeColor = Colors.white,
    this.inactiveColor = AppColors.primaryColor,
    this.activePillColor = AppColors.primaryColor,
    this.animationDuration = const Duration(milliseconds: 350),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: BoxBorder.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(items.length, (index) {
          final bool isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: _NavBarButton(
              item: items[index],
              isSelected: isSelected,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              activePillColor: activePillColor,
              animationDuration: animationDuration,
              onTap: () => onTap(index),
            ),
          );
        }),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  final NavBarItem item;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final Color activePillColor;
  final Duration animationDuration;
  final VoidCallback onTap;

  const _NavBarButton({
    required this.item,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.activePillColor,
    required this.animationDuration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: animationDuration,
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 16 : 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? activePillColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 24,
            ),
            AnimatedSize(
              duration: animationDuration,
              curve: Curves.easeOutCubic,
              child: AnimatedSwitcher(
                duration: animationDuration,
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: isSelected
                    ? Padding(
                        key: ValueKey('${item.label}-visible'),
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          item.label,
                          style: TextStyle(
                            color: activeColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : const SizedBox(
                        key: ValueKey('hidden'),
                        width: 0,
                        height: 0,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBottomNavigationBar extends StatelessWidget {
  final String location;
  final Widget child;

  const AppBottomNavigationBar({
    super.key,
    required this.location,
    required this.child,
  });

  static const List<String> _paths = ['/', '/animals', '/profile'];

  static const List<NavBarItem> _items = [
    NavBarItem(icon: Icons.home_rounded, label: 'Home'),
    NavBarItem(icon: Icons.pets_rounded, label: 'Animals'),
    NavBarItem(icon: Icons.person_rounded, label: 'Profile'),
  ];

  int _indexForLocation(String location) {
    int bestIndex = 0;
    int bestLength = -1;
    for (int i = 0; i < _paths.length; i++) {
      final path = _paths[i];
      final matches = path == '/'
          ? location == '/'
          : location == path || location.startsWith('$path/');
      if (matches && path.length > bestLength) {
        bestIndex = i;
        bestLength = path.length;
      }
    }
    return bestIndex;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _indexForLocation(location);

    return Scaffold(
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingNavBar(
        items: _items,
        selectedIndex: selectedIndex,
        onTap: (index) {
          if (index == selectedIndex) return;
          context.go(_paths[index]);
        },
      ),
    );
  }
}

class NavBarItem {
  final IconData icon;
  final String label;

  const NavBarItem({required this.icon, required this.label});
}
