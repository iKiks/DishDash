import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'button_types.dart';

class ReuseableButtonThemeHelper {
  const ReuseableButtonThemeHelper._();

  static Color foregroundColor(
    ReuseableButtonVariant variant, {
    Color? buttonColor,
  }) {
    switch (variant) {
      case ReuseableButtonVariant.primary:
        return AppColors.white;
      case ReuseableButtonVariant.secondary:
        return AppColors.brownPod;
      case ReuseableButtonVariant.outline:
      case ReuseableButtonVariant.text:
        return buttonColor ?? AppColors.redPink;
    }
  }

  static Color backgroundColor(
    ReuseableButtonVariant variant, {
    Color? buttonColor,
  }) {
    switch (variant) {
      case ReuseableButtonVariant.primary:
        return buttonColor ?? AppColors.redPink;
      case ReuseableButtonVariant.secondary:
        return buttonColor ?? AppColors.pink;
      case ReuseableButtonVariant.outline:
        return AppColors.white;
      case ReuseableButtonVariant.text:
        return Colors.transparent;
    }
  }

  static Color disabledBackgroundColor(
    ReuseableButtonVariant variant,
    Color baseColor,
  ) {
    switch (variant) {
      case ReuseableButtonVariant.primary:
      case ReuseableButtonVariant.secondary:
        return baseColor.withOpacity(0.6);
      case ReuseableButtonVariant.outline:
        return AppColors.white.withOpacity(0.7);
      case ReuseableButtonVariant.text:
        return Colors.transparent;
    }
  }

  static BorderSide? borderSide(
    ReuseableButtonVariant variant, {
    Color? buttonColor,
  }) {
    if (variant == ReuseableButtonVariant.outline) {
      return BorderSide(color: buttonColor ?? AppColors.redPink, width: 1.5);
    }
    return null;
  }
}
