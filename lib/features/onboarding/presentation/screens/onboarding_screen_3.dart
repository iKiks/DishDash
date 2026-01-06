import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/back_button.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen3 extends StatefulWidget {
  const OnboardingScreen3({super.key});

  @override
  State<OnboardingScreen3> createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends State<OnboardingScreen3> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.width(16),
            vertical: ResponsiveSize.height(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(),
              _ProgressBar(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ResponsiveSize.height(20)),
                    AppTexts(
                      '¿What is your cooking level?',
                      fontSize: ResponsiveSize.fontSize(20),
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: ResponsiveSize.height(15)),
                    AppTexts(
                      'Please select your cooking level for better recommendations.',
                      fontSize: ResponsiveSize.fontSize(13),
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: ResponsiveSize.height(20)),
                    Container(
                      width: double.infinity,
                      height: ResponsiveSize.height(116),
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveSize.width(17),
                        vertical: ResponsiveSize.height(12),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.sweetPink),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts(
                            'Novice',
                            fontSize: ResponsiveSize.fontSize(16),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: ResponsiveSize.height(12)),
                          AppTexts(
                            'I am new to cooking and want to learn the basics, from mastering simple knife skills to following easy recipes with confidence.',
                            fontSize: ResponsiveSize.fontSize(13),
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------------------- PROGRESS BAR ---------------------------- */

class _ProgressBar extends StatelessWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context) {
    final barHeight = ResponsiveSize.height(12);
    final barWidth = ResponsiveSize.width(230);
    final progressWidth = ResponsiveSize.width(230 / 3);

    return Center(
      child: SizedBox(
        height: barHeight,
        width: barWidth,
        child: Stack(
          children: [_Track(barHeight), _Progress(barHeight, progressWidth)],
        ),
      ),
    );
  }
}

class _Track extends StatelessWidget {
  final double height;

  const _Track(this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  final double height;
  final double width;

  const _Progress(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.redPink,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
