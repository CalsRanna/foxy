import 'package:isar/isar.dart';

part 'setting.g.dart';

@collection
@Name('settings')
class Setting {
  Id id = Isar.autoIncrement;
  String host = '127.0.0.1';
  int port = 3306;
  String username = 'root';
  String password = '';
  String database = 'world';
  @Name('dbc_path')
  String dbcPath = '';
  @Name('mpq_path')
  String mpqPath = '';
  @Name('mpq_name')
  String mpqName = '';
}
