import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class LeaveReviewHeader extends StatelessWidget {
  final String title;
  final String backIconAsset;
  final VoidCallback onBack;

  const LeaveReviewHeader({
    super.key,
    required this.title,
    required this.backIconAsset,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = ResponsiveSize.width(28);

    return Row(
      children: [
        Tooltip(
          message: 'Back',
          child: InkResponse(
            onTap: onBack,
            radius: ResponsiveSize.width(24),
            child: Image.asset(
              backIconAsset,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: AppTexts(
              title,
              fontSize: ResponsiveSize.fontSize(20),
              color: AppColors.redPink,
              fontWeightToken: AppFontWeight.semiBold,
            ),
          ),
        ),
        SizedBox(width: iconSize),
      ],
    );
  }
}
