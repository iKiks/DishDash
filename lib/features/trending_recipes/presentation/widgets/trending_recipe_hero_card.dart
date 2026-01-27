import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/domain/entities/trending_recipe_details.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/trending_recipe_meta_pill.dart';
import 'package:flutter/material.dart';

class TrendingRecipeHeroCard extends StatelessWidget {
  final TrendingRecipeDetails details;
  final String starIconAsset;
  final VoidCallback? onCommentsTap;

  const TrendingRecipeHeroCard({
    super.key,
    required this.details,
    required this.starIconAsset,
    this.onCommentsTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(ResponsiveSize.width(22));
    final imageRadius = BorderRadius.circular(ResponsiveSize.width(18));

    return Container(
      decoration: BoxDecoration(color: AppColors.redPink, borderRadius: radius),
      padding: EdgeInsets.all(ResponsiveSize.width(14)),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: imageRadius,
                child: AspectRatio(
                  aspectRatio: 335 / 220,
                  child: Image.asset(details.heroImage, fit: BoxFit.cover),
                ),
              ),
              Container(
                width: ResponsiveSize.width(60),
                height: ResponsiveSize.width(60),
                decoration: const BoxDecoration(
                  color: AppColors.redPink,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: ResponsiveSize.width(34),
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveSize.height(12)),
          Row(
            children: [
              Expanded(
                child: AppTexts(
                  details.title,
                  fontSize: ResponsiveSize.fontSize(16),
                  color: Colors.white,
                  fontWeightToken: AppFontWeight.semiBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TrendingRecipeMetaPill(
                iconWidget: Image.asset(
                  starIconAsset,
                  width: ResponsiveSize.width(14),
                  height: ResponsiveSize.width(14),
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
                text: '${details.rating}',
              ),
              SizedBox(width: ResponsiveSize.width(12)),
              InkWell(
                onTap: onCommentsTap,
                borderRadius: BorderRadius.circular(999),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveSize.width(4),
                    vertical: ResponsiveSize.height(2),
                  ),
                  child: TrendingRecipeMetaPill(
                    iconWidget: Icon(
                      Icons.comment,
                      color: Colors.white,
                      size: ResponsiveSize.width(14),
                    ),
                    text: '${details.likes}',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
