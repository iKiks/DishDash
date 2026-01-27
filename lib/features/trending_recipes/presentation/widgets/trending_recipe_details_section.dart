import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/domain/entities/trending_recipe_details.dart';
import 'package:flutter/material.dart';

class TrendingRecipeDetailsSection extends StatelessWidget {
  final TrendingRecipeDetails details;
  final String clockIconAsset;

  const TrendingRecipeDetailsSection({
    super.key,
    required this.details,
    required this.clockIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppTexts(
                'Details',
                fontSize: ResponsiveSize.fontSize(18),
                color: AppColors.redPink,
                fontWeightToken: AppFontWeight.semiBold,
              ),
            ),
            Image.asset(
              clockIconAsset,
              width: ResponsiveSize.width(14),
              height: ResponsiveSize.width(14),
              fit: BoxFit.contain,
            ),
            SizedBox(width: ResponsiveSize.width(6)),
            AppTexts(
              details.cookTime,
              fontSize: ResponsiveSize.fontSize(12),
              color: AppColors.brownPod.withAlpha(170),
              fontWeightToken: AppFontWeight.medium,
            ),
          ],
        ),
        SizedBox(height: ResponsiveSize.height(10)),
        AppTexts(
          details.detailsText,
          fontSize: ResponsiveSize.fontSize(12),
          color: AppColors.brownPod.withAlpha(190),
          fontWeightToken: AppFontWeight.regular,
          height: 1.4,
        ),
      ],
    );
  }
}
