import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/features/categories/presentation/categories_page.dart';
import 'package:dishdash/features/community/presentation/community_page.dart';
import 'package:dishdash/features/home_page/presentation/homepage.dart';
import 'package:dishdash/features/profile/presentation/profile_page.dart';
import 'package:flutter/material.dart';

class BottomNavShell extends StatefulWidget {
  const BottomNavShell({super.key});

  @override
  State<BottomNavShell> createState() => _BottomNavShellState();
}

class _BottomNavShellState extends State<BottomNavShell> {
  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    4,
    (_) => GlobalKey<NavigatorState>(),
  );

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    final bottomSafe = MediaQuery.of(context).padding.bottom;
    final barHeight = ResponsiveSize.height(70);
    final barMargin = ResponsiveSize.height(12) + bottomSafe;
    final contentBottomPadding = barHeight + barMargin;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: contentBottomPadding),
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  _TabNavigator(
                    navigatorKey: _navigatorKeys[0],
                    child: const HomePage(),
                  ),
                  _TabNavigator(
                    navigatorKey: _navigatorKeys[1],
                    child: const CommunityPage(),
                  ),
                  _TabNavigator(
                    navigatorKey: _navigatorKeys[2],
                    child: const CategoriesPage(),
                  ),
                  _TabNavigator(
                    navigatorKey: _navigatorKeys[3],
                    child: const ProfilePage(),
                  ),
                ],
              ),
            ),
            Positioned(
              left: ResponsiveSize.width(28),
              right: ResponsiveSize.width(28),
              bottom: barMargin,
              child: DishDashBottomNavBar(
                height: barHeight,
                selectedIndex: _selectedIndex,
                onTap: _onNavTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onNavTapped(int index) {
    if (index == _selectedIndex) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
      return;
    }

    setState(() => _selectedIndex = index);
  }
}

class _TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  const _TabNavigator({required this.navigatorKey, required this.child});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (_) {
        return MaterialPageRoute<void>(builder: (_) => child);
      },
    );
  }
}

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
              _NavItem(
                index: 0,
                icon: Icons.home_outlined,
                iconSize: iconSize,
                color: iconColor(0),
                onTap: onTap,
                semanticsLabel: 'Home',
              ),
              _NavItem(
                index: 1,
                icon: Icons.chat_bubble_outline_rounded,
                iconSize: iconSize,
                color: iconColor(1),
                onTap: onTap,
                semanticsLabel: 'Community',
              ),
              _NavItem(
                index: 2,
                icon: Icons.layers_outlined,
                iconSize: iconSize,
                color: iconColor(2),
                onTap: onTap,
                semanticsLabel: 'Categories',
              ),
              _NavItem(
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

class _NavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final double iconSize;
  final Color color;
  final ValueChanged<int> onTap;
  final String semanticsLabel;

  const _NavItem({
    required this.index,
    required this.icon,
    required this.iconSize,
    required this.color,
    required this.onTap,
    required this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: InkResponse(
        onTap: () => onTap(index),
        radius: ResponsiveSize.width(34),
        child: SizedBox(
          width: ResponsiveSize.width(56),
          height: double.infinity,
          child: Center(
            child: Icon(icon, size: iconSize, color: color),
          ),
        ),
      ),
    );
  }
}
