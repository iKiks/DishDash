/* ----------------------------- BACK BUTTON -------------------------------- */

import 'package:flutter/material.dart';

/// Reusable inline back button that respects layout parents.
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 22,
      icon: Image.asset('lib/core/assets/icons/arrow.png'),
      onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
    );
  }
}
