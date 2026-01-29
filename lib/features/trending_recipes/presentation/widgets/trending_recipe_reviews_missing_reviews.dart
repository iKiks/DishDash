import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class TrendingRecipeReviewsMissingReviews extends StatelessWidget {
  final String title;

  const TrendingRecipeReviewsMissingReviews({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ResponsiveSize.width(16)),
      decoration: BoxDecoration(
        color: AppColors.pink,
        borderRadius: BorderRadius.circular(16),
      ),
      child: AppTexts(
        'No fake reviews found for "$title" yet.',
        fontSize: ResponsiveSize.fontSize(13),
        color: AppColors.redPink,
        fontWeightToken: AppFontWeight.medium,
      ),
    );
  }
}
