import 'package:dishdash/core/utils/responsiveness/app_responsiveness.dart';
import 'package:flutter/material.dart';
// import 'package:gleen/features/quizz/presentation/bloc/quiz_session/quiz_session_bloc.dart';

/// The root widget of the application.
///
/// This file now sets up the BLoC provider and integrates with `go_router`
/// to manage the app's navigation stack.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // This initializes the responsive sizing utility.
    ResponsiveSize.init(context);

    return  MaterialApp.router(
          title: 'G.L.E.E.N. App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // Use the router configuration from the 'router.dart' file.
          // routerConfig: AppRouter.router,
        );
  }
}