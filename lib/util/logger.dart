import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  level: kReleaseMode ? Level.error : Level.debug,
  printer: PlainPrinter(),
);

class PlainPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final level = event.level.name.toUpperCase();
    final time = event.time.toString().substring(0, 19);
    return ['[$level][$time] ${event.message}'];
  }
}
