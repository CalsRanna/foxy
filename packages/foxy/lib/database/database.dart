import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

class Database {
  static final instance = Database._();
  Laconic? _laconic;

  Database._();

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
  }

  Future<void> connect(
    MysqlConfig config, {
    void Function(LaconicQuery)? onQuery,
  }) async {
    await _laconic?.close();
    _laconic = Laconic(MysqlDriver(config), listen: onQuery);
  }
}
