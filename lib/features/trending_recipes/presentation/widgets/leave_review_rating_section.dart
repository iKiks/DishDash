import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/leave_review_star_picker.dart';
import 'package:flutter/material.dart';

class LeaveReviewRatingSection extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;

  const LeaveReviewRatingSection({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          LeaveReviewStarPicker(value: rating, onChanged: onRatingChanged),
          SizedBox(height: ResponsiveSize.height(6)),
          AppTexts(
            'Your overall rating',
            fontSize: ResponsiveSize.fontSize(12),
            color: AppColors.brownPod.withAlpha(190),
            fontWeightToken: AppFontWeight.regular,
          ),
        ],
      ),
    );
  }
}
