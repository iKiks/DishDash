import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/home_page/presentation/widgets/recipe/recipe_mini_card.dart';
import 'package:flutter/material.dart';

class YourRecipesSection extends StatelessWidget {
  final String favoriteIconAsset;
  final String clockIconAsset;
  final String starIconAsset;

  const YourRecipesSection({
    super.key,
    required this.favoriteIconAsset,
    required this.clockIconAsset,
    required this.starIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        ResponsiveSize.width(16),
        ResponsiveSize.height(16),
        ResponsiveSize.width(16),
        ResponsiveSize.height(18),
      ),
      decoration: BoxDecoration(
        color: AppColors.redPink,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts(
            'Your Recipes',
            fontSize: ResponsiveSize.fontSize(16),
            color: Colors.white,
            fontWeightToken: AppFontWeight.semiBold,
          ),
          SizedBox(height: ResponsiveSize.height(12)),
          Row(
            children: [
              Expanded(
                child: RecipeMiniCard(
                  title: 'Chicken Burger',
                  imageUrl:
                      'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=1200&q=80',
                  favoriteIconAsset: favoriteIconAsset,
                  clockIconAsset: clockIconAsset,
                  starIconAsset: starIconAsset,
                  timeText: '15min',
                  ratingText: '5',
                ),
              ),
              SizedBox(width: ResponsiveSize.width(12)),
              Expanded(
                child: RecipeMiniCard(
                  title: 'Tiramisu',
                  imageUrl:
                      'https://images.unsplash.com/photo-1599785209707-28dc0b42c415?auto=format&fit=crop&w=1200&q=80',
                  favoriteIconAsset: favoriteIconAsset,
                  clockIconAsset: clockIconAsset,
                  starIconAsset: starIconAsset,
                  timeText: '15min',
                  ratingText: '5',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
