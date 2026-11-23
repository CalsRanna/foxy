import 'package:foxy/infrastructure/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

class Migration202611230000 implements Migration {
  @override
  String get name => 'migration_202611230000';

  @override
  Future<void> migrate(Laconic laconic) async {
    final columnCount = await laconic
        .table('information_schema.columns')
        .where('table_schema', 'foxy')
        .where('table_name', 'activity_log')
        .where('column_name', 'details')
        .count();
    if (columnCount != 0) return;
    await laconic.statement(
      'alter table foxy.activity_log add column details longtext null',
    );
  }
}
