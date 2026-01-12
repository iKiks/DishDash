import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/login_sign_up/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen1 extends StatelessWidget {
  const ForgotPasswordScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                'Hello There!',
                fontSize: ResponsiveSize.fontSize(24),
                fontWeight: FontWeight.w700,
                color: AppColors.brownPod,
              ),
              SizedBox(height: ResponsiveSize.height(12)),
              AppTexts(
                'Enter your email address. We will send a code verification in the next step.',
                fontSize: ResponsiveSize.fontSize(14),
                color: AppColors.brownPod.withAlpha(204),
                height: 1.5,
              ),
              SizedBox(height: ResponsiveSize.height(40)),
              const AuthTextField(
                label: 'Email',
                hintText: 'example@example.com',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: ResponsiveSize.height(370)),
              Center(
                child: ReuseableButton(
                  label: 'Continue',
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot_password_otp_screen');
                  },
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
