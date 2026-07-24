// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_locale_repository.dart';

mixin _QuestTemplateLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestTemplateLocale(QuestTemplateLocaleKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('quest_template_locale'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<QuestTemplateLocaleEntity?> getQuestTemplateLocale(
    QuestTemplateLocaleKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('quest_template_locale'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return QuestTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeQuestTemplateLocale(
    QuestTemplateLocaleEntity questTemplateLocale,
  ) async {
    await _beforeStore(questTemplateLocale);
    final json = _prepareWriteJson(questTemplateLocale.toJson());
    try {
      await laconic.table('quest_template_locale').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateQuestTemplateLocale(
    QuestTemplateLocaleKey originalKey,
    QuestTemplateLocaleEntity questTemplateLocale,
  ) async {
    await _beforeUpdate(originalKey, questTemplateLocale);
    final json = _prepareWriteJson(questTemplateLocale.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('quest_template_locale'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(
    QuestTemplateLocaleEntity questTemplateLocale,
  ) async {}

  Future<void> _beforeUpdate(
    QuestTemplateLocaleKey originalKey,
    QuestTemplateLocaleEntity questTemplateLocale,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, QuestTemplateLocaleKey key) {
    var query = builder;
    query = query.where('ID', key.id);
    query = query.where('locale', key.locale);
    return query;
  }
}
