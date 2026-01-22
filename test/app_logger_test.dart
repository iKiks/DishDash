import 'package:dishdash/core/utils/app_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final captured = <AppLogRecord>[];

  setUp(() {
    captured.clear();
    AppLogger.setEnabledOverride(true);
    AppLogger.setSink(captured.add);
  });

  tearDown(() {
    AppLogger.resetSink();
    AppLogger.setEnabledOverride(null);
  });

  test('d logs at debug level', () {
    AppLogger.d('hello', name: 'Test');

    expect(captured, hasLength(1));
    final record = captured.single;
    expect(record.level, AppLogger.debugLevel);
    expect(record.name, 'Test');
    expect(record.message, 'hello');
  });

  test('v/i/w use expected log levels', () {
    AppLogger.v('verbose', name: 'Test');
    AppLogger.i('info', name: 'Test');
    AppLogger.w('warn', name: 'Test');

    expect(captured, hasLength(3));
    expect(captured[0].level, AppLogger.verboseLevel);
    expect(captured[1].level, AppLogger.infoLevel);
    expect(captured[2].level, AppLogger.warningLevel);
  });

  test('e forwards error and stackTrace', () {
    final error = StateError('boom');
    final stackTrace = StackTrace.current;

    AppLogger.e(
      'failed',
      name: 'Test',
      error: error,
      stackTrace: stackTrace,
    );

    expect(captured, hasLength(1));
    final record = captured.single;
    expect(record.level, AppLogger.errorLevel);
    expect(record.error, same(error));
    expect(record.stackTrace, same(stackTrace));
  });

  test('disabled suppresses logs', () {
    AppLogger.setEnabledOverride(false);

    AppLogger.d('nope');
    AppLogger.w('nope');
    AppLogger.e('nope');

    expect(captured, isEmpty);
  });
}
