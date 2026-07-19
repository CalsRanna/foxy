import 'package:laconic/laconic.dart';
import 'package:mysql_client/exception.dart';

abstract final class MysqlErrorUtil {
  static const duplicateEntryCode = 1062;

  static bool isDuplicateEntry(Object error) {
    if (error is MySQLServerException) {
      return error.errorCode == duplicateEntryCode;
    }
    if (error is LaconicException && error.cause != null) {
      return isDuplicateEntry(error.cause!);
    }
    return false;
  }
}
