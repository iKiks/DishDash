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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/core/assets/logo.png', width: 150, height: 150),
            const SizedBox(height: 20),
            AppTexts(
              'DishDash',
              fontSize: 63.5,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
