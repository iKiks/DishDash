import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/buttons/back_button.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen5 extends StatefulWidget {
  const OnboardingScreen5({super.key});

  @override
  State<OnboardingScreen5> createState() => _OnboardingScreen5State();
}

class _OnboardingScreen5State extends State<OnboardingScreen5> {
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
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.width(16),
                  vertical: ResponsiveSize.height(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ResponsiveSize.height(8)),
                    AppTexts(
                      'Select your cuisines preferences',
                      fontSize: ResponsiveSize.fontSize(20),
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: ResponsiveSize.height(15)),
                    AppTexts(
                      'Please select your cuisines preferences for a better recommendations or you can skip it.',
                      fontSize: ResponsiveSize.fontSize(13),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              SizedBox(height: ResponsiveSize.height(15)),
              _ContinueButton(),
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
    return Center(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.redPink,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ResponsiveSize.height(32),
      left: 0,
      right: 0,
      child: Center(
        child: ReuseableButton(
          buttonWidth: ResponsiveSize.width(207),
          buttonHeight: ResponsiveSize.height(45),
          label: "Continue",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const OnboardingScreen5()),
            );
          },
        ),
      ),
    );
  }
}
