import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class DifficultyInline extends StatelessWidget {
  final String text;

  const DifficultyInline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.signal_cellular_alt,
          size: ResponsiveSize.width(14),
          color: AppColors.redPink,
        ),
        SizedBox(width: ResponsiveSize.width(4)),
        AppTexts(
          text,
          fontSize: ResponsiveSize.fontSize(10.5),
          color: AppColors.redPink,
          fontWeightToken: AppFontWeight.medium,
        ),
      ],
    );
  }
}
