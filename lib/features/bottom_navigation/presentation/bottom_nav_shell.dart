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
    final barGapFromBottom = ResponsiveSize.height(12); // visual gap
    final barBottom = barGapFromBottom + bottomSafe;

    // How much to inset pages so important UI isn't hidden behind the floating bar.
    // (barHeight + barBottom) is the space the bar occupies visually.
    final pageBottomInset = barHeight + barBottom;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // ✅ NO reserved padding here — pages go full height behind the bar.
            IndexedStack(
              index: _selectedIndex,
              children: [
                _TabNavigator(
                  navigatorKey: _navigatorKeys[0],
                  bottomInset: pageBottomInset,
                  child: const HomePage(),
                ),
                _TabNavigator(
                  navigatorKey: _navigatorKeys[1],
                  bottomInset: pageBottomInset,
                  child: const CommunityPage(),
                ),
                _TabNavigator(
                  navigatorKey: _navigatorKeys[2],
                  bottomInset: pageBottomInset,
                  child: const CategoriesPage(),
                ),
                _TabNavigator(
                  navigatorKey: _navigatorKeys[3],
                  bottomInset: pageBottomInset,
                  child: const ProfilePage(),
                ),
              ],
            ),

            // ✅ Floating nav
            Positioned(
              left: ResponsiveSize.width(28),
              right: ResponsiveSize.width(28),
              bottom: barBottom,
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
  final double bottomInset;

  const _TabNavigator({
    required this.navigatorKey,
    required this.child,
    required this.bottomInset,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (_) {
        return MaterialPageRoute<void>(
          builder: (_) {
            // ✅ This is the key: pages render behind the bar,
            // but the page gets an inset so its bottom content isn't hidden.
            return SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
                child: child,
              ),
            );
          },
        );
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
