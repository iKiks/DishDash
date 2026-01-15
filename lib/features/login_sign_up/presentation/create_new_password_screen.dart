import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/login_sign_up/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _rememberMe = false;

  void _toggleNewPasswordVisibility() {
    setState(() => _obscureNewPassword = !_obscureNewPassword);
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
  }

  void _handleContinue() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: AppColors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.width(24),
            vertical: ResponsiveSize.height(24),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: AppColors.redPink,
                size: ResponsiveSize.width(64),
              ),
              SizedBox(height: ResponsiveSize.height(20)),
              AppTexts(
                'Password Reset!',
                fontSize: ResponsiveSize.fontSize(20),
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ResponsiveSize.height(12)),
              AppTexts(
                'Your password has been changed successfully.',
                fontSize: ResponsiveSize.fontSize(14),
                height: 1.5,
                color: AppColors.brownPod.withAlpha(204),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ResponsiveSize.height(24)),
              ReuseableButton(
                label: 'Back to Login',
                onPressed: () => Navigator.of(context).pop(),
                buttonHeight: ResponsiveSize.height(48),
              ),
            ],
          ),
        );
      },
    );
  }

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
                  'Create A New Password',
                  fontSize: ResponsiveSize.fontSize(22),
                  fontWeight: FontWeight.w600,
                  color: AppColors.redPink,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(32)),
              AppTexts(
                'Create A New Password',
                fontSize: ResponsiveSize.fontSize(24),
                fontWeight: FontWeight.w700,
                color: AppColors.brownPod,
              ),
              SizedBox(height: ResponsiveSize.height(12)),
              AppTexts(
                'Enter your new password. If you forgot it then you have to do the step of forgot password.',
                fontSize: ResponsiveSize.fontSize(14),
                height: 1.5,
                color: AppColors.brownPod.withAlpha(204),
              ),
              SizedBox(height: ResponsiveSize.height(32)),
              AuthTextField(
                label: 'New Password',
                hintText: '••••••••',
                obscureText: _obscureNewPassword,
                textInputAction: TextInputAction.next,
                suffix: IconButton(
                  icon: Icon(
                    _obscureNewPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.brownPod.withAlpha(179),
                  ),
                  onPressed: _toggleNewPasswordVisibility,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(24)),
              AuthTextField(
                label: 'Confirm Password',
                hintText: '••••••••',
                obscureText: _obscureConfirmPassword,
                textInputAction: TextInputAction.done,
                suffix: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.brownPod.withAlpha(179),
                  ),
                  onPressed: _toggleConfirmPasswordVisibility,
                ),
              ),
              SizedBox(height: ResponsiveSize.height(24)),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _rememberMe = !_rememberMe),
                    child: Container(
                      width: ResponsiveSize.width(20),
                      height: ResponsiveSize.width(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.redPink,
                          width: 1.5,
                        ),
                        color: _rememberMe
                            ? AppColors.redPink.withAlpha(40)
                            : AppColors.white,
                      ),
                      child: _rememberMe
                          ? Icon(
                              Icons.check,
                              size: ResponsiveSize.width(14),
                              color: AppColors.redPink,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(width: ResponsiveSize.width(12)),
                  AppTexts(
                    'Remember me',
                    fontSize: ResponsiveSize.fontSize(14),
                    color: AppColors.brownPod,
                  ),
                ],
              ),
              SizedBox(height: ResponsiveSize.height(230)),
              Center(
                child: ReuseableButton(
                  label: 'Continue',
                  onPressed: _handleContinue,
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
