import 'package:laconic/laconic.dart';

abstract final class MysqlErrorUtil {
  static const duplicateEntryCode = 1062;
  static final _serverErrorCodePattern = RegExp(
    r'^MysqlServerException \[(\d+)\]:',
  );

  static bool isDuplicateEntry(Object error) {
    for (Object? current = error; current is LaconicException;) {
      final match = _serverErrorCodePattern.firstMatch(current.message);
      if (match != null) {
        return int.parse(match.group(1)!) == duplicateEntryCode;
      }
      current = current.cause;
    }
    return false;
  }
}
