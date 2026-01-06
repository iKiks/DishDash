import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'button_colors.dart';
import 'button_label.dart';

class ReuseableButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? buttonColor;
  final Color? textColor;
  final Widget? child;
  final double? buttonWidth;
  final double? buttonHeight;
  final bool isDisabled;
  final bool isTransparent;
  final double borderRadius;

  const ReuseableButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.buttonColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.child,
    this.isDisabled = false,
    this.isTransparent = false,
    this.borderRadius = 100,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabledState = isDisabled || isLoading;
    final Color resolvedBackground = ReuseableButtonColors.resolveBackground(
      isTransparent: isTransparent,
      isDisabled: disabledState,
      buttonColor: buttonColor,
    );
    final Color resolvedForeground =
        textColor ??
        (disabledState || isTransparent ? AppColors.redPink : AppColors.white);
    final double resolvedHeight = buttonHeight ?? 56;
    final double resolvedWidth = buttonWidth ?? double.infinity;

    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: Size(resolvedWidth, resolvedHeight),
      backgroundColor: resolvedBackground,
      disabledBackgroundColor: ReuseableButtonColors.resolveDisabledBackground(
        isTransparent: isTransparent,
        buttonColor: buttonColor,
      ),
      foregroundColor: resolvedForeground,
      disabledForegroundColor: resolvedForeground,
      shadowColor: isTransparent ? Colors.transparent : null,
      elevation: isTransparent ? 0 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: isTransparent
            ? BorderSide(color: buttonColor ?? AppColors.redPink)
            : BorderSide.none,
      ),
    );

    return SizedBox(
      width: resolvedWidth,
      height: resolvedHeight,
      child: ElevatedButton(
        style: style,
        onPressed: onPressed,
        child:
            child ??
            ReuseableButtonLabel(
              isLoading: isLoading,
              label: label,
              textColor: resolvedForeground,
              isDisabled: disabledState,
            ),
      ),
    );
  }
}
