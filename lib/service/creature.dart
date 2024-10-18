import 'package:foxy/model/creature_template.dart';
import 'package:foxy/service/service.dart';
import 'package:mysql_client/mysql_client.dart';

class CreatureTemplateService with Service {
  Future<int> count({int? entry, String? name, String? subName}) async {
    List<String> where = [];
    if (entry != null) {
      where.add('ct.entry = $entry');
    }
    if (name != null && name.isNotEmpty) {
      where.add('(ct.name LIKE "%$name%" OR ctl.Name LIKE "%$name%")');
    }
    if (subName != null && subName.isNotEmpty) {
      where.add(
        '(ct.subname LIKE "%$subName%" OR ctl.Title LIKE "%$subName%")',
      );
    }
    final clause = [
      'SELECT count(*)',
      'FROM creature_template AS ct',
      'LEFT JOIN creature_template_locale AS ctl',
      'ON ct.entry = ctl.entry AND ctl.locale = "zhCN"',
      if (where.isNotEmpty) 'WHERE ${where.join(' AND ')}',
    ];
    final sql = clause.join(' ');
    var result = await execute(sql);
    return result.rows.first.typedColAt<int>(0) ?? 0;
  }

  Future<CreatureTemplate> find(int entry) async {
    final clauses = [
      'SELECT *',
      'FROM creature_template',
      'WHERE entry = $entry',
    ];
    final sql = clauses.join(' ');
    final result = await execute(sql);
    final json = result.rows.first.typedAssoc();
    return CreatureTemplate.fromJson(json);
  }

  Future<List<BriefCreatureTemplate>> search({
    int? entry,
    String? name,
    String? subName,
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
    List<String> where = [];
    if (entry != null) {
      where.add('ct.entry = $entry');
    }
    if (name != null && name.isNotEmpty) {
      where.add('(ct.name LIKE "%$name%" OR ctl.Name LIKE "%$name%")');
    }
    if (subName != null && subName.isNotEmpty) {
      where.add(
        '(ct.subname LIKE "%$subName%" OR ctl.Title LIKE "%$subName%")',
      );
    }
    final clauses = [
      'SELECT ${fields.join(', ')}',
      'FROM creature_template AS ct',
      'LEFT JOIN creature_template_locale AS ctl',
      'ON ct.entry = ctl.entry AND ctl.locale = "zhCN"',
      if (where.isNotEmpty) 'WHERE ${where.join(' AND ')}',
      'LIMIT $pageSize',
      'OFFSET ${(page - 1) * pageSize}',
    ];
    final sql = clauses.join(' ');
    final result = await execute(sql);
    return result.rows.map(_getBriefCreatureTemplate).toList();
  }

  BriefCreatureTemplate _getBriefCreatureTemplate(ResultSetRow row) {
    final json = row.typedAssoc();
    final rawName = json['name'] ?? '';
    final rawSubName = json['subname'] ?? '';
    final localeName = json['Name'] ?? '';
    final localeSubName = json['Title'] ?? '';
    final name = localeName.isNotEmpty ? localeName : rawName;
    final subName = localeSubName.isNotEmpty ? localeSubName : rawSubName;
    json['name'] = name;
    json['subname'] = subName;
    return BriefCreatureTemplate.fromJson(json);
  }
}
