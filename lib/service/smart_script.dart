import 'package:foxy/model/smart_script.dart';
import 'package:foxy/service/service.dart';
import 'package:mysql_client/mysql_client.dart';

class SmartScriptService with Service {
  Future<int> count() async {
    const clause = [
      'SELECT count(*)',
      'FROM smart_scripts',
    ];
    final sql = clause.join(' ');
    var result = await execute(sql);
    return result.rows.first.typedColAt<int>(0) ?? 0;
  }

  Future<List<SmartScript>> search({
    int page = 1,
    int pageSize = 50,
  }) async {
    const fields = [
      'ss.entryorguid',
      'ss.action_type',
      'ss.comment',
      'ss.event_type',
      'ss.id',
      'ss.link',
      'ss.source_type',
      'ss.target_type',
    ];
    final clauses = [
      'SELECT ${fields.join(', ')}',
      'FROM smart_scripts AS ss',
      'LIMIT $pageSize',
      'OFFSET ${(page - 1) * pageSize}',
    ];
    final sql = clauses.join(' ');
    final result = await execute(sql);
    return result.rows.map(_getSmartScript).toList();
  }

  SmartScript _getSmartScript(ResultSetRow row) {
    final entryOrGuid = row.typedColAt<int>(0) ?? 0;
    final actionType = row.typedColAt<int>(1) ?? 0;
    final comment = row.typedColAt<String>(2) ?? '';
    final eventType = row.typedColAt<int>(3) ?? 0;
    final id = row.typedColAt<int>(4) ?? 0;
    final link = row.typedColAt<int>(5) ?? 0;
    final sourceType = row.typedColAt<int>(6) ?? 0;
    final targetType = row.typedColAt<int>(7) ?? 0;
    return SmartScript()
      ..entryOrGuid = entryOrGuid
      ..actionType = actionType
      ..comment = comment
      ..eventType = eventType
      ..id = id
      ..link = link
      ..sourceType = sourceType
      ..targetType = targetType;
  }
}
