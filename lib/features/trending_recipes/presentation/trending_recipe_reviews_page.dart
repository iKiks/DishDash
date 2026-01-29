import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/data/fake_trending_recipe_reviews.dart';
import 'package:dishdash/features/trending_recipes/presentation/leave_review_page.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_reviews_header.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_reviews_missing_reviews.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_reviews_recipe_summary_card.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_reviews_review_card.dart';
import 'package:flutter/material.dart';

class TrendingRecipeReviewsPage extends StatelessWidget {
  final String recipeTitle;

  const TrendingRecipeReviewsPage({super.key, required this.recipeTitle});

  static const _backArrowIcon = 'lib/core/assets/icons/arrow.png';

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    final data = FakeTrendingRecipeReviews.byTitle(recipeTitle);

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
                TrendingRecipeReviewsHeader(
                  title: 'Reviews',
                  backIconAsset: _backArrowIcon,
                  onBack: () => Navigator.of(context).maybePop(),
                ),
                SizedBox(height: ResponsiveSize.height(16)),
                if (data == null)
                  TrendingRecipeReviewsMissingReviews(title: recipeTitle)
                else ...[
                  TrendingRecipeReviewsRecipeSummaryCard(
                    data: data,
                    onAddReview: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => LeaveReviewPage(
                            recipeTitle: data.recipeTitle,
                            recipeImage: data.recipeImage,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: ResponsiveSize.height(18)),
                  AppTexts(
                    'Comments',
                    fontSize: ResponsiveSize.fontSize(16),
                    color: AppColors.redPink,
                    fontWeightToken: AppFontWeight.semiBold,
                  ),
                  SizedBox(height: ResponsiveSize.height(10)),
                  ...data.reviews
                      .map(
                        (review) => TrendingRecipeReviewsReviewCard(
                          username: review.username,
                          timeAgo: review.timeAgo,
                          comment: review.comment,
                          rating: review.rating,
                        ),
                      )
                      .toList(),
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
