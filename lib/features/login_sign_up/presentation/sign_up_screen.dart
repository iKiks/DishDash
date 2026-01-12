import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/login_sign_up/presentation/complete_profile_screen.dart';
import 'package:dishdash/features/login_sign_up/presentation/login_screen.dart';
import 'package:dishdash/features/login_sign_up/presentation/widgets/auth_text_field.dart';
import 'package:dishdash/features/login_sign_up/presentation/widgets/sign_up_success_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TapGestureRecognizer _loginTapRecognizer;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _loginTapRecognizer = TapGestureRecognizer()..onTap = _handleLoginTap;
  }

  @override
  void dispose() {
    _loginTapRecognizer.dispose();
    super.dispose();
  }

  void _handleLoginTap() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

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

              /// Title
              Center(
                child: AppTexts(
                  'Sign Up',
                  fontSize: ResponsiveSize.fontSize(24),
                  fontWeight: FontWeight.bold,
                  color: AppColors.redPink,
                ),
              ),

              SizedBox(height: ResponsiveSize.height(40)),

              /// Full Name
              const AuthTextField(
                label: 'Full Name',
                hintText: 'John Doe',
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
              ),

              SizedBox(height: ResponsiveSize.height(24)),

              /// Email
              const AuthTextField(
                label: 'Email',
                hintText: 'example@example.com',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),

              SizedBox(height: ResponsiveSize.height(24)),

              /// Mobile Number
              const AuthTextField(
                label: 'Mobile Number',
                hintText: '+123 456 789',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),

              SizedBox(height: ResponsiveSize.height(24)),

              /// Date of Birth
              const AuthTextField(
                label: 'Date Of Birth',
                hintText: 'DD / MM / YYYY',
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
              ),

              SizedBox(height: ResponsiveSize.height(24)),

              /// Password
              AuthTextField(
                label: 'Password',
                hintText: '••••••••',
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
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

              /// Confirm Password
              AuthTextField(
                label: 'Confirm Password',
                hintText: '••••••••',
                obscureText: _obscureConfirmPassword,
                textInputAction: TextInputAction.done,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
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

              /// Terms & Privacy
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
                    children: const [
                      TextSpan(text: 'By continuing, you agree to\n'),
                      TextSpan(
                        text: 'Terms of Use',
                        style: TextStyle(
                          color: AppColors.redPink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: ' and '),
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

              /// Sign Up Button
              Center(
                child: ReuseableButton(
                  label: 'Sign Up',
                  onPressed: _showSuccessDialog,
                  buttonWidth: ResponsiveSize.width(207),
                  buttonHeight: ResponsiveSize.height(52),
                ),
              ),

              SizedBox(height: ResponsiveSize.height(24)),
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
                      TextSpan(text: 'Already have an account? '),
                      TextSpan(
                        text: 'Log In',
                        style: TextStyle(
                          color: AppColors.redPink,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: _loginTapRecognizer,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showSuccessDialog() async {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Sign up success',
      barrierColor: Colors.transparent,
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: const SignUpSuccessDialog(),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    await Navigator.of(context, rootNavigator: true).maybePop();

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const CompleteProfileScreen()),
    );
  }
}
