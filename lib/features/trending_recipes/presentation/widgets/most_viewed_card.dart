import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/featured_meta_card.dart';
import 'package:flutter/material.dart';

class MostViewedCard extends StatelessWidget {
  final String imageAsset;
  final String clockIconAsset;
  final String starIconAsset;

  const MostViewedCard({
    super.key,
    required this.imageAsset,
    required this.clockIconAsset,
    required this.starIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(ResponsiveSize.width(22));
    final imageRadius = BorderRadius.circular(ResponsiveSize.width(18));

    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.redPink,
            borderRadius: radius,
          ),
          padding: EdgeInsets.all(ResponsiveSize.width(14)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTexts(
                'Most Viewed Today',
                fontSize: ResponsiveSize.fontSize(14),
                color: Colors.white,
                fontWeightToken: AppFontWeight.semiBold,
              ),
              SizedBox(height: ResponsiveSize.height(10)),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: imageRadius,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(40),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: imageRadius,
                      child: AspectRatio(
                        aspectRatio: 335 / 170,
                        child: Image.asset(
                          imageAsset,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: ResponsiveSize.height(10),
                    right: ResponsiveSize.width(10),
                    child: Container(
                      width: ResponsiveSize.width(30),
                      height: ResponsiveSize.width(30),
                      decoration: const BoxDecoration(
                        color: AppColors.pink,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.favorite_border,
                        size: ResponsiveSize.width(18),
                        color: AppColors.redPink,
                      ),
                    ),
                  ),
                  Positioned(
                    left: ResponsiveSize.width(10),
                    right: ResponsiveSize.width(10),
                    bottom: -ResponsiveSize.height(22),
                    child: FeaturedMetaCard(
                      clockIconAsset: clockIconAsset,
                      starIconAsset: starIconAsset,
                    ),
                  ),
                ],
              ),
              SizedBox(height: ResponsiveSize.height(36)),
            ],
          ),
        ),
      ),
    );
  }
}
