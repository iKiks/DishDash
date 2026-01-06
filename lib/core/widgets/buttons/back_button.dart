/* ----------------------------- BACK BUTTON -------------------------------- */

import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ResponsiveSize.height(12),
      left: ResponsiveSize.width(16),
      child: IconButton(
        splashRadius: 22,
        icon: Image.asset('lib/core/assets/icons/arrow.png'),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
    );
  }
}