import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    return const Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: AppTexts(
            'Categories',
            fontSize: 20,
            color: AppColors.redPink,
            fontWeightToken: AppFontWeight.semiBold,
          ),
        ),
      ),
    );
  }
}
