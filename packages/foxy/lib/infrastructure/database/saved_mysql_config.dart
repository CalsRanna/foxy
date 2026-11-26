import 'package:laconic_mysql/laconic_mysql.dart';

abstract final class SavedMysqlConfig {
  static MysqlConfig fromMap(Map<String, Object?> config) {
    final port = config['port'];
    final useSsl = config['use_ssl'] == true;
    return MysqlConfig(
      host: config['host']?.toString() ?? '127.0.0.1',
      port: port is int ? port : int.tryParse(port?.toString() ?? '') ?? 3306,
      database: config['database']?.toString() ?? 'acore_world',
      username: config['username']?.toString() ?? 'acore',
      password: config['password']?.toString() ?? 'acore',
      useSsl: useSsl,
      // Non-TLS caching_sha2_password authentication needs the server key.
      allowPublicKeyRetrieval: !useSsl,
    );
  }
}
