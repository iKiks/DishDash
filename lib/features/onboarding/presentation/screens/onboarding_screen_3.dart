import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/buttons/back_button.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/onboarding/presentation/screens/onboarding_screen_4.dart';
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
              const CustomBackButton(),
              SizedBox(height: ResponsiveSize.height(8)),

              _HeroImage(),

              SizedBox(height: ResponsiveSize.height(16)),

              _WelcomeText(),

              SizedBox(height: ResponsiveSize.height(20)),

              _ActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }
}

/* ----------------------------- HERO IMAGE ----------------------------- */

class _HeroImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'lib/core/assets/onboarding_3.png',
          height: ResponsiveSize.height(450),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/* ----------------------------- TEXT ---------------------------------- */

class _WelcomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTexts(
          "Welcome",
          fontSize: ResponsiveSize.fontSize(25),
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: ResponsiveSize.height(6)),
        AppTexts(
          "Find the best recipes the world has to offer, with step-by-step guidance to help you improve your cooking skills.",
          fontSize: ResponsiveSize.fontSize(13),
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/* ----------------------------- BUTTONS -------------------------------- */

class _ActionButtons extends StatelessWidget {
  final BuildContext context;
  const _ActionButtons(this.context);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReuseableButton(
          buttonWidth: ResponsiveSize.width(207),
          buttonHeight: ResponsiveSize.height(45),
          label: "I'm New",
          isDisabled: true,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const OnboardingScreen4(),
              ),
            );
          },
        ),
        SizedBox(height: ResponsiveSize.height(15)),
        ReuseableButton(
          buttonWidth: ResponsiveSize.width(207),
          buttonHeight: ResponsiveSize.height(45),
          label: "I've Been Here",
          isDisabled: true,
          onPressed: () {
            // TODO: handle returning users
          },
        ),
      ],
    );
  }
}
