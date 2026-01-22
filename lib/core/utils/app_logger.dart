import 'dart:developer' as developer;

typedef AppLogSink = void Function(AppLogRecord record);

class AppLogRecord {
  AppLogRecord({
    required this.message,
    required this.name,
    required this.level,
    this.error,
    this.stackTrace,
    DateTime? time,
  }) : time = time ?? DateTime.now();

  final String message;
  final String name;
  final int level;
  final Object? error;
  final StackTrace? stackTrace;
  final DateTime time;
}

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

  static AppLogSink _sink = _developerSink;

  static void setSink(AppLogSink sink) {
    _sink = sink;
  }

  static void resetSink() {
    _sink = _developerSink;
  }

  static void _developerSink(AppLogRecord record) {
    developer.log(
      record.message,
      name: record.name,
      error: record.error,
      stackTrace: record.stackTrace,
      level: record.level,
      time: record.time,
    );
  }

  static void _log(
    int level,
    String message, {
    required String name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!enabled) return;

    _sink(
      AppLogRecord(
        message: message,
        name: name,
        level: level,
        error: error,
        stackTrace: stackTrace,
      ),
    );
  }

  static void v(
    String message, {
    String name = 'DishDash',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      verboseLevel,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void d(
    String message, {
    String name = 'DishDash',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      debugLevel,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void i(
    String message, {
    String name = 'DishDash',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      infoLevel,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void w(
    String message, {
    String name = 'DishDash',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      warningLevel,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void e(
    String message, {
    String name = 'DishDash',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      errorLevel,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
