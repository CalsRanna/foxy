import 'package:logger/logger.dart';

class LoggerUtil {
  static final instance = LoggerUtil._();

  final _logger = Logger(printer: _PlainPrinter());

  LoggerUtil._();

  void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.w(message, time: time, error: error, stackTrace: stackTrace);
  }
}

class _PlainPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final level = event.level.name.toUpperCase();
    final time = event.time.toString().substring(0, 19);
    var message = '[$level][$time] ${event.message}';
    if (event.stackTrace == null) return [message];
    message += '\n${event.stackTrace}';
    return [message];
  }
}

final logger = LoggerUtil.instance;
