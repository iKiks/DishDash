import 'package:flutter/material.dart';

import 'button_types.dart';

class ReuseableButtonMetrics {
  const ReuseableButtonMetrics._();

  static EdgeInsets padding(ReuseableButtonSize size) {
    switch (size) {
      case ReuseableButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case ReuseableButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 14);
      case ReuseableButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
  }

  static double height(ReuseableButtonSize size) {
    switch (size) {
      case ReuseableButtonSize.small:
        return 40;
      case ReuseableButtonSize.medium:
        return 48;
      case ReuseableButtonSize.large:
        return 56;
    }
  }

  static double fontSize(ReuseableButtonSize size) {
    switch (size) {
      case ReuseableButtonSize.small:
        return 14;
      case ReuseableButtonSize.medium:
        return 16;
      case ReuseableButtonSize.large:
        return 18;
    }
  }

  static double iconSize(ReuseableButtonSize size) {
    switch (size) {
      case ReuseableButtonSize.small:
        return 16;
      case ReuseableButtonSize.medium:
        return 20;
      case ReuseableButtonSize.large:
        return 22;
    }
  }
}
