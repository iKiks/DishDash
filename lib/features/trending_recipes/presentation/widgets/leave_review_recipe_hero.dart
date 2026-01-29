import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class LeaveReviewRecipeHero extends StatelessWidget {
  final String title;
  final String image;

  const LeaveReviewRecipeHero({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(ResponsiveSize.width(22));
    final imageRadius = BorderRadius.circular(ResponsiveSize.width(18));

    return Container(
      decoration: BoxDecoration(color: AppColors.redPink, borderRadius: radius),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: imageRadius,
            child: AspectRatio(
              aspectRatio: 335 / 220,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: ResponsiveSize.height(14),
              horizontal: ResponsiveSize.width(12),
            ),
            alignment: Alignment.center,
            child: AppTexts(
              title,
              fontSize: ResponsiveSize.fontSize(18),
              color: Colors.white,
              fontWeightToken: AppFontWeight.semiBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
