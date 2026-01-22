import 'dart:developer' as developer;

/// Lightweight app logger for non-UI layers.
///
/// Uses `dart:developer` so it works in pure Dart code without `print()`.
///
/// Enable/disable logs via compile-time env:
/// - `--dart-define=DISHDASH_LOGS=true|false`
class AppLogger {
  AppLogger._();

  // Log levels align with common conventions used by logging frameworks.
  // Values are compatible with `dart:developer` log level filtering.
  static const int verboseLevel = 400;
  static const int debugLevel = 500;
  static const int infoLevel = 800;
  static const int warningLevel = 900;
  static const int errorLevel = 1000;

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
      level: debugLevel,
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
      level: warningLevel,
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
      level: errorLevel,
    );
  }
}
