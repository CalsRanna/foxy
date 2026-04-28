import 'package:foxy/model/quest_template.dart';
import 'package:foxy/model/quest_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestTemplateRepository with RepositoryMixin {
  final String _table = 'quest_template';

  Future<void> copyQuestTemplate(int id) async {
    var template = await getQuestTemplate(id);
    var json = template.toJson();
    var newId = await _getNextId();
    json['ID'] = newId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  Future<int> countQuestTemplates({QuestTemplateFilterEntity? filter}) async {
    var builder = laconic.table('$_table AS qt');
    builder.select(['qt.ID']);
    builder = builder.leftJoin(
      'quest_template_locale AS qtl',
      (join) => join.on('qt.ID', 'qtl.ID').on('qtl.locale', '"zhCN"'),
    );
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<void> destroyQuestTemplate(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefQuestTemplate>> getBriefQuestTemplates({
    int page = 1,
    QuestTemplateFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS qt');
    const fields = [
      'qt.ID',
      'qt.LogTitle',
      'qtl.Title',
      'qt.QuestDescription',
      'qtl.Details',
      'qt.QuestType',
      'qt.QuestLevel',
      'qt.MinLevel',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'quest_template_locale AS qtl',
      (join) => join.on('qt.ID', 'qtl.ID').on('qtl.locale', '"zhCN"'),
    );
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefQuestTemplate.fromJson(e.toMap())).toList();
  }

  Future<QuestTemplate> getQuestTemplate(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return QuestTemplate.fromJson(result.toMap());
  }

  Future<void> storeQuestTemplate(QuestTemplate model) async {
    var json = model.toJson();
    var newId = await _getNextId();
    json['ID'] = newId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateQuestTemplate(QuestTemplate model) async {
    var json = model.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', model.id).update(json);
  }

  dynamic _applyFilter(dynamic builder, QuestTemplateFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      var idValue = int.tryParse(filter.id) ?? 0;
      builder = builder.where('qt.ID', idValue);
    }
    if (filter.title.isNotEmpty) {
      builder = builder.whereAny(
        ['qt.LogTitle', 'qtl.Title'],
        '%${filter.title}%',
        operator: 'like',
      );
    }
    return builder;
  }
}
