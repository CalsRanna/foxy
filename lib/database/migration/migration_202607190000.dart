import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

class Migration202607190000 implements Migration {
  @override
  String get name => 'migration_202607190000';

  @override
  Future<void> migrate(Laconic laconic) async {
    final columnCount = await laconic
        .table('information_schema.COLUMNS')
        .where('TABLE_SCHEMA', 'foxy')
        .where('TABLE_NAME', 'activity_log')
        .where('COLUMN_NAME', 'entity_id')
        .count();
    if (columnCount == 0) return;
    await laconic.statement('''
      UPDATE foxy.activity_log
      SET entity_name = CONCAT(module, ' #', entity_id)
      WHERE entity_name IS NULL OR entity_name = ''
    ''');
    await laconic.statement(
      'ALTER TABLE foxy.activity_log DROP COLUMN entity_id',
    );
  }
}
