import 'package:flutter/material.dart';

import 'button_metrics.dart';
import 'button_theme.dart';
import 'button_types.dart';

class ReuseableButtonStyleFactory {
  const ReuseableButtonStyleFactory._();

  static ButtonStyle build({
    required ReuseableButtonVariant variant,
    required ReuseableButtonSize size,
    Color? buttonColor,
    Color? textColor,
  }) {
    final backgroundColor =
        buttonColor ?? ReuseableButtonThemeHelper.backgroundColor(variant);
    final foregroundColor =
        textColor ??
        ReuseableButtonThemeHelper.foregroundColor(
          variant,
          buttonColor: buttonColor,
        );

    final disabledBackground =
        ReuseableButtonThemeHelper.disabledBackgroundColor(
          variant,
          backgroundColor,
        );
    final border = ReuseableButtonThemeHelper.borderSide(
      variant,
      buttonColor: buttonColor,
    );

    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: disabledBackground,
      disabledForegroundColor: foregroundColor.withOpacity(0.6),
      padding: ReuseableButtonMetrics.padding(size),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: border ?? BorderSide.none,
      ),
    );
  }
}
