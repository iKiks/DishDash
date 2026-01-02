import 'package:flutter/material.dart';

/// Supported font families used across the app.
enum AppFontFamily { poppins, leagueSpartan }

/// Semantic weights for the design system.
enum AppFontWeight { bold, semiBold, medium, regular, light, thin }

extension AppFontFamilyExt on AppFontFamily {
  String get familyName => switch (this) {
        AppFontFamily.poppins => 'Poppins',
        AppFontFamily.leagueSpartan => 'League Spartan',
      };
}

extension AppFontWeightExt on AppFontWeight {
  FontWeight get materialWeight => switch (this) {
        AppFontWeight.bold => FontWeight.w700,
        AppFontWeight.semiBold => FontWeight.w600,
        AppFontWeight.medium => FontWeight.w500,
        AppFontWeight.regular => FontWeight.w400,
        AppFontWeight.light => FontWeight.w300,
        AppFontWeight.thin => FontWeight.w200,
      };
}

/// Helper methods to build text styles that follow the typography guide.
class AppTextStyles {
  const AppTextStyles._();

  static TextStyle poppins(
    AppFontWeight weight, {
    double fontSize = 14,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return _style(
      family: AppFontFamily.poppins,
      weight: weight,
      fontSize: fontSize,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle leagueSpartan(
    AppFontWeight weight, {
    double fontSize = 14,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return _style(
      family: AppFontFamily.leagueSpartan,
      weight: weight,
      fontSize: fontSize,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle _style({
    required AppFontFamily family,
    required AppFontWeight weight,
    required double fontSize,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: family.familyName,
      fontWeight: weight.materialWeight,
      fontSize: fontSize,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}

/// A reusable text widget following the app typography system.
class AppTexts extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final bool softWrap;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final double? height;
  final int? maxLines;
  final TextOverflow? overflow;
  final AppFontFamily fontFamily;
  final AppFontWeight? fontWeightToken;
  final FontWeight? fontWeight;

  const AppTexts(
    this.text, {
    super.key,
    required this.fontSize,
    this.color,
    this.textAlign,
    this.letterSpacing,
    this.height,
    this.maxLines,
    this.overflow,
    this.fontFamily = AppFontFamily.poppins,
    this.fontWeightToken,
    this.fontWeight,
    this.softWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily.familyName,
      fontWeight: fontWeightToken?.materialWeight ?? fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );

    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
