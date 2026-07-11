import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/entity/quest_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestTemplateRepository with RepositoryMixin {
  static const _table = 'quest_template';

  Future<List<BriefQuestTemplateEntity>> getBriefQuestTemplates({
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
    return results
        .map((e) => BriefQuestTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestTemplateEntity>> getQuestTemplates() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => QuestTemplateEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countQuestTemplates({QuestTemplateFilterEntity? filter}) async {
    final needsLocaleJoin = filter != null && filter.title.isNotEmpty;
    if (!needsLocaleJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.id.isNotEmpty) {
        var idValue = int.tryParse(filter.id) ?? 0;
        builder = builder.where('ID', idValue);
      }
      return builder.count();
    }
    var builder = laconic.table('$_table AS qt');
    builder = builder.leftJoin(
      'quest_template_locale AS qtl',
      (join) => join.on('qt.ID', 'qtl.ID').on('qtl.locale', '"zhCN"'),
    );
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestTemplateEntity?> getQuestTemplate(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return QuestTemplateEntity.fromJson(results.first.toMap());
  }

  Future<QuestTemplateEntity> createQuestTemplate() async {
    return const QuestTemplateEntity();
  }

  Future<int> storeQuestTemplate(QuestTemplateEntity template) async {
    var json = template.toJson();
    var newId = await _getNextId();
    json['ID'] = newId;
    await laconic.table(_table).insert([json]);
    return newId;
  }

  Future<void> updateQuestTemplate(QuestTemplateEntity template) async {
    var json = template.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', template.id).update(json);
  }

  Future<void> destroyQuestTemplate(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyQuestTemplate(int id) async {
    var template = await getQuestTemplate(id);
    if (template == null) return;
    var json = template.toJson();
    var newId = await _getNextId();
    json['ID'] = newId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveQuestTemplate(QuestTemplateEntity template) async {
    if (template.id == 0) {
      await storeQuestTemplate(template);
      return;
    }
    var existing = await getQuestTemplate(template.id);
    if (existing != null) {
      await updateQuestTemplate(template);
    } else {
      await laconic.table(_table).insert([template.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    QuestTemplateFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      var idValue = int.tryParse(filter.id) ?? 0;
      builder = builder.where('qt.ID', idValue);
    }
    if (filter.title.isNotEmpty) {
      builder = builder.whereAny(
        ['qt.LogTitle', 'qtl.Title'],
        '%${filter.title}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
