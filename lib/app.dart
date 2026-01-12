import 'package:dishdash/features/launch/presentation/launchscreen.dart';
import 'package:dishdash/features/login_sign_up/presentation/forgot_password_1_screen.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_colors.dart';

class DishDashApp extends StatelessWidget {
  const DishDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DishDash',
      theme: _buildTheme(),
      home: const ForgotPasswordScreen1(),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _buildTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.redPink,
        secondary: AppColors.pink,
        surface: AppColors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.brownPod,
      ),
      scaffoldBackgroundColor: AppColors.white,
      textTheme: base.textTheme.apply(
        fontFamily: 'Poppins',
        bodyColor: AppColors.brownPod,
        displayColor: AppColors.brownPod,
      ),
    );
  }
}
