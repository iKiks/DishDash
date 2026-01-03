import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

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
    final Color resolvedBackground = _resolveBackgroundColor(disabledState);
    final Color resolvedForeground =
        textColor ?? (isTransparent ? AppColors.redPink : Colors.white);
    final double resolvedHeight = buttonHeight ?? 56;
    final double resolvedWidth = buttonWidth ?? double.infinity;

    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: Size(resolvedWidth, resolvedHeight),
      backgroundColor: resolvedBackground,
      disabledBackgroundColor: _resolveDisabledBackground(),
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
        onPressed: disabledState ? null : onPressed,
        child: child ?? _buildLabel(context, resolvedForeground),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, Color resolvedForeground) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(resolvedForeground),
        ),
      );
    }

    final TextStyle baseStyle =
        Theme.of(context).textTheme.labelLarge ??
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

    return Text(
      label,
      textAlign: TextAlign.center,
      style: baseStyle.copyWith(color: resolvedForeground),
    );
  }

  Color _resolveBackgroundColor(bool disabledState) {
    if (isTransparent) {
      return Colors.transparent;
    }
    if (disabledState) {
      return buttonColor ?? AppColors.pink;
    }
    return buttonColor ?? AppColors.redPink;
  }

  Color _resolveDisabledBackground() {
    if (isTransparent) {
      return Colors.transparent;
    }
    return buttonColor ?? AppColors.pink;
  }
}
