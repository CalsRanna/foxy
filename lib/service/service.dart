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
  static Future<void> ensureInitialized({
    String host = '127.0.0.1',
    int port = 3306,
    String username = 'root',
    String password = 'root',
    String database = 'world',
  }) async {
    connection = await MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: username,
      password: password,
      databaseName: database, // optional
    );
  }
}
