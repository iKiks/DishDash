import 'package:flutter/material.dart';

class ReuseableButtonLabel extends StatelessWidget {
  final bool isLoading;
  final String label;
  final Color textColor;

  const ReuseableButtonLabel({
    super.key,
    required this.isLoading,
    required this.label,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    final TextStyle baseStyle =
        Theme.of(context).textTheme.labelLarge ??
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

    return Text(
      label,
      textAlign: TextAlign.center,
      style: baseStyle.copyWith(color: textColor),
    );
  }
}
