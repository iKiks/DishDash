import 'package:dishdash/core/theme/app_colors.dart';
import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:dishdash/core/widgets/buttons/app_buttons.dart';
import 'package:dishdash/core/widgets/texts/app_texts.dart';
import 'package:dishdash/features/login_sign_up/presentation/bloc/auth_bloc.dart';
import 'package:dishdash/features/login_sign_up/presentation/bloc/auth_bloc_factory.dart';
import 'package:dishdash/features/login_sign_up/presentation/sign_up_screen.dart';
import 'package:dishdash/features/login_sign_up/presentation/widgets/auth_social_row.dart';
import 'package:dishdash/features/login_sign_up/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBlocFactory.create(),
      child: const _LoginScreenView(),
    );
  }
}

class _LoginScreenView extends StatefulWidget {
  const _LoginScreenView();

  @override
  State<_LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<_LoginScreenView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _obscurePassword = true;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    print('[LoginScreen] initState');
    _emailController = TextEditingController()
      ..addListener(_updateFormValidity);
    _passwordController = TextEditingController()
      ..addListener(_updateFormValidity);
  }

  @override
  void dispose() {
    print('[LoginScreen] dispose');
    _emailController
      ..removeListener(_updateFormValidity)
      ..dispose();
    _passwordController
      ..removeListener(_updateFormValidity)
      ..dispose();
    super.dispose();
  }

  void _updateFormValidity() {
    final bool isValid =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
      print('[LoginScreen] Form validity changed: $_isFormValid');
    }
  }

  Future<void> _onLoginPressed() async {
    print('[LoginScreen] Login button pressed');
    if (context.read<AuthBloc>().state.loginStatus == RequestStatus.loading) {
      print('[LoginScreen] Login already in progress, ignoring');
      return;
    }

    if (!_formKey.currentState!.validate()) {
      print('[LoginScreen] Form validation failed');
      return;
    }

    FocusScope.of(context).unfocus();
    print('[LoginScreen] Dispatching LoginSubmitted for ${_emailController.text.trim()}');

    context.read<AuthBloc>().add(
      LoginSubmitted(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.loginStatus != current.loginStatus ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (!mounted) return;
        if (state.loginStatus == RequestStatus.failure &&
            state.errorMessage != null) {
          print('[LoginScreen] Login failed: ${state.errorMessage}');
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }

        if (state.loginStatus == RequestStatus.success) {
          print('[LoginScreen] Login success received');
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Login successful')));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
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
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!value.contains('@')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ResponsiveSize.height(24)),
                  AuthTextField(
                    label: 'Password',
                    hintText: '••••••••',
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
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
                      label: 'Login',
                      onPressed: _onLoginPressed,
                      buttonWidth: ResponsiveSize.width(207),
                      buttonHeight: ResponsiveSize.height(45),
                      isLoading: authState.loginStatus == RequestStatus.loading,
                      isDisabled: !_isFormValid,
                    ),
                  ),
                  SizedBox(height: ResponsiveSize.height(30)),
                  Center(
                    child: ReuseableButton(
                      label: 'Sign Up',
                      onPressed: () {
                        print('[LoginScreen] Navigating to SignUpScreen');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: context.read<AuthBloc>(),
                              child: const SignUpScreen(),
                            ),
                          ),
                        );
                      },
                      buttonWidth: ResponsiveSize.width(207),
                      buttonHeight: ResponsiveSize.height(45),
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
          ),
        ),
      ),
    );
  }
}
