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
    final entry = row.typedColAt<int>(0) ?? 0;
    final rawName = row.typedColAt<String>(1) ?? '';
    final rawSubName = row.typedColAt<String>(2) ?? '';
    final minLevel = row.typedColAt<int>(3) ?? 0;
    final maxLevel = row.typedColAt<int>(4) ?? 0;
    final localeName = row.typedColAt<String>(5) ?? '';
    final localeSubName = row.typedColAt<String>(6) ?? '';
    final name = localeName.isNotEmpty ? localeName : rawName;
    final subName = localeSubName.isNotEmpty ? localeSubName : rawSubName;
    return CreatureTemplate()
      ..entry = entry
      ..name = name
      ..subName = subName
      ..minLevel = minLevel
      ..maxLevel = maxLevel;
  }

  Future<int> count() async {
    const clause = [
      'SELECT count(*)',
      'FROM creature_template',
    ];
    final sql = clause.join(' ');
    var result = await execute(sql);
    return result.rows.first.typedColAt<int>(0) ?? 0;
  }
}
