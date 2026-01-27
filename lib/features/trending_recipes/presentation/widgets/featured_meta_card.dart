import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/meta_inline.dart';
import 'package:flutter/material.dart';

class FeaturedMetaCard extends StatelessWidget {
  final String clockIconAsset;
  final String starIconAsset;

  const FeaturedMetaCard({
    super.key,
    required this.clockIconAsset,
    required this.starIconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(14),
        vertical: ResponsiveSize.height(10),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
              MetaInline(iconAsset: clockIconAsset, text: '30min'),
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
            child: MetaInline(iconAsset: starIconAsset, text: '5'),
          ),
        ],
      ),
    );
  }
}
