import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
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
                  child: Image.network(imageUrl, fit: BoxFit.cover),
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
              child: Container(
                width: ResponsiveSize.width(30),
                height: ResponsiveSize.width(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  favoriteIconAsset,
                  width: ResponsiveSize.width(16),
                  height: ResponsiveSize.width(16),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MetaIconText extends StatelessWidget {
  final String iconAsset;
  final String text;
  final Color textColor;

  const MetaIconText({
    super.key,
    required this.iconAsset,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          iconAsset,
          width: ResponsiveSize.width(14),
          height: ResponsiveSize.width(14),
          fit: BoxFit.contain,
        ),
        SizedBox(width: ResponsiveSize.width(6)),
        AppTexts(
          text,
          fontSize: ResponsiveSize.fontSize(11),
          color: textColor,
          fontWeightToken: AppFontWeight.semiBold,
        ),
      ],
    );
  }
}
