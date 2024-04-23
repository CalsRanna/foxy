import 'package:foxy/service/service.dart';

class CreatureTemplateService {
  Future<List<CreatureTemplate>> search({
    required int page,
    int pageSize = 50,
  }) async {
    final sql =
        'SELECT ct.entry,ct.name,ct.subname,ct.minlevel,ct.maxlevel,ctl.Name,ctl.Title FROM creature_template AS ct LEFT JOIN creature_template_locale AS ctl ON ct.entry = ctl.entry AND ctl.locale = "zhCN" limit $pageSize offset ${(page - 1) * pageSize}';
    final result = await pool.execute(sql);
    return result.rows.map((row) {
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
    }).toList();
  }

  Future<int> count() async {
    const sql = 'select count(*) from creature_template';
    var result = await pool.execute(sql);
    return result.rows.first.typedColAt<int>(0) ?? 0;
  }
}

class CreatureTemplate {
  int entry = 0;
  String name = '';
  String subName = '';
  int minLevel = 0;
  int maxLevel = 0;
}
