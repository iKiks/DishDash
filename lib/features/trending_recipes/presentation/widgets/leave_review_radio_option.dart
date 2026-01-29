import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class LeaveReviewRadioOption extends StatelessWidget {
  final String label;
  final String? semanticsLabel;
  final bool selected;
  final VoidCallback onTap;

  const LeaveReviewRadioOption({
    super.key,
    required this.label,
    this.semanticsLabel,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: semanticsLabel ?? label,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTexts(
              label,
              fontSize: ResponsiveSize.fontSize(13),
              color: AppColors.black,
              fontWeightToken: AppFontWeight.medium,
            ),
            SizedBox(width: ResponsiveSize.width(8)),
            Container(
              width: ResponsiveSize.width(16),
              height: ResponsiveSize.width(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.redPink, width: 2),
              ),
              alignment: Alignment.center,
              child: Container(
                width: ResponsiveSize.width(8),
                height: ResponsiveSize.width(8),
                decoration: BoxDecoration(
                  color: selected ? AppColors.redPink : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
