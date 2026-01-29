import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/leave_review_radio_option.dart';
import 'package:flutter/material.dart';

class LeaveReviewRecommendationSection extends StatelessWidget {
  final bool recommended;
  final ValueChanged<bool> onRecommendationChanged;

  const LeaveReviewRecommendationSection({
    super.key,
    required this.recommended,
    required this.onRecommendationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts(
          'Do you recommend this recipe?',
          fontSize: ResponsiveSize.fontSize(12),
          color: AppColors.black,
          fontWeightToken: AppFontWeight.medium,
        ),
        SizedBox(height: ResponsiveSize.height(10)),
        Row(
          children: [
            Expanded(
              child: LeaveReviewRadioOption(
                label: 'No',
                semanticsLabel: 'Recommend: No',
                selected: !recommended,
                onTap: () => onRecommendationChanged(false),
              ),
            ),
            Expanded(
              child: LeaveReviewRadioOption(
                label: 'Yes',
                semanticsLabel: 'Recommend: Yes',
                selected: recommended,
                onTap: () => onRecommendationChanged(true),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
