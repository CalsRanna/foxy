import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

class Database {
  static final instance = Database._();
  Laconic? _laconic;
  MysqlConfig? _config;

  Database._();

  MysqlConfig? get config => _config;

  Laconic get laconic {
    if (_laconic == null) {
      throw DatabaseNotConnectedException(
        'database not connected; call Database.instance.connect() first',
      );
    }
    return _laconic!;
  }

  Future<void> close() async {
    await _laconic?.close();
    _laconic = null;
    _config = null;
  }

  Future<void> connect(
    MysqlConfig config, {
    void Function(LaconicQuery)? onQuery,
  }) async {
    await _laconic?.close();
    _laconic = Laconic(MysqlDriver(config), listen: onQuery);
    _config = config;
  }
}
