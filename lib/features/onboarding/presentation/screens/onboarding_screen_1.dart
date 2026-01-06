import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/onboarding/presentation/screens/onboarding_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ResponsiveSize.height(50)),
            _TitleSection(),
            _ImageSection(),
          ],
        ),
      ),
    );
  }
}

/* ----------------------------- TITLE SECTION ----------------------------- */

class _TitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveSize.width(30);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts(
            'Get inspired',
            fontSize: ResponsiveSize.fontSize(20),
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: ResponsiveSize.height(6)),
          AppTexts(
            'Get inspired with our daily recipe recommendations.',
            fontSize: ResponsiveSize.fontSize(13),
          ),
        ],
      ),
    );
  }
}

/* ----------------------------- IMAGE SECTION ------------------------------ */

class _ImageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _BackgroundImage(),
        _TopFade(),
        _BottomFade(),
        _ContinueButton(),
      ],
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        'lib/core/assets/onboarding_1.png',
        fit: BoxFit.cover,
        height: ResponsiveSize.height(620),
      ),
    );
  }
}

/* ------------------------------ GRADIENTS -------------------------------- */

class _TopFade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      child: Container(
        height: ResponsiveSize.height(250),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.white, AppColors.white.withAlpha(0)],
          ),
        ),
      ),
    );
  }
}

class _BottomFade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: ResponsiveSize.height(120),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.white.withAlpha(0), AppColors.white],
          ),
        ),
      ),
    );
  }
}

/* ------------------------------ BUTTON ----------------------------------- */

class _ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ResponsiveSize.height(580),
      left: 0,
      right: 0,
      child: Center(
        child: ReuseableButton(
          buttonWidth: ResponsiveSize.width(207),
          buttonHeight: ResponsiveSize.height(45),
          label: "Continue",
          isDisabled: true,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OnboardingScreen2(),
              ),
            );
          },
        ),
      ),
    );
  }
}
