import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/domain/entities/trending_recipe_reviews.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_reviews_star_row.dart';
import 'package:flutter/material.dart';

class TrendingRecipeReviewsRecipeSummaryCard extends StatelessWidget {
  final TrendingRecipeReviews data;
  final VoidCallback onAddReview;

  const TrendingRecipeReviewsRecipeSummaryCard({
    super.key,
    required this.data,
    required this.onAddReview,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(ResponsiveSize.width(22));
    final imageRadius = BorderRadius.circular(ResponsiveSize.width(16));
    final imageWidth = ResponsiveSize.width(120);

    return Container(
      decoration: BoxDecoration(color: AppColors.redPink, borderRadius: radius),
      padding: EdgeInsets.all(ResponsiveSize.width(14)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: imageRadius,
            child: SizedBox(
              width: imageWidth,
              height: ResponsiveSize.height(92),
              child: Image.asset(data.recipeImage, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: ResponsiveSize.width(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts(
                  data.recipeTitle,
                  fontSize: ResponsiveSize.fontSize(16),
                  color: Colors.white,
                  fontWeightToken: AppFontWeight.semiBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ResponsiveSize.height(6)),
                Row(
                  children: [
                    TrendingRecipeReviewsStarRow(rating: data.averageRating),
                    SizedBox(width: ResponsiveSize.width(8)),
                    AppTexts(
                      '(${data.reviewCount} Reviews)',
                      fontSize: ResponsiveSize.fontSize(11),
                      color: Colors.white.withAlpha(220),
                      fontWeightToken: AppFontWeight.regular,
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveSize.height(10)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: ResponsiveSize.width(30),
                      height: ResponsiveSize.width(30),
                      decoration: const BoxDecoration(
                        color: AppColors.pink,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.person,
                        color: AppColors.redPink,
                        size: ResponsiveSize.width(18),
                      ),
                    ),
                    SizedBox(width: ResponsiveSize.width(8)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts(
                            data.chefHandle,
                            fontSize: ResponsiveSize.fontSize(11),
                            color: Colors.white,
                            fontWeightToken: AppFontWeight.medium,
                          ),
                          AppTexts(
                            data.chefName,
                            fontSize: ResponsiveSize.fontSize(10),
                            color: Colors.white.withAlpha(210),
                            fontWeightToken: AppFontWeight.regular,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveSize.height(10)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onAddReview,
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveSize.width(16),
                          vertical: ResponsiveSize.height(8),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: AppTexts(
                          'Add Review',
                          fontSize: ResponsiveSize.fontSize(12),
                          color: AppColors.redPink,
                          fontWeightToken: AppFontWeight.medium,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
