import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  InputDecoration _buildFieldDecoration({
    required String hintText,
    Widget? suffix,
  }) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide.none,
    );

    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: AppColors.brownPod.withAlpha(153),
        fontSize: ResponsiveSize.fontSize(14),
      ),
      filled: true,
      fillColor: AppColors.pink.withAlpha(77),
      border: baseBorder,
      enabledBorder: baseBorder,
      focusedBorder: baseBorder,
      contentPadding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(20),
        vertical: ResponsiveSize.height(6),
      ),
      suffixIcon: suffix,
    );
  }

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
            SizedBox(height: ResponsiveSize.height(80)),
            AppTexts(
              'Email',
              fontSize: ResponsiveSize.fontSize(16),
              color: AppColors.brownPod,
            ),
            SizedBox(height: ResponsiveSize.height(8)),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: _buildFieldDecoration(
                hintText: 'example@example.com',
              ),
            ),
            SizedBox(height: ResponsiveSize.height(24)),
            AppTexts(
              'Password',
              fontSize: ResponsiveSize.fontSize(16),
              color: AppColors.brownPod,
            ),
            SizedBox(height: ResponsiveSize.height(8)),
            TextFormField(
              obscureText: _obscurePassword,
              decoration: _buildFieldDecoration(
                hintText: '••••••••',
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
            ),
            SizedBox(height: ResponsiveSize.height(80)),
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
                label: "Login",
                onPressed: () {},
                buttonWidth: ResponsiveSize.width(207),
                buttonHeight: ResponsiveSize.height(45),
                isDisabled: true,
              ),
            ),
            SizedBox(height: ResponsiveSize.height(60)),
            Center(
              child: AppTexts(
                'Forgot Password?',
                fontSize: ResponsiveSize.fontSize(14),
                color: AppColors.brownPod,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
