import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/features/trending_recipes/data/fake_trending_recipe_details.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/missing_trending_recipe_details.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_chef_row.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_details_header.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_details_section.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_hero_card.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_ingredients_section.dart';
import 'package:dishdash/features/trending_recipes/presentation/trending_recipe_reviews_page.dart';
import 'package:flutter/material.dart';

class TrendingRecipeDetailsPage extends StatelessWidget {
  final String recipeTitle;

  const TrendingRecipeDetailsPage({super.key, required this.recipeTitle});

  static const _backArrowIcon = 'lib/core/assets/icons/arrow.png';
  static const _clockIcon = 'lib/core/assets/icons/clock.png';
  static const _starIcon = 'lib/core/assets/icons/star.png';

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    final details = FakeTrendingRecipeDetails.byTitle(recipeTitle);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ResponsiveSize.height(10)),
                TrendingRecipeDetailsHeader(
                  title: 'Trending Recipes',
                  onBack: () => Navigator.of(context).maybePop(),
                  onFavorite: () {},
                  onShare: () {},
                  backIconAsset: _backArrowIcon,
                ),
                SizedBox(height: ResponsiveSize.height(16)),
                if (details == null)
                  MissingTrendingRecipeDetails(title: recipeTitle)
                else ...[
                  TrendingRecipeHeroCard(
                    details: details,
                    starIconAsset: _starIcon,
                    onCommentsTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => TrendingRecipeReviewsPage(
                            recipeTitle: details.title,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: ResponsiveSize.height(16)),
                  TrendingRecipeChefRow(details: details),
                  SizedBox(height: ResponsiveSize.height(18)),
                  TrendingRecipeDetailsSection(
                    details: details,
                    clockIconAsset: _clockIcon,
                  ),
                  SizedBox(height: ResponsiveSize.height(18)),
                  TrendingRecipeIngredientsSection(details: details),
                ],
                SizedBox(height: ResponsiveSize.height(120)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
