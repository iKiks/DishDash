import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/domain/entities/trending_recipe_details.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_ingredient_bullet.dart';
import 'package:flutter/material.dart';

class TrendingRecipeIngredientsSection extends StatelessWidget {
  final TrendingRecipeDetails details;

  const TrendingRecipeIngredientsSection({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts(
          'Ingredients',
          fontSize: ResponsiveSize.fontSize(18),
          color: AppColors.redPink,
          fontWeightToken: AppFontWeight.semiBold,
        ),
        SizedBox(height: ResponsiveSize.height(12)),
        ...details.ingredients.map(
          (line) => TrendingRecipeIngredientBullet(text: line),
        ),
      ],
    );
  }
}
