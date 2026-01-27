import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class MetaInline extends StatelessWidget {
  final String iconAsset;
  final String text;

  const MetaInline({super.key, required this.iconAsset, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          iconAsset,
          width: ResponsiveSize.width(14),
          height: ResponsiveSize.width(14),
          fit: BoxFit.contain,
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
