import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ResponsiveSize.height(50)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveSize.width(30),
              ),
              child: AppTexts(
                'Get inspired',
                fontSize: ResponsiveSize.fontSize(20),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveSize.width(30),
              ),
              child: AppTexts(
                'Get inspired with our daily recipe recommendations.',
                fontSize: ResponsiveSize.fontSize(13),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    'lib/core/assets/onboarding_1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    height: ResponsiveSize.height(250),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.white.withAlpha(255),
                          AppColors.white.withAlpha(0),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: ResponsiveSize.height(80),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.white.withAlpha(0),
                          AppColors.white.withAlpha(255),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: ResponsiveSize.height(580),
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ReuseableButton(
                      buttonWidth: ResponsiveSize.width(207),
                      buttonHeight: ResponsiveSize.height(45),
                      label: "Continue",
                      onPressed: () {},
                      isDisabled: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
