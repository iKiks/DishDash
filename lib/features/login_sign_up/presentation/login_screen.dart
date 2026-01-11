import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/login_sign_up/presentation/widgets/auth_social_row.dart';
import 'package:dishdash/features/login_sign_up/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ResponsiveSize.height(30)),
            Center(
              child: AppTexts(
                'Login',
                fontSize: ResponsiveSize.fontSize(24),
                fontWeight: FontWeight.bold,
                color: AppColors.redPink,
              ),
            ),
            SizedBox(height: ResponsiveSize.height(90)),
            AuthTextField(
              label: 'Email',
              hintText: 'example@example.com',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: ResponsiveSize.height(24)),
            AuthTextField(
              label: 'Password',
              hintText: '••••••••',
              obscureText: _obscurePassword,
              suffix: IconButton(
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.brownPod.withAlpha(179),
                ),
              ),
            ),
            SizedBox(height: ResponsiveSize.height(60)),
            Center(
              child: ReuseableButton(
                label: "Login",
                onPressed: () {},
                buttonWidth: ResponsiveSize.width(207),
                buttonHeight: ResponsiveSize.height(45),
                isDisabled: true,
              ),
            ),
            SizedBox(height: ResponsiveSize.height(30)),
            Center(
              child: ReuseableButton(
                label: "Sign Up",
                onPressed: () {},
                buttonWidth: ResponsiveSize.width(207),
                buttonHeight: ResponsiveSize.height(45),
                isDisabled: true,
              ),
            ),
            SizedBox(height: ResponsiveSize.height(50)),

            Center(
              child: AppTexts(
                'Forgot Password?',
                fontSize: ResponsiveSize.fontSize(14),
                color: AppColors.brownPod,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: ResponsiveSize.height(35)),
            Center(
              child: AppTexts(
                'or sign up with',
                fontSize: ResponsiveSize.fontSize(10),
                color: AppColors.brownPod,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: ResponsiveSize.height(20)),
            const Center(child: AuthSocialRow()),
            SizedBox(height: ResponsiveSize.height(20)),
            Center(
              child: AppTexts(
                'Don’t have an account? Sign Up',
                fontSize: ResponsiveSize.fontSize(10),
                color: AppColors.brownPod,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
