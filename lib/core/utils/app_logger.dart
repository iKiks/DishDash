import 'dart:developer' as developer;

/// Lightweight app logger for non-UI layers.
///
/// Uses `dart:developer` so it works in pure Dart code without `print()`.
class AppLogger {
  AppLogger._();

  static const bool enabled = bool.fromEnvironment(
    'DISHDASH_LOGS',
    defaultValue: true,
  );

  static void d(
    String message, {
    String name = 'DishDash',
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!enabled) return;
    developer.log(
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
      level: 500,
    );
  }

  static void w(
    String message, {
    String name = 'DishDash',
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!enabled) return;
    developer.log(
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
      level: 900,
    );
  }

  static void e(
    String message, {
    String name = 'DishDash',
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!enabled) return;
    developer.log(
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }
}
