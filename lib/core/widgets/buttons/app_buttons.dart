import 'package:flutter/material.dart';

import 'button_child.dart';
import 'button_metrics.dart';
import 'button_style.dart';
import 'button_types.dart';

class ReuseableButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? buttonColor;
  final Color? textColor;
  final Widget? child;
  final double? buttonWidth;
  final double? buttonHeight;
  final ButtonStyle? customButtonStyle;
  final IconData? icon;
  final double? iconSize;
  final ReuseableButtonVariant variant;
  final ReuseableButtonSize size;

  const ReuseableButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.buttonColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.customButtonStyle,
    this.icon,
    this.iconSize,
    this.child,
    this.variant = ReuseableButtonVariant.primary,
    this.size = ReuseableButtonSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final style =
        customButtonStyle ??
        ReuseableButtonStyleFactory.build(
          variant: variant,
          size: size,
          buttonColor: buttonColor,
          textColor: textColor,
        );

    return SizedBox(
      width: buttonWidth ?? double.infinity,
      height: buttonHeight ?? ReuseableButtonMetrics.height(size),
      child: ElevatedButton(
        style: style,
        onPressed: isLoading ? null : onPressed,
        child: ReuseableButtonChild(
          label: label,
          variant: variant,
          size: size,
          isLoading: isLoading,
          icon: icon,
          iconSize: iconSize,
          textColor: textColor,
          buttonColor: buttonColor,
          child: child,
        ),
      ),
    );
  }
}
