import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/home_page/presentation/widgets/category_chips.dart';
import 'package:dishdash/features/home_page/presentation/widgets/home_header.dart';
import 'package:dishdash/features/home_page/presentation/widgets/recipe_cards.dart';
import 'package:dishdash/features/home_page/presentation/widgets/top_chef_row.dart';
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

  final List<String> _categories = const [
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

    final favoriteIcon = Theme.of(context).brightness == Brightness.dark
        ? _favoriteDark
        : _favoriteLight;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ResponsiveSize.height(18)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.width(20),
                ),
                child: HomeHeader(
                  onNotificationTap: () {},
                  onSearchTap: () {},
                  notificationIconAsset: _notificationIcon,
                  searchIconAsset: _searchIcon,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(16)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.width(20),
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
                  horizontal: ResponsiveSize.width(20),
                ),
                child: AppTexts(
                  'Trending Recipe',
                  fontSize: ResponsiveSize.fontSize(16),
                  color: AppColors.redPink,
                  fontWeightToken: AppFontWeight.semiBold,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(10)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.width(20),
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
                  horizontal: ResponsiveSize.width(20),
                ),
                child: AppTexts(
                  'Top Chef',
                  fontSize: ResponsiveSize.fontSize(16),
                  color: AppColors.redPink,
                  fontWeightToken: AppFontWeight.semiBold,
                ),
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
}
