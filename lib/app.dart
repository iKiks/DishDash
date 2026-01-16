import 'package:dishdash/features/launch/presentation/launchscreen.dart';
import 'package:dishdash/features/login_sign_up/presentation/bloc/auth_bloc.dart';
import 'package:dishdash/features/login_sign_up/presentation/bloc/auth_bloc_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_colors.dart';

class DishDashApp extends StatelessWidget {
  const DishDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('[DishDashApp] Building application');
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBlocFactory.create(),
      child: MaterialApp(
        title: 'DishDash',
        theme: _buildTheme(),
        home: const Launchscreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  ThemeData _buildTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.redPink,
        secondary: AppColors.pink,
        surface: AppColors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.brownPod,
      ),
      scaffoldBackgroundColor: AppColors.white,
      textTheme: base.textTheme.apply(
        fontFamily: 'Poppins',
        bodyColor: AppColors.brownPod,
        displayColor: AppColors.brownPod,
      ),
    );
  }
}
