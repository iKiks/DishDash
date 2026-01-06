import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:flutter/material.dart';

/// Positioned back button intended for overlaying on top of imagery.
class OverlayBackButton extends StatelessWidget {
  const OverlayBackButton({
    super.key,
    this.onPressed,
    this.iconAssetPath = 'lib/core/assets/icons/arrow.png',
    this.splashRadius = 22,
    this.top,
    this.left,
  });

  final VoidCallback? onPressed;
  final String iconAssetPath;
  final double splashRadius;
  final double? top;
  final double? left;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top ?? ResponsiveSize.height(12),
      left: left ?? ResponsiveSize.width(16),
      child: IconButton(
        splashRadius: splashRadius,
        icon: Image.asset(iconAssetPath),
        onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
      ),
    );
  }
}
