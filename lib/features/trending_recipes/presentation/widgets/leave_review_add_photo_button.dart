import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class LeaveReviewAddPhotoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LeaveReviewAddPhotoButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        foregroundColor: AppColors.black,
        alignment: Alignment.centerLeft,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: Icon(
        Icons.add_circle_outline,
        color: AppColors.redPink.withAlpha(200),
        size: ResponsiveSize.width(18),
      ),
      label: AppTexts(
        'Add Photo',
        fontSize: ResponsiveSize.fontSize(13),
        color: AppColors.black,
        fontWeightToken: AppFontWeight.medium,
      ),
    );
  }
}
