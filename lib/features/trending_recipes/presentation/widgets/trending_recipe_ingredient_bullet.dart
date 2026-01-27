import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:flutter/material.dart';

class TrendingRecipeIngredientBullet extends StatelessWidget {
  final String text;

  const TrendingRecipeIngredientBullet({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final match = RegExp(
      r'^\s*([0-9]+(?:\s+[0-9]+\/[0-9]+|\/[0-9]+)?|[0-9]+\/[0-9]+)\b',
    ).firstMatch(text);

    String? amount;
    String rest = text;
    if (match != null) {
      amount = match.group(1);
      rest = text.substring(match.end).trimLeft();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveSize.height(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: ResponsiveSize.height(6)),
            child: Container(
              width: ResponsiveSize.width(6),
              height: ResponsiveSize.width(6),
              decoration: const BoxDecoration(
                color: AppColors.redPink,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: ResponsiveSize.width(10)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: ResponsiveSize.fontSize(12),
                  color: AppColors.brownPod.withAlpha(190),
                  height: 1.4,
                ),
                children: [
                  if (amount != null) ...[
                    TextSpan(
                      text: '$amount ',
                      style: const TextStyle(color: AppColors.redPink),
                    ),
                  ],
                  TextSpan(text: rest),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
