import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:flutter/material.dart';

class ReuseableButtonLabel extends StatelessWidget {
  final bool isLoading;
  final bool isDisabled;
  final String label;
  final Color textColor;

  const ReuseableButtonLabel({
    super.key,
    this.isDisabled = false,
    required this.isLoading,

    required this.label,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    final TextStyle baseStyle =
        Theme.of(context).textTheme.labelLarge ??
        TextStyle(
          fontSize: ResponsiveSize.fontSize(16),
          fontWeight: FontWeight.w600,
          color: isDisabled ? AppColors.redPink : AppColors.white,
        );

    return Text(
      label,
      textAlign: TextAlign.center,
      style: baseStyle.copyWith(color: textColor),
    );
  }
}
