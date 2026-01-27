import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/home_page/presentation/widgets/home_header.dart';
import 'package:dishdash/features/home_page/presentation/widgets/search_popup.dart';
import 'package:dishdash/features/notifications/presentation/notifications_page.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  static const _backArrowIcon = 'lib/core/assets/icons/arrow.png';
  static const _notificationIcon =
      'lib/core/assets/icons/notification_button.png';
  static const _searchIcon = 'lib/core/assets/icons/search_button.png';

  static const List<_CategoryItem> _items = [
    _CategoryItem('Seafood', 'lib/core/assets/preferences/seafood.png'),
    _CategoryItem('Lunch', 'lib/core/assets/preferences/burger.png'),
    _CategoryItem('Breakfast', 'lib/core/assets/preferences/eggs.png'),
    _CategoryItem('Dinner', 'lib/core/assets/preferences/rice.png'),
    _CategoryItem('Vegan', 'lib/core/assets/preferences/salad.png'),
    _CategoryItem('Dessert', 'lib/core/assets/preferences/dessert.png'),
    _CategoryItem('Drinks', 'lib/core/assets/preferences/milk.png'),
  ];

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    final pageHorizontalPadding = ResponsiveSize.width(20);
    final gridCrossSpacing = ResponsiveSize.width(16);
    final gridMainSpacing = ResponsiveSize.height(16);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
          child: Column(
            children: [
              SizedBox(height: ResponsiveSize.height(10)),
              _Header(
                title: 'Categories',
                onBack: () => Navigator.of(context).maybePop(),
                onNotificationTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const NotificationsPage(),
                    ),
                  );
                },
                onSearchTap: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: Colors.black.withAlpha(85),
                    builder: (_) => const SearchPopup(),
                  );
                },
              ),
              SizedBox(height: ResponsiveSize.height(18)),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: gridCrossSpacing,
                    mainAxisSpacing: gridMainSpacing,
                    childAspectRatio: 0.92,
                  ),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return _CategoryTile(item: item);
                  },
                ),
              ),
              SizedBox(height: ResponsiveSize.height(8)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onNotificationTap;
  final VoidCallback onSearchTap;

  const _Header({
    required this.title,
    required this.onBack,
    required this.onNotificationTap,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = ResponsiveSize.width(28);

    return Row(
      children: [
        InkResponse(
          onTap: onBack,
          radius: ResponsiveSize.width(24),
          child: Image.asset(
            CategoriesPage._backArrowIcon,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: Center(
            child: AppTexts(
              title,
              fontSize: ResponsiveSize.fontSize(20),
              color: AppColors.redPink,
              fontWeightToken: AppFontWeight.semiBold,
            ),
          ),
        ),
        RoundIconButton(
          onTap: onNotificationTap,
          assetPath: CategoriesPage._notificationIcon,
          semanticsLabel: 'Notifications',
        ),
        SizedBox(width: ResponsiveSize.width(10)),
        RoundIconButton(
          onTap: onSearchTap,
          assetPath: CategoriesPage._searchIcon,
          semanticsLabel: 'Search',
        ),
      ],
    );
  }
}

class _CategoryItem {
  final String title;
  final String imageAsset;

  const _CategoryItem(this.title, this.imageAsset);
}

class _CategoryTile extends StatelessWidget {
  final _CategoryItem item;

  const _CategoryTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(ResponsiveSize.width(18));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: radius,
            child: Image.asset(
              item.imageAsset,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: ResponsiveSize.height(8)),
        AppTexts(
          item.title,
          fontSize: ResponsiveSize.fontSize(14),
          color: AppColors.brownPod,
          fontWeightToken: AppFontWeight.medium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
