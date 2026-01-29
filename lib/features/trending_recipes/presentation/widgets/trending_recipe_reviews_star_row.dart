import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:flutter/material.dart';

class TrendingRecipeReviewsStarRow extends StatelessWidget {
  final double rating;
  final Color color;

  const TrendingRecipeReviewsStarRow({
    super.key,
    required this.rating,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor().clamp(0, 5);
    final size = ResponsiveSize.width(14);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final isFilled = i < fullStars;
        return Padding(
          padding: EdgeInsets.only(right: ResponsiveSize.width(2)),
          child: Icon(
            isFilled ? Icons.star : Icons.star_border,
            size: size,
            color: color,
          ),
        );
      }),
    );
  }
}
