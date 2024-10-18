import 'package:isar/isar.dart';

part 'setting.g.dart';

@collection
@Name('settings')
class Setting {
  Id id = Isar.autoIncrement;
  String host = '127.0.0.1';
  int port = 3306;
  String username = 'root';
  String password = 'root';
  String database = 'world';
  @Name('dbc_path')
  String dbcPath = '';
  @Name('mpq_path')
  String mpqPath = '';
  @Name('mpq_name')
  String mpqName = '';

  Setting copyWith({
    String? host,
    int? port,
    String? username,
    String? password,
    String? database,
    String? dbcPath,
    String? mpqPath,
    String? mpqName,
  }) {
    return Setting()
      ..host = host ?? this.host
      ..port = port ?? this.port
      ..username = username ?? this.username
      ..password = password ?? this.password
      ..database = database ?? this.database
      ..dbcPath = dbcPath ?? this.dbcPath
      ..mpqPath = mpqPath ?? this.mpqPath
      ..mpqName = mpqName ?? this.mpqName;
  }
}
