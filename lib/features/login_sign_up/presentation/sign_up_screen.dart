import 'package:dishdash/core/common/entities/user.dart';
import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/login_sign_up/presentation/bloc/auth_bloc.dart';
import 'package:dishdash/features/login_sign_up/presentation/bloc/auth_bloc_factory.dart';
import 'package:dishdash/features/login_sign_up/presentation/complete_profile_screen.dart';
import 'package:dishdash/features/login_sign_up/presentation/login_screen.dart';
import 'package:dishdash/features/login_sign_up/presentation/widgets/auth_text_field.dart';
import 'package:dishdash/features/login_sign_up/presentation/widgets/sign_up_success_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Always provide AuthBloc if not already in the tree
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBlocFactory.create(),
      child: const _SignUpView(),
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView();

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  final _formKey = GlobalKey<FormState>();
  late final TapGestureRecognizer _loginTapRecognizer;
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _dobController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _loginTapRecognizer = TapGestureRecognizer()..onTap = _handleLoginTap;

    _fullNameController = TextEditingController()
      ..addListener(_updateFormValidity);
    _emailController = TextEditingController()
      ..addListener(_updateFormValidity);
    _phoneController = TextEditingController()
      ..addListener(_updateFormValidity);
    _dobController = TextEditingController()..addListener(_updateFormValidity);
    _passwordController = TextEditingController()
      ..addListener(_updateFormValidity);
    _confirmPasswordController = TextEditingController()
      ..addListener(_updateFormValidity);
  }

  @override
  void dispose() {
    _loginTapRecognizer.dispose();
    _fullNameController
      ..removeListener(_updateFormValidity)
      ..dispose();
    _emailController
      ..removeListener(_updateFormValidity)
      ..dispose();
    _phoneController
      ..removeListener(_updateFormValidity)
      ..dispose();
    _dobController
      ..removeListener(_updateFormValidity)
      ..dispose();
    _passwordController
      ..removeListener(_updateFormValidity)
      ..dispose();
    _confirmPasswordController
      ..removeListener(_updateFormValidity)
      ..dispose();
    super.dispose();
  }

  void _handleLoginTap() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _updateFormValidity() {
    final passwordsMatch =
        _passwordController.text == _confirmPasswordController.text;
    final requiredFieldsFilled =
        _fullNameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;

    final isValid = requiredFieldsFilled && passwordsMatch;
    if (isValid != _isFormValid) setState(() => _isFormValid = isValid);
  }

  DateTime? _parseDateOfBirth(String value) {
    try {
      final sanitized = value.replaceAll(' ', '');
      final parts = sanitized.split(RegExp(r'[-/]'));
      if (parts.length != 3) return null;

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final date = DateTime(year, month, day);
      if (date.year != year || date.month != month || date.day != day)
        return null;

      return date;
    } catch (_) {
      return null;
    }
  }

  Future<void> _onSignUpPressed() async {
    final authBloc = context.read<AuthBloc>();
    if (authBloc.state.signUpStatus == RequestStatus.loading) return;
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final user = User(
      id: '',
      name: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim().isEmpty
          ? null
          : _phoneController.text.trim(),
      dateOfBirth: _parseDateOfBirth(_dobController.text.trim()),
    );

    authBloc.add(
      SignUpSubmitted(user: user, password: _passwordController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.signUpStatus != current.signUpStatus ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) async {
        final ctx = context; // capture context safely

        if (state.signUpStatus == RequestStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(ctx)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }

        if (state.signUpStatus == RequestStatus.success) {
          await _showSuccessDialog();

          if (!mounted) return;
          ctx.read<AuthBloc>().add(const AuthStatusCleared());

          if (!mounted) return;
          Navigator.of(ctx).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const CompleteProfileScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveSize.width(30),
              vertical: ResponsiveSize.height(30),
            ),
            child: Form(
              key: _formKey,
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
                  AuthTextField(
                    label: 'Full Name',
                    hintText: 'John Doe',
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    controller: _fullNameController,
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Full name is required'
                        : null,
                  ),
                  SizedBox(height: ResponsiveSize.height(24)),
                  AuthTextField(
                    label: 'Email',
                    hintText: 'example@example.com',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return 'Email is required';
                      if (!value.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  SizedBox(height: ResponsiveSize.height(24)),
                  AuthTextField(
                    label: 'Mobile Number',
                    hintText: '+123 456 789',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    controller: _phoneController,
                  ),
                  SizedBox(height: ResponsiveSize.height(24)),
                  AuthTextField(
                    label: 'Date Of Birth',
                    hintText: 'DD / MM / YYYY',
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    controller: _dobController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return null;
                      return _parseDateOfBirth(value.trim()) == null
                          ? 'Enter a valid date (DD/MM/YYYY)'
                          : null;
                    },
                  ),
                  SizedBox(height: ResponsiveSize.height(24)),
                  AuthTextField(
                    label: 'Password',
                    hintText: '••••••••',
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Password is required';
                      if (value.length < 6)
                        return 'Password must be at least 6 characters';
                      return null;
                    },
                    suffix: IconButton(
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
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
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Confirm your password';
                      if (value != _passwordController.text)
                        return 'Passwords do not match';
                      return null;
                    },
                    suffix: IconButton(
                      onPressed: () => setState(
                        () =>
                            _obscureConfirmPassword = !_obscureConfirmPassword,
                      ),
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
                  Center(
                    child: ReuseableButton(
                      label: 'Sign Up',
                      onPressed: _onSignUpPressed,
                      buttonWidth: ResponsiveSize.width(207),
                      buttonHeight: ResponsiveSize.height(52),
                      isLoading:
                          authState.signUpStatus == RequestStatus.loading,
                      isDisabled: !_isFormValid,
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
                          const TextSpan(text: 'Already have an account? '),
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
  }
}
