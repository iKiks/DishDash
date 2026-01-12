import 'dart:async';

import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  static const int _initialCountdown = 49;

  late int _secondsRemaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = _initialCountdown;
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() => _secondsRemaining = 0);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.width(30),
            vertical: ResponsiveSize.height(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ResponsiveSize.height(8)),
              Center(
                child: AppTexts(
                  'Forgot Your Password',
                  fontSize: ResponsiveSize.fontSize(22),
                  fontWeight: FontWeight.w600,
                  color: AppColors.redPink,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(36)),
              AppTexts(
                "You've Got Mail",
                fontSize: ResponsiveSize.fontSize(24),
                fontWeight: FontWeight.w700,
                color: AppColors.brownPod,
              ),
              SizedBox(height: ResponsiveSize.height(12)),
              AppTexts(
                'We will send you the verification code to your email address, check your email and put the code right below.',
                fontSize: ResponsiveSize.fontSize(14),
                color: AppColors.brownPod.withAlpha(204),
                height: 1.5,
              ),
              SizedBox(height: ResponsiveSize.height(32)),
              const _OtpFields(),
              SizedBox(height: ResponsiveSize.height(32)),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: AppFontFamily.poppins.familyName,
                      fontSize: ResponsiveSize.fontSize(13),
                      height: 1.4,
                      color: AppColors.brownPod.withAlpha(204),
                    ),
                    children: [
                      const TextSpan(
                        text: "Didn't receive the mail?\nYou can resend it ",
                      ),
                      TextSpan(
                        text: _secondsRemaining > 0
                            ? 'in ${_secondsRemaining.toString().padLeft(2, '0')} sec'
                            : 'now',
                        style: TextStyle(color: AppColors.redPink),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: ReuseableButton(
                  label: 'Continue',
                  onPressed: () {},
                  buttonWidth: ResponsiveSize.width(207),
                  buttonHeight: ResponsiveSize.height(52),
                  isDisabled: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpFields extends StatelessWidget {
  const _OtpFields();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _StaticDigit('2'),
        _StaticDigit('7'),
        _StaticDigit('3'),
        _StaticDigit('9'),
        _StaticDigit('1'),
        _StaticDigit('6'),
      ],
    );
  }
}

class _StaticDigit extends StatelessWidget {
  const _StaticDigit(this.digit);

  final String digit;

  @override
  Widget build(BuildContext context) {
    final double fieldSize = ResponsiveSize.width(40);

    return Container(
      width: fieldSize,
      height: fieldSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.redPink, width: 1.5),
      ),
      child: AppTexts(
        digit,
        fontSize: ResponsiveSize.fontSize(20),
        fontWeight: FontWeight.w600,
        color: AppColors.brownPod,
      ),
    );
  }
}
