import 'package:laconic/laconic.dart';

abstract final class MysqlErrorUtil {
  static const duplicateEntryCode = 1062;

  // laconic 4.x embeds the driver error text (e.g. `MysqlServerException
  // [1062]: ...`) directly in the LaconicException message instead of a
  // nested cause chain, so the code can appear anywhere in the message.
  static final _serverErrorCodePattern = RegExp(
    r'MysqlServerException \[(\d+)\]',
  );

  static bool isDuplicateEntry(Object error) {
    if (error is! LaconicException) return false;
    final match = _serverErrorCodePattern.firstMatch(error.message);
    return match != null && int.parse(match.group(1)!) == duplicateEntryCode;
  }
}
