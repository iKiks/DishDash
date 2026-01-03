import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class Launchscreen extends StatelessWidget {
  const Launchscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redPink,
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo_white.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            AppTexts(
              'DishDash',
              fontSize: 65,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}