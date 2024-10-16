import 'package:foxy/model/game_object_template.dart';
import 'package:foxy/service/service.dart';
import 'package:mysql_client/mysql_client.dart';

class GameObjectTemplateService with Service {
  Future<int> count() async {
    const clause = [
      'SELECT count(*)',
      'FROM gameobject_template',
    ];
    final sql = clause.join(' ');
    var result = await execute(sql);
    return result.rows.first.typedColAt<int>(0) ?? 0;
  }

  Future<List<GameObjectTemplate>> search({
    int page = 1,
    int pageSize = 50,
  }) async {
    const fields = [
      'gt.entry',
      'gt.name',
      'gt.type',
      'gt.size',
      'gtl.name',
    ];
    final clauses = [
      'SELECT ${fields.join(', ')}',
      'FROM gameobject_template AS gt',
      'LEFT JOIN gameobject_template_locale AS gtl',
      'ON gt.entry = gtl.entry AND gtl.locale = "zhCN"',
      'LIMIT $pageSize',
      'OFFSET ${(page - 1) * pageSize}',
    ];
    final sql = clauses.join(' ');
    final result = await execute(sql);
    return result.rows.map(_getGameObjectTemplate).toList();
  }

  GameObjectTemplate _getGameObjectTemplate(ResultSetRow row) {
    final entry = row.typedColAt<int>(0) ?? 0;
    final rawName = row.typedColAt<String>(1) ?? '';
    final type = row.typedColAt<int>(2) ?? 0;
    final size = row.typedColAt<double>(3) ?? 0;
    final localeName = row.typedColAt<String>(4) ?? '';
    final name = localeName.isNotEmpty ? localeName : rawName;
    return GameObjectTemplate()
      ..entry = entry
      ..name = name
      ..type = type
      ..size = size;
  }
}
