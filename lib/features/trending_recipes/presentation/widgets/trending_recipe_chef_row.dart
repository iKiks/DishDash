import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/domain/entities/trending_recipe_details.dart';
import 'package:flutter/material.dart';

class TrendingRecipeChefRow extends StatelessWidget {
  final TrendingRecipeDetails details;

  const TrendingRecipeChefRow({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = ResponsiveSize.width(42);

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                color: AppColors.pink,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.redPink.withAlpha(120)),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.person,
                color: AppColors.redPink,
                size: ResponsiveSize.width(22),
              ),
            ),
            SizedBox(width: ResponsiveSize.width(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTexts(
                    details.chefHandle,
                    fontSize: ResponsiveSize.fontSize(12),
                    color: AppColors.redPink,
                    fontWeightToken: AppFontWeight.medium,
                  ),
                  AppTexts(
                    details.chefName,
                    fontSize: ResponsiveSize.fontSize(11),
                    color: AppColors.brownPod.withAlpha(170),
                    fontWeightToken: AppFontWeight.regular,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveSize.width(14),
                vertical: ResponsiveSize.height(8),
              ),
              decoration: BoxDecoration(
                color: AppColors.pink,
                borderRadius: BorderRadius.circular(999),
              ),
              child: AppTexts(
                details.isFollowing ? 'Following' : 'Follow',
                fontSize: ResponsiveSize.fontSize(12),
                color: AppColors.redPink,
                fontWeightToken: AppFontWeight.medium,
              ),
            ),
            SizedBox(width: ResponsiveSize.width(8)),
            Icon(
              Icons.more_vert,
              color: AppColors.redPink,
              size: ResponsiveSize.width(20),
            ),
          ],
        ),
        SizedBox(height: ResponsiveSize.height(12)),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.redPink.withAlpha(120),
        ),
      ],
    );
  }
}
