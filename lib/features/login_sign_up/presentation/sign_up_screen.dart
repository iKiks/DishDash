import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/login_sign_up/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.width(30),
            vertical: ResponsiveSize.height(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ResponsiveSize.height(10)),
              Center(
                child: AppTexts(
                  'Sign Up',
                  fontSize: ResponsiveSize.fontSize(24),
                  fontWeight: FontWeight.bold,
                  color: AppColors.redPink,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(40)),
              const AuthTextField(
                label: 'Full Name',
                hintText: 'John Doe',
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: ResponsiveSize.height(24)),
              const AuthTextField(
                label: 'Email',
                hintText: 'example@example.com',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: ResponsiveSize.height(24)),
              const AuthTextField(
                label: 'Mobile Number',
                hintText: '+ 123 456 789',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: ResponsiveSize.height(24)),
              const AuthTextField(
                label: 'Date Of Birth',
                hintText: 'DD / MM / YYY',
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: ResponsiveSize.height(24)),
              AuthTextField(
                label: 'Password',
                hintText: '••••••••',
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
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
              SizedBox(height: ResponsiveSize.height(24)),
              AuthTextField(
                label: 'Confirm Password',
                hintText: '••••••••',
                obscureText: _obscureConfirmPassword,
                textInputAction: TextInputAction.done,
                suffix: IconButton(
                  onPressed: () {
                    setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword,
                    );
                  },
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.brownPod.withAlpha(179),
                  ),
                ),
              ),
              SizedBox(height: ResponsiveSize.height(32)),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: AppFontFamily.poppins.familyName,
                      fontSize: ResponsiveSize.fontSize(12),
                      color: AppColors.brownPod.withAlpha(204),
                      height: 1.4,
                    ),
                    children: [
                        const TextSpan(text: 'By continuing, you agree to\n'),
                      TextSpan(
                        text: 'Terms of Use',
                        style: TextStyle(
                          color: AppColors.redPink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(
                          color: AppColors.redPink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ResponsiveSize.height(32)),
              Center(
                child: ReuseableButton(
                  label: 'Sign Up',
                  onPressed: () {},
                  buttonWidth: ResponsiveSize.width(207),
                  buttonHeight: ResponsiveSize.height(52),
                  isDisabled: true,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(24)),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTexts(
                      'Already have an account? ',
                      fontSize: ResponsiveSize.fontSize(12),
                      color: AppColors.brownPod,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: AppTexts(
                        'Log In',
                        fontSize: ResponsiveSize.fontSize(12),
                        color: AppColors.redPink,
                        fontWeightToken: AppFontWeight.semiBold,
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
