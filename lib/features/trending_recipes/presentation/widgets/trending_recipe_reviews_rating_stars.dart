import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:flutter/material.dart';

class TrendingRecipeReviewsRatingStars extends StatelessWidget {
  final int rating;

  const TrendingRecipeReviewsRatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveSize.width(18);
    final clamped = rating.clamp(0, 5);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final isFilled = i < clamped;
        return Padding(
          padding: EdgeInsets.only(right: ResponsiveSize.width(6)),
          child: Icon(
            isFilled ? Icons.star : Icons.star_border,
            size: size,
            color: AppColors.redPink,
          ),
        );
      }),
    );
  }
}
