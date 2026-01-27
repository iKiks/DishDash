import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/home_page/presentation/widgets/category_chips.dart';
import 'package:dishdash/features/home_page/presentation/widgets/home_header.dart';
import 'package:dishdash/features/home_page/presentation/widgets/recipe_cards.dart';
import 'package:dishdash/features/home_page/presentation/widgets/search_popup.dart';
import 'package:dishdash/features/home_page/presentation/widgets/top_chef_row.dart';
import 'package:dishdash/features/notifications/presentation/notifications_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _searchIcon = 'lib/core/assets/icons/search_button.png';
  static const _notificationIcon =
      'lib/core/assets/icons/notification_button.png';
  static const _clockIcon = 'lib/core/assets/icons/clock.png';
  static const _starIcon = 'lib/core/assets/icons/star.png';
  static const _favoriteLight =
      'lib/core/assets/icons/favorite_button_light.png';
  static const _favoriteDark = 'lib/core/assets/icons/favorite_button_dark.png';

  static const List<String> _categories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Vegan',
    'Dessert',
  ];

  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    final theme = Theme.of(context);
    final pageHorizontalPadding = ResponsiveSize.width(20);

    final isDark = theme.brightness == Brightness.dark;
    final favoriteIcon = isDark ? _favoriteDark : _favoriteLight;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ResponsiveSize.height(18)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageHorizontalPadding,
                ),
                child: HomeHeader(
                  onNotificationTap: _handleNotificationTap,
                  onSearchTap: _handleSearchTap,
                  notificationIconAsset: _notificationIcon,
                  searchIconAsset: _searchIcon,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(16)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageHorizontalPadding,
                ),
                child: CategoryChips(
                  categories: _categories,
                  selectedIndex: _selectedCategoryIndex,
                  onSelected: (index) => setState(() {
                    _selectedCategoryIndex = index;
                  }),
                ),
              ),
              SizedBox(height: ResponsiveSize.height(18)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageHorizontalPadding,
                ),
                child: _buildSectionTitle('Trending Recipe'),
              ),
              SizedBox(height: ResponsiveSize.height(10)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageHorizontalPadding,
                ),
                child: TrendingCard(
                  favoriteIconAsset: favoriteIcon,
                  clockIconAsset: _clockIcon,
                  starIconAsset: _starIcon,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(40)),
              // Full-width section (no horizontal padding) so it can control
              // its own layout without being constrained by page padding.
              YourRecipesSection(
                favoriteIconAsset: _favoriteDark,
                clockIconAsset: _clockIcon,
                starIconAsset: _starIcon,
              ),
              SizedBox(height: ResponsiveSize.height(16)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageHorizontalPadding,
                ),
                child: _buildSectionTitle('Top Chef'),
              ),
              SizedBox(height: ResponsiveSize.height(10)),
              const TopChefRow(),
              SizedBox(height: ResponsiveSize.height(28)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return AppTexts(
      title,
      fontSize: ResponsiveSize.fontSize(16),
      color: AppColors.redPink,
      fontWeightToken: AppFontWeight.semiBold,
    );
  }

  void _handleNotificationTap() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const NotificationsPage(),
      ),
    );
  }

  void _handleSearchTap() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withAlpha(85),
      builder: (_) => const SearchPopup(),
    );
  }
}
