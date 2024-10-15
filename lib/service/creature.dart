import 'package:foxy/model/creature_template.dart';
import 'package:foxy/service/service.dart';
import 'package:mysql_client/mysql_client.dart';

class CreatureTemplateService with Service {
  Future<List<CreatureTemplate>> search({
    int page = 1,
    int pageSize = 50,
  }) async {
    const fields = [
      'ct.entry',
      'ct.name',
      'ct.subname',
      'ct.minlevel',
      'ct.maxlevel',
      'ctl.Name',
      'ctl.Title'
    ];
    final clauses = [
      'SELECT ${fields.join(', ')}',
      'FROM creature_template AS ct',
      'LEFT JOIN creature_template_locale AS ctl',
      'ON ct.entry = ctl.entry AND ctl.locale = "zhCN"',
      'LIMIT $pageSize',
      'OFFSET ${(page - 1) * pageSize}',
    ];
    final sql = clauses.join(' ');
    final result = await execute(sql);
    return result.rows.map(_getCreatureTemplate).toList();
  }

  CreatureTemplate _getCreatureTemplate(ResultSetRow row) {
    final rawName = row.colAt(1) ?? '';
    final localeName = row.colAt(5) ?? '';
    final name = localeName.isNotEmpty ? localeName : rawName;
    final rawSubName = row.colAt(2) ?? '';
    final localeSubName = row.colAt(6) ?? '';
    final subName = localeSubName.isNotEmpty ? localeSubName : rawSubName;
    return CreatureTemplate()
      ..entry = row.typedColAt<int>(0) ?? 0
      ..name = name
      ..subName = subName
      ..minLevel = row.typedColAt<int>(3) ?? 0
      ..maxLevel = row.typedColAt<int>(4) ?? 0;
  }

  Future<int> count() async {
    const clause = [
      'SELECT count(*)',
      'FROM creature_template AS ct',
    ];
    final sql = clause.join(' ');
    var result = await execute(sql);
    return result.rows.first.typedColAt<int>(0) ?? 0;
  }
}
