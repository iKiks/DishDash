import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/trending_recipes/presentation/widgets/leave_review_action_button.dart';
import 'package:flutter/material.dart';

class LeaveReviewThankYouDialog extends StatelessWidget {
  final VoidCallback onGoHome;

  const LeaveReviewThankYouDialog({
    super.key,
    required this.onGoHome,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(ResponsiveSize.width(28));
    final checkBoxSize = ResponsiveSize.width(86);
    final checkIconSize = ResponsiveSize.width(54);

    return Dialog(
      backgroundColor: const Color(0xFFFFFBF8),
      insetPadding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(26)),
      shape: RoundedRectangleBorder(borderRadius: radius),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.width(22),
          vertical: ResponsiveSize.height(26),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTexts(
              'Thank You For\nYour Review!',
              fontSize: ResponsiveSize.fontSize(26),
              color: AppColors.black,
              fontWeightToken: AppFontWeight.semiBold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ResponsiveSize.height(26)),
            Container(
              width: checkBoxSize,
              height: checkBoxSize,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.redPink, width: 4),
                borderRadius: BorderRadius.circular(ResponsiveSize.width(20)),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.check_rounded,
                size: checkIconSize,
                color: AppColors.redPink,
              ),
            ),
            SizedBox(height: ResponsiveSize.height(22)),
            AppTexts(
              'Lorem ipsum dolor sit amet\npretium cras id dui\npellentesque ornare.',
              fontSize: ResponsiveSize.fontSize(14),
              color: AppColors.black,
              fontWeightToken: AppFontWeight.regular,
              textAlign: TextAlign.center,
              height: 1.35,
            ),
            SizedBox(height: ResponsiveSize.height(26)),
            SizedBox(
              width: double.infinity,
              child: LeaveReviewActionButton(
                label: 'Go To Home',
                filled: true,
                onTap: onGoHome,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
