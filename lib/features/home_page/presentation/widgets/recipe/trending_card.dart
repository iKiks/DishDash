import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/home_page/presentation/widgets/recipe/meta_icon_text.dart';
import 'package:flutter/material.dart';

class TrendingCard extends StatelessWidget {
  final String favoriteIconAsset;
  final String clockIconAsset;
  final String starIconAsset;

  const TrendingCard({
    super.key,
    required this.favoriteIconAsset,
    required this.clockIconAsset,
    required this.starIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    final cardRadius = BorderRadius.circular(22);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: cardRadius,
          child: AspectRatio(
            aspectRatio: 335 / 170,
            child: Image.network(
              'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=1200&q=80',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'lib/core/assets/preferences/pizza.png',
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        Positioned(
          top: ResponsiveSize.height(10),
          right: ResponsiveSize.width(10),
          child: Container(
            width: ResponsiveSize.width(34),
            height: ResponsiveSize.width(34),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              favoriteIconAsset,
              width: ResponsiveSize.width(18),
              height: ResponsiveSize.width(18),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          left: ResponsiveSize.width(10),
          right: ResponsiveSize.width(10),
          bottom: -ResponsiveSize.height(22),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveSize.width(14),
              vertical: ResponsiveSize.height(10),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.pink.withAlpha(120),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppTexts(
                        'Salami and cheese pizza',
                        fontSize: ResponsiveSize.fontSize(14),
                        color: AppColors.black,
                        fontWeightToken: AppFontWeight.semiBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: ResponsiveSize.width(10)),
                    MetaIconText(
                      iconAsset: clockIconAsset,
                      text: '30min',
                      textColor: AppColors.redPink,
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveSize.height(4)),
                AppTexts(
                  'This is a quick overview of the ingredients…',
                  fontSize: ResponsiveSize.fontSize(10.5),
                  color: AppColors.brownPod.withAlpha(153),
                  fontWeightToken: AppFontWeight.regular,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ResponsiveSize.height(8)),
                Align(
                  alignment: Alignment.centerRight,
                  child: MetaIconText(
                    iconAsset: starIconAsset,
                    text: '5',
                    textColor: AppColors.redPink,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ResponsiveSize.height(36)),
      ],
    );
  }
}
