import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/features/bottom_navigation/presentation/dishdash_nav_item.dart';
import 'package:flutter/material.dart';

class DishDashBottomNavBar extends StatelessWidget {
  final double height;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const DishDashBottomNavBar({
    super.key,
    required this.height,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(height / 2);
    final iconSize = ResponsiveSize.width(26);

    Color iconColor(int index) {
      if (index == selectedIndex) return Colors.white;
      return Colors.white.withAlpha(179);
    }

    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.all(radius),
        child: Container(
          height: height,
          decoration: const BoxDecoration(color: AppColors.redPink),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DishDashNavItem(
                index: 0,
                icon: Icons.home_outlined,
                iconSize: iconSize,
                color: iconColor(0),
                onTap: onTap,
                semanticsLabel: 'Home',
              ),
              DishDashNavItem(
                index: 1,
                icon: Icons.chat_bubble_outline_rounded,
                iconSize: iconSize,
                color: iconColor(1),
                onTap: onTap,
                semanticsLabel: 'Community',
              ),
              DishDashNavItem(
                index: 2,
                icon: Icons.layers_outlined,
                iconSize: iconSize,
                color: iconColor(2),
                onTap: onTap,
                semanticsLabel: 'Categories',
              ),
              DishDashNavItem(
                index: 3,
                icon: Icons.person_outline,
                iconSize: iconSize,
                color: iconColor(3),
                onTap: onTap,
                semanticsLabel: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
