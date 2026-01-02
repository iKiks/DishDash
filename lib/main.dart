import 'package:dishdash/app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setupDependencies(); // Initialize dependencies


  // // Initialize Hive
  // await Hive.initFlutter();
  // await HiveStorageService.init();
  // await TokenManager.init();

  // Run the app with the root widget.
  runApp(const App());

  // Use the logger to show the app has started.
  // AppLogger.info('App Started');
}