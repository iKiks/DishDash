import 'package:flutter/material.dart';

import '../texts/app_texts.dart';
import 'button_metrics.dart';
import 'button_theme.dart';
import 'button_types.dart';

class ReuseableButtonChild extends StatelessWidget {
  const ReuseableButtonChild({
    super.key,
    required this.label,
    required this.variant,
    required this.size,
    required this.isLoading,
    this.child,
    this.icon,
    this.iconSize,
    this.textColor,
    this.buttonColor,
  });

  final String label;
  final ReuseableButtonVariant variant;
  final ReuseableButtonSize size;
  final bool isLoading;
  final Widget? child;
  final IconData? icon;
  final double? iconSize;
  final Color? textColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    final color =
        textColor ??
        ReuseableButtonThemeHelper.foregroundColor(
          variant,
          buttonColor: buttonColor,
        );

    if (isLoading) {
      return _ButtonLoadingIndicator(color: color);
    }

    if (child != null) {
      return child!;
    }

    final labelWidget = Text(
      label,
      style: AppTextStyles.poppins(
        AppFontWeight.semiBold,
        fontSize: ReuseableButtonMetrics.fontSize(size),
        color: color,
      ),
      textAlign: TextAlign.center,
    );

    if (icon == null) {
      return labelWidget;
    }

    return _IconLabelRow(
      icon: icon!,
      iconSize: iconSize ?? ReuseableButtonMetrics.iconSize(size),
      color: color,
      label: labelWidget,
    );
  }
}

class _ButtonLoadingIndicator extends StatelessWidget {
  const _ButtonLoadingIndicator({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}

class _IconLabelRow extends StatelessWidget {
  const _IconLabelRow({
    required this.icon,
    required this.iconSize,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final double iconSize;
  final Color color;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: color),
        const SizedBox(width: 8),
        label,
      ],
    );
  }
}
