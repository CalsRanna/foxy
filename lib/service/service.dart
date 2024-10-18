import 'package:foxy/schema/setting.dart';
import 'package:foxy/util/logger.dart';
import 'package:mysql_client/mysql_client.dart';

late MySQLConnection connection;

mixin Service {
  Future<IResultSet> execute(String query) async {
    logger.d(query);
    if (!connection.connected) await connection.connect();
    return connection.execute(query);
  }
}

class ServiceInitializer {
  static Future<void> ensureInitialized(Setting setting) async {
    connection = await MySQLConnection.createConnection(
      host: setting.host,
      port: setting.port,
      userName: setting.username,
      password: setting.password,
      databaseName: setting.database, // optional
    );
  }
}
