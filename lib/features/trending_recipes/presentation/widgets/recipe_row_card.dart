import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/domain/entities/trending_recipe.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/difficulty_inline.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/meta_inline.dart';
import 'package:flutter/material.dart';

class RecipeRowCard extends StatelessWidget {
  final TrendingRecipe recipe;
  final String clockIconAsset;
  final String starIconAsset;
  final VoidCallback? onTap;

  const RecipeRowCard({
    super.key,
    required this.recipe,
    required this.clockIconAsset,
    required this.starIconAsset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardRadius = ResponsiveSize.width(18);
    final cardHeight = ResponsiveSize.height(120);
    final imageWidth = ResponsiveSize.width(120);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(cardRadius),
      child: Container(
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(cardRadius),
          border: Border.all(color: AppColors.redPink.withAlpha(120), width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: imageWidth,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(recipe.image, fit: BoxFit.cover),
                  Positioned(
                    top: ResponsiveSize.height(10),
                    right: ResponsiveSize.width(10),
                    child: Container(
                      width: ResponsiveSize.width(30),
                      height: ResponsiveSize.width(30),
                      decoration: const BoxDecoration(
                        color: AppColors.redPink,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.favorite_border,
                        size: ResponsiveSize.width(18),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.width(12),
                  vertical: ResponsiveSize.height(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTexts(
                      recipe.title,
                      fontSize: ResponsiveSize.fontSize(13.5),
                      color: AppColors.black,
                      fontWeightToken: AppFontWeight.semiBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: ResponsiveSize.height(4)),
                    AppTexts(
                      recipe.description,
                      fontSize: ResponsiveSize.fontSize(10.5),
                      color: AppColors.brownPod.withAlpha(153),
                      fontWeightToken: AppFontWeight.regular,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      height: 1.2,
                    ),
                    SizedBox(height: ResponsiveSize.height(6)),
                    AppTexts(
                      'By ${recipe.chef}',
                      fontSize: ResponsiveSize.fontSize(10.5),
                      color: AppColors.redPink,
                      fontWeightToken: AppFontWeight.medium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        MetaInline(
                          iconAsset: clockIconAsset,
                          text: recipe.time,
                        ),
                        SizedBox(width: ResponsiveSize.width(14)),
                        DifficultyInline(text: recipe.difficulty),
                        const Spacer(),
                        MetaInline(
                          iconAsset: starIconAsset,
                          text: recipe.rating,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
