import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/features/bottom_navigation/presentation/dishdash_bottom_nav_bar.dart';
import 'package:dishdash/features/bottom_navigation/presentation/tab_navigator.dart';
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
                TabNavigator(
                  navigatorKey: _navigatorKeys[0],
                  child: const HomePage(),
                ),
                TabNavigator(
                  navigatorKey: _navigatorKeys[1],
                  child: const CommunityPage(),
                ),
                TabNavigator(
                  navigatorKey: _navigatorKeys[2],
                  child: const CategoriesPage(),
                ),
                TabNavigator(
                  navigatorKey: _navigatorKeys[3],
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
