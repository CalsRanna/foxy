// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_addon_repository.dart';

mixin _QuestTemplateAddonRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestTemplateAddon(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('quest_template_addon'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<QuestTemplateAddonEntity?> getQuestTemplateAddon(int key) async {
    final results = await _whereKey(
      laconic.table('quest_template_addon'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return QuestTemplateAddonEntity.fromJson(results.first.toMap());
  }

  Future<void> storeQuestTemplateAddon(
    QuestTemplateAddonEntity questTemplateAddon,
  ) async {
    if (questTemplateAddon.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(questTemplateAddon);
    final json = _prepareWriteJson(questTemplateAddon.toJson());
    try {
      await laconic.table('quest_template_addon').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateQuestTemplateAddon(
    int originalKey,
    QuestTemplateAddonEntity questTemplateAddon,
  ) async {
    await _beforeUpdate(originalKey, questTemplateAddon);
    final json = _prepareWriteJson(questTemplateAddon.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('quest_template_addon'),
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
    QuestTemplateAddonEntity questTemplateAddon,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    QuestTemplateAddonEntity questTemplateAddon,
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
