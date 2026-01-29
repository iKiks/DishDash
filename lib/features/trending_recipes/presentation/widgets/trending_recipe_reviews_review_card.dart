import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_reviews_rating_stars.dart';
import 'package:flutter/material.dart';

class TrendingRecipeReviewsReviewCard extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String comment;
  final int rating;

  const TrendingRecipeReviewsReviewCard({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.comment,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ResponsiveSize.height(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: ResponsiveSize.width(34),
                height: ResponsiveSize.width(34),
                decoration: const BoxDecoration(
                  color: AppColors.pink,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.person,
                  color: AppColors.redPink,
                  size: ResponsiveSize.width(20),
                ),
              ),
              SizedBox(width: ResponsiveSize.width(10)),
              Expanded(
                child: AppTexts(
                  username,
                  fontSize: ResponsiveSize.fontSize(13),
                  color: AppColors.redPink,
                  fontWeightToken: AppFontWeight.medium,
                ),
              ),
              AppTexts(
                '($timeAgo)',
                fontSize: ResponsiveSize.fontSize(11),
                color: AppColors.redPink.withAlpha(170),
                fontWeightToken: AppFontWeight.regular,
              ),
            ],
          ),
          SizedBox(height: ResponsiveSize.height(10)),
          AppTexts(
            comment,
            fontSize: ResponsiveSize.fontSize(12),
            color: AppColors.brownPod.withAlpha(190),
            fontWeightToken: AppFontWeight.regular,
            height: 1.4,
          ),
          SizedBox(height: ResponsiveSize.height(10)),
          TrendingRecipeReviewsRatingStars(rating: rating),
          SizedBox(height: ResponsiveSize.height(14)),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.redPink.withAlpha(120),
          ),
        ],
      ),
    );
  }
}
