import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/home_page/presentation/widgets/recipe/meta_icon_text.dart';
import 'package:flutter/material.dart';

class RecipeMiniCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String favoriteIconAsset;
  final String clockIconAsset;
  final String starIconAsset;
  final String timeText;
  final String ratingText;

  const RecipeMiniCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.favoriteIconAsset,
    required this.clockIconAsset,
    required this.starIconAsset,
    required this.timeText,
    required this.ratingText,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);

    return ClipRRect(
      borderRadius: radius,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 1.25,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'lib/core/assets/preferences/dessert.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveSize.width(12),
                    vertical: ResponsiveSize.height(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTexts(
                        title,
                        fontSize: ResponsiveSize.fontSize(12),
                        color: AppColors.black,
                        fontWeightToken: AppFontWeight.semiBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: ResponsiveSize.height(8)),
                      Row(
                        children: [
                          MetaIconText(
                            iconAsset: starIconAsset,
                            text: ratingText,
                            textColor: AppColors.redPink,
                          ),
                          const Spacer(),
                          MetaIconText(
                            iconAsset: clockIconAsset,
                            text: timeText,
                            textColor: AppColors.redPink,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: ResponsiveSize.height(10),
              right: ResponsiveSize.width(10),
              child: Image.asset(
                favoriteIconAsset,
                width: ResponsiveSize.width(28),
                height: ResponsiveSize.width(28),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
