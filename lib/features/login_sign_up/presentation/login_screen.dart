import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: ResponsiveSize.height(30)),
            Center(
              child: AppTexts(
                'Login',
                fontSize: ResponsiveSize.fontSize(24),
                fontWeight: FontWeight.bold,
                color: AppColors.redPink,
              ),
            ),

            SizedBox(height: ResponsiveSize.height(40)),
            AppTexts(
              'Email',
              fontSize: ResponsiveSize.fontSize(16),
              color: AppColors.brownPod,
            ),
          ],
        ),
      ),
    );
  }
}
