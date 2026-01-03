import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class ReuseableButtonColors {
  const ReuseableButtonColors._();

  static Color resolveBackground({
    required bool isTransparent,
    required bool isDisabled,
    Color? buttonColor,
  }) {
    if (isTransparent) {
      return Colors.transparent;
    }
    if (isDisabled) {
      return buttonColor ?? AppColors.pink;
    }
    return buttonColor ?? AppColors.redPink;
  }

  static Color resolveDisabledBackground({
    required bool isTransparent,
    Color? buttonColor,
  }) {
    if (isTransparent) {
      return Colors.transparent;
    }
    return buttonColor ?? AppColors.pink;
  }
}
