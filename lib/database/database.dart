import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

class Database {
  static final instance = Database._();
  Database._();

  Laconic? _laconic;

  Future<void> connect(
    MysqlConfig config, {
    void Function(LaconicQuery)? onQuery,
  }) async {
    await _laconic?.close();
    _laconic = Laconic(MysqlDriver(config), listen: onQuery);
  }

  Future<void> close() async {
    await _laconic?.close();
    _laconic = null;
  }

  Laconic get laconic {
    if (_laconic == null) {
      throw Exception('数据库未连接，请先调用 Database.instance.connect()');
    }
    return _laconic!;
  }
}
