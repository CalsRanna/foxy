import 'package:foxy/model/quest_template.dart';
import 'package:foxy/service/service.dart';
import 'package:mysql_client/mysql_client.dart';

class QuestTemplateService with Service {
  Future<int> count() async {
    const clause = [
      'SELECT count(*)',
      'FROM quest_template',
    ];
    final sql = clause.join(' ');
    var result = await execute(sql);
    return result.rows.first.typedColAt<int>(0) ?? 0;
  }

  Future<List<QuestTemplate>> search({
    int page = 1,
    int pageSize = 50,
  }) async {
    const fields = [
      'qt.ID',
      'qt.QuestLevel',
      'qt.LogDescription',
      'qt.LogTitle',
      'qt.MinLevel',
      'qt.QuestType',
      'qtl.Details',
      'qtl.Title',
    ];
    final clauses = [
      'SELECT ${fields.join(', ')}',
      'FROM quest_template AS qt',
      'LEFT JOIN quest_template_locale AS qtl',
      'ON qt.ID = qtl.ID AND qtl.locale = "zhCN"',
      'LIMIT $pageSize',
      'OFFSET ${(page - 1) * pageSize}',
    ];
    final sql = clauses.join(' ');
    final result = await execute(sql);
    return result.rows.map(_getQuestTemplate).toList();
  }

  QuestTemplate _getQuestTemplate(ResultSetRow row) {
    final entry = row.typedColAt<int>(0) ?? 0;
    final level = row.typedColAt<int>(1) ?? 0;
    final logDescription = row.typedColAt<String>(2) ?? '';
    final logTitle = row.typedColAt<String>(3) ?? '';
    final minLevel = row.typedColAt<int>(4) ?? 0;
    final type = row.typedColAt<int>(5) ?? 0;
    final localeDescription = row.typedColAt<String>(6) ?? '';
    final localeTitle = row.typedColAt<String>(7) ?? '';
    final title = localeTitle.isNotEmpty ? localeTitle : logTitle;
    return QuestTemplate()
      ..entry = entry
      ..description = localeDescription
      ..level = level
      ..logDescription = logDescription
      ..logTitle = logTitle
      ..minLevel = minLevel
      ..title = title
      ..type = type;
  }
}
