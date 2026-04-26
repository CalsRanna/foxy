import 'package:foxy/model/quest_template.dart';
import 'package:foxy/model/quest_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestTemplateRepository with RepositoryMixin {
  static const _table = 'quest_template';

  Future<void> copyQuestTemplate(int id) async {
    final original = await getQuestTemplate(id);
    if (original == null) return;
    final next = await _getNextId();
    original.id = next;
    await storeQuestTemplate(original);
  }

  Future<int> _getNextId() async {
    try {
      final result = await laconic
          .table(_table)
          .select(['MAX(ID) as max_id'])
          .first();
      final maxId = result.toMap()['max_id'] as int?;
      return (maxId ?? 0) + 1;
    } catch (e) {
      return 1;
    }
  }

  Future<int> count({QuestTemplateFilterEntity? filter}) async {
    try {
      var builder = laconic.table('${_table} AS qt');
      builder = builder.leftJoin(
        'quest_template_locale AS qtl',
        (join) => join.on('qt.ID', 'qtl.ID').on('qtl.locale', '"zhCN"'),
      );
      builder = _applyFilter(builder, filter);
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  Future<void> destroyQuestTemplate(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefQuestTemplate>> getBriefQuestTemplates({
    int page = 1,
    QuestTemplateFilterEntity? filter,
  }) async {
    try {
      final offset = (page - 1) * kPageSize;
      var builder = laconic.table('${_table} AS qt');
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
      final results = await builder.get();
      return results
          .map((e) => BriefQuestTemplate.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<QuestTemplate?> getQuestTemplate(int id) async {
    try {
      final builder = laconic.table(_table).where('ID', id);
      final result = await builder.first();
      return QuestTemplate.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> storeQuestTemplate(QuestTemplate model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateQuestTemplate(int id, QuestTemplate model) async {
    final json = model.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', id).update(json);
  }

  dynamic _applyFilter(dynamic builder, QuestTemplateFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      final idValue = int.tryParse(filter.id) ?? 0;
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
