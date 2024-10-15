import 'package:mysql_client/mysql_client.dart';

late MySQLConnection pool;

mixin Service {
  Future<IResultSet> execute(String query) {
    print(query);
    return pool.execute(query);
  }
}

class ServiceInitializer {
  static Future<void> ensureInitialized({
    String host = '43.139.61.244',
    int port = 3306,
    String username = 'root',
    String password = 'mysql_nZ5mHE',
    String database = 'world',
  }) async {
    pool = await MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: username,
      password: password,
      databaseName: database, // optional
    );
    await pool.connect();
  }
}
