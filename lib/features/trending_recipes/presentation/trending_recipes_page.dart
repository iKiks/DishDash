import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/home_page/presentation/widgets/search_popup.dart';
import 'package:dishdash/features/notifications/presentation/notifications_page.dart';
import 'package:dishdash/features/trending_recipes/presentation/models/trending_recipe.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/most_viewed_card.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/recipe_row_card.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipes_header.dart';
import 'package:flutter/material.dart';

class TrendingRecipesPage extends StatelessWidget {
  const TrendingRecipesPage({super.key});

  static const _backArrowIcon = 'lib/core/assets/icons/arrow.png';
  static const _notificationIcon =
      'lib/core/assets/icons/notification_button.png';
  static const _searchIcon = 'lib/core/assets/icons/search_button.png';

  static const _clockIcon = 'lib/core/assets/icons/clock.png';
  static const _starIcon = 'lib/core/assets/icons/star.png';

  static const _featuredImage = 'lib/core/assets/preferences/pizza.png';

  static const List<TrendingRecipe> _recipes = [
    TrendingRecipe(
      title: 'Chicken Curry',
      description: 'Savor the aromatic Chicken Curry—\na rich blend of spices…',
      chef: 'Chef Josh Ryan',
      time: '45min',
      difficulty: 'Easy',
      rating: '4',
      image: 'lib/core/assets/preferences/chicken.png',
    ),
    TrendingRecipe(
      title: 'Chicken Burger',
      description: 'Indulge in a flavorful Chicken\nBurger: seasoned chicken…',
      chef: 'Chef Andrew',
      time: '15min',
      difficulty: 'Medium',
      rating: '5',
      image: 'lib/core/assets/preferences/burger.png',
    ),
    TrendingRecipe(
      title: 'Tiramisu',
      description: 'Mix the flours, salt, cinnamon and\nbaking powder…',
      chef: 'Chef Emily',
      time: '30min',
      difficulty: 'Easy',
      rating: '5',
      image: 'lib/core/assets/preferences/dessert.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    final pageHorizontalPadding = ResponsiveSize.width(20);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ResponsiveSize.height(10)),
                TrendingRecipesHeader(
                  title: 'Trending Recipes',
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
                  backIconAsset: _backArrowIcon,
                  notificationIconAsset: _notificationIcon,
                  searchIconAsset: _searchIcon,
                ),
                SizedBox(height: ResponsiveSize.height(16)),
                MostViewedCard(
                  imageAsset: _featuredImage,
                  clockIconAsset: _clockIcon,
                  starIconAsset: _starIcon,
                ),
                SizedBox(height: ResponsiveSize.height(14)),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {},
                    child: AppTexts(
                      'See All',
                      fontSize: ResponsiveSize.fontSize(12),
                      color: AppColors.redPink,
                      fontWeightToken: AppFontWeight.medium,
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveSize.height(12)),
                ..._recipes
                    .map(
                      (recipe) => Padding(
                        padding: EdgeInsets.only(
                          bottom: ResponsiveSize.height(16),
                        ),
                        child: RecipeRowCard(
                          recipe: recipe,
                          clockIconAsset: _clockIcon,
                          starIconAsset: _starIcon,
                        ),
                      ),
                    )
                    .toList(),
                SizedBox(height: ResponsiveSize.height(10)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
