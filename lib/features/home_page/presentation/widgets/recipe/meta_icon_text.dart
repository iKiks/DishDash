import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class MetaIconText extends StatelessWidget {
  final String iconAsset;
  final String text;
  final Color textColor;

  const MetaIconText({
    super.key,
    required this.iconAsset,
    required this.text,
    required this.textColor,
  });

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
        SizedBox(width: ResponsiveSize.width(6)),
        AppTexts(
          text,
          fontSize: ResponsiveSize.fontSize(11),
          color: textColor,
          fontWeightToken: AppFontWeight.semiBold,
        ),
      ],
    );
  }
}
