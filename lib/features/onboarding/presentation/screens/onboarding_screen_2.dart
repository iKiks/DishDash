import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/buttons/overlay_back_button.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/onboarding/presentation/screens/onboarding_screen_3.dart';
import 'package:dishdash/features/onboarding/presentation/screens/onboarding_screen_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
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
        child: Stack(children: const [_Content(), OverlayBackButton()]),
      ),
    );
  }
}

/* ------------------------------ CONTENT ---------------------------------- */

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ResponsiveSize.height(50)),
        _TitleSection(),
        const Expanded(child: _ImageSection()),
      ],
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
            'Get an increase your skills',
            fontSize: ResponsiveSize.fontSize(20),
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: ResponsiveSize.height(6)),
          AppTexts(
            'Learn essential cooking techniques at your own pace.',
            fontSize: ResponsiveSize.fontSize(13),
          ),
        ],
      ),
    );
  }
}

/* ----------------------------- IMAGE SECTION ------------------------------ */

class _ImageSection extends StatelessWidget {
  const _ImageSection();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: const [
        _BackgroundImage(),
        _TopFade(),
        _BottomFade(),
        _ContinueButton(),
      ],
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset('lib/core/assets/onboarding_2.png', fit: BoxFit.cover),
    );
  }
}

/* ------------------------------ GRADIENTS -------------------------------- */

class _TopFade extends StatelessWidget {
  const _TopFade();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
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
  const _BottomFade();

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
          isDisabled: true,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const OnboardingScreen3()),
            );
          },
        ),
      ),
    );
  }
}
