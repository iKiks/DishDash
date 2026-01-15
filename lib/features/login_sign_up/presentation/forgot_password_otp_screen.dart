import 'dart:async';
import 'package:flutter/material.dart';

import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/login_sign_up/presentation/create_new_password_screen.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  static const int _otpLength = 6;
  static const int _initialCountdown = 50;

  final List<String> _digits = [];
  Timer? _timer;
  int _secondsRemaining = _initialCountdown;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _onDigitPressed(String digit) {
    if (_digits.length >= _otpLength) return;
    setState(() => _digits.add(digit));
  }

  void _onDeletePressed() {
    if (_digits.isEmpty) return;
    setState(() => _digits.removeLast());
  }

  void _handleResend() {
    if (_secondsRemaining > 0) return;
    setState(() => _secondsRemaining = _initialCountdown);
    _startCountdown();
  }

  void _onContinue() {
    if (_digits.length != _otpLength) return;

    final otp = _digits.join();
    debugPrint('OTP entered: $otp');

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const CreateNewPasswordScreen()));
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
            vertical: ResponsiveSize.height(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTexts(
                'Forgot Your Password',
                fontSize: ResponsiveSize.fontSize(22),
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: ResponsiveSize.height(12)),
              AppTexts(
                'We’ve sent a verification code to your email. Enter it below.',
                fontSize: ResponsiveSize.fontSize(14),
                height: 1.5,
                color: AppColors.brownPod.withAlpha(200),
              ),

              SizedBox(height: ResponsiveSize.height(32)),

              _OtpFields(digits: _digits, length: _otpLength),

              SizedBox(height: ResponsiveSize.height(32)),

              Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _secondsRemaining == 0 ? _handleResend : null,
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
                              ? '${_secondsRemaining.toString().padLeft(2, '0')} sec'
                              : 'now',
                          style: TextStyle(color: AppColors.redPink),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),

              _NumericKeypad(
                onDigitPressed: _onDigitPressed,
                onDeletePressed: _onDeletePressed,
              ),

              SizedBox(height: ResponsiveSize.height(24)),

              ReuseableButton(
                label: 'Continue',
                onPressed: _onContinue,
                isDisabled: _digits.length != _otpLength,
                buttonHeight: ResponsiveSize.height(52),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpFields extends StatelessWidget {
  const _OtpFields({required this.digits, required this.length});

  final List<String> digits;
  final int length;

  @override
  Widget build(BuildContext context) {
    final double size = ResponsiveSize.width(44);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(length, (index) {
        final hasValue = index < digits.length;
        final isActive = index == digits.length && digits.length < length;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.redPink,
              width: isActive ? 2 : 1.5,
            ),
            color: hasValue ? AppColors.redPink.withAlpha(30) : AppColors.white,
          ),
          child: hasValue
              ? AppTexts(
                  digits[index],
                  fontSize: ResponsiveSize.fontSize(18),
                  fontWeight: FontWeight.w600,
                )
              : const SizedBox.shrink(),
        );
      }),
    );
  }
}

class _NumericKeypad extends StatelessWidget {
  const _NumericKeypad({
    required this.onDigitPressed,
    required this.onDeletePressed,
  });

  final ValueChanged<String> onDigitPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final double height = ResponsiveSize.height(64);
    final double spacing = ResponsiveSize.height(14);

    Widget row(List<Widget> children) => Row(
      children: children.map((e) => Expanded(child: e)).toList(growable: false),
    );

    Widget key(String value) => _KeyButton(
      height: height,
      label: value,
      onTap: () => onDigitPressed(value),
    );

    return Column(
      children: [
        row([key('1'), key('2'), key('3')]),
        SizedBox(height: spacing),
        row([key('4'), key('5'), key('6')]),
        SizedBox(height: spacing),
        row([key('7'), key('8'), key('9')]),
        SizedBox(height: spacing),
        row([
          const SizedBox(),
          key('0'),
          _KeyButton(
            height: height,
            icon: Icons.backspace_outlined,
            onTap: onDeletePressed,
          ),
        ]),
      ],
    );
  }
}

class _KeyButton extends StatelessWidget {
  const _KeyButton({
    this.label,
    this.icon,
    required this.height,
    required this.onTap,
  });

  final String? label;
  final IconData? icon;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(6)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.redPink.withAlpha(120)),
        ),
        child: Center(
          child: label != null
              ? AppTexts(
                  label!,
                  fontSize: ResponsiveSize.fontSize(20),
                  fontWeight: FontWeight.w600,
                )
              : Icon(icon, size: 24),
        ),
      ),
    );
  }
}
