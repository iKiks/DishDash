import 'dart:ui';

import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class SignUpSuccessDialog extends StatelessWidget {
  const SignUpSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final dialogRadius = BorderRadius.circular(36);

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: AppColors.black.withOpacity(0.1)),
          ),
        ),
        Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: ResponsiveSize.width(250),
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveSize.width(28),
                vertical: ResponsiveSize.height(36),
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: dialogRadius,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTexts(
                    'Sign Up Successful!',
                    fontSize: ResponsiveSize.fontSize(20),
                    color: AppColors.brownPod,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: ResponsiveSize.height(24)),
                  Container(
                    height: ResponsiveSize.height(96),
                    width: ResponsiveSize.height(96),
                    decoration: BoxDecoration(
                      color: AppColors.pink,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: AppColors.redPink,
                      size: ResponsiveSize.height(48),
                    ),
                  ),
                  SizedBox(height: ResponsiveSize.height(28)),
                  AppTexts(
                    'Lorem ipsum dolor sit amet pretium cras id dui pellentesque ornare. Quisque malesuada.',
                    fontSize: ResponsiveSize.fontSize(12),
                    color: AppColors.brownPod,
                    textAlign: TextAlign.center,
                    height: 1.5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
