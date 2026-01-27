import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_round_icon_button.dart';
import 'package:flutter/material.dart';

class TrendingRecipeDetailsHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onFavorite;
  final VoidCallback onShare;
  final String backIconAsset;

  const TrendingRecipeDetailsHeader({
    super.key,
    required this.title,
    required this.onBack,
    required this.onFavorite,
    required this.onShare,
    required this.backIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = ResponsiveSize.width(28);
    final circleSize = ResponsiveSize.width(34);

    return Row(
      children: [
        InkResponse(
          onTap: onBack,
          radius: ResponsiveSize.width(24),
          child: Image.asset(
            backIconAsset,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: Center(
            child: AppTexts(
              title,
              fontSize: ResponsiveSize.fontSize(20),
              color: AppColors.redPink,
              fontWeightToken: AppFontWeight.semiBold,
            ),
          ),
        ),
        TrendingRecipeRoundIconButton(
          size: circleSize,
          icon: Icons.favorite_border,
          onTap: onFavorite,
        ),
        SizedBox(width: ResponsiveSize.width(10)),
        TrendingRecipeRoundIconButton(
          size: circleSize,
          icon: Icons.share,
          onTap: onShare,
        ),
      ],
    );
  }
}
