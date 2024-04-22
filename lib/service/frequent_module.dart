import 'package:foxy/model/frequent_module.dart';
import 'package:foxy/service/service.dart';
import 'package:mysql_client/mysql_client.dart';

class FrequentModuleService extends Service {
  final pool = MySQLConnectionPool(
    host: '127.0.0.1',
    port: 3306,
    userName: 'root',
    password: 'root',
    maxConnections: 10,
    databaseName: 'world',
  );
  Future<List<FrequentModule>> getFrequentModules() async {
    var results = await pool.execute('select * from foxy.frequent_modules');
    print(results.isEmpty);
    if (results.isEmpty) {
      final sql =
          'insert into foxy.frequent_modules (category, description, name, updated_at) values (?, ?, ?, ?)';
      var statement = await pool.prepare(sql);
      for (var i = 0; i < 9; i++) {
        await statement.execute(['database', '生物', '生物$i', DateTime.now()]);
      }
      results = await pool.execute('select * from foxy.frequent_modules');
    }
    List<FrequentModule> modules = [];
    for (var result in results.rows) {
      final json = result.assoc();
      print(json);
      modules.add(FrequentModule.fromJson(json));
    }
    print(modules.length);
    return modules;
  }

  Future<void> init() async {
    var sql = 'create table if not exists foxy.frequent_modules';
    var fields = [
      'id int auto_increment primary key',
      'category varchar(255) not null',
      'description varchar(255) not null',
      'name varchar(255) not null',
      'updated_at datetime not null',
    ];
    sql = '$sql (${fields.join(',')})';
    await pool.execute(sql);
    print(sql);
  }
}
