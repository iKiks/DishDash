import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class TrendingRecipeMetaPill extends StatelessWidget {
  final Widget iconWidget;
  final String text;

  const TrendingRecipeMetaPill({
    super.key,
    required this.iconWidget,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconWidget,
        SizedBox(width: ResponsiveSize.width(4)),
        AppTexts(
          text,
          fontSize: ResponsiveSize.fontSize(12),
          color: Colors.white,
          fontWeightToken: AppFontWeight.medium,
        ),
      ],
    );
  }
}
