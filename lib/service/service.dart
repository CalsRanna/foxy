import 'package:mysql_client/mysql_client.dart';

late MySQLConnectionPool pool;

class Service {}

class ServiceInitializer {
  static Future<void> ensureInitialized({
    String host = '127.0.0.1',
    int port = 3306,
    String username = 'root',
    String password = 'root',
    String database = 'world',
  }) async {
    pool = MySQLConnectionPool(
      host: host,
      port: port,
      userName: username,
      password: password,
      maxConnections: 10,
      databaseName: database,
    );
  }
}
