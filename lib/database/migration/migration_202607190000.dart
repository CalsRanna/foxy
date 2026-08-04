import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

class Migration202607190000 implements Migration {
  @override
  String get name => 'migration_202607190000';

  @override
  Future<void> migrate(Laconic laconic) async {
    final columnCount = await laconic
        .table('information_schema.columns')
        .where('table_schema', 'foxy')
        .where('table_name', 'activity_log')
        .where('column_name', 'entity_id')
        .count();
    if (columnCount == 0) return;
    await laconic.statement('''
      update foxy.activity_log
      set entity_name = concat(module, ' #', entity_id)
      where entity_name is null or entity_name = ''
    ''');
    await laconic.statement(
      'alter table foxy.activity_log drop column entity_id',
    );
  }
}
