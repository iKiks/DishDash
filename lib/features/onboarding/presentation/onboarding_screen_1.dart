import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ResponsiveSize.height(100)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(30)),
            child: AppTexts(
              'Get inspired',
              fontSize: ResponsiveSize.fontSize(20),
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(30)),
            child: AppTexts(
              'Get inspired with our daily recipe recommendations.',
              fontSize: ResponsiveSize.fontSize(13),
            ),
          ),
        ],
      ),
    );
  }
}
