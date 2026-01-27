import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:flutter/material.dart';

class DishDashNavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final double iconSize;
  final Color color;
  final ValueChanged<int> onTap;
  final String semanticsLabel;

  const DishDashNavItem({
    super.key,
    required this.index,
    required this.icon,
    required this.iconSize,
    required this.color,
    required this.onTap,
    required this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: InkResponse(
        onTap: () => onTap(index),
        radius: ResponsiveSize.width(34),
        child: SizedBox(
          width: ResponsiveSize.width(56),
          height: double.infinity,
          child: Center(
            child: Icon(icon, size: iconSize, color: color),
          ),
        ),
      ),
    );
  }
}
