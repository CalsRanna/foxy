// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_request_items_repository.dart';

mixin _QuestRequestItemsRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestRequestItems(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('quest_request_items'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<QuestRequestItemsEntity?> getQuestRequestItems(int key) async {
    final results = await _whereKey(
      laconic.table('quest_request_items'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return QuestRequestItemsEntity.fromJson(results.first.toMap());
  }

  Future<void> storeQuestRequestItems(
    QuestRequestItemsEntity questRequestItems,
  ) async {
    if (questRequestItems.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(questRequestItems);
    final json = _prepareWriteJson(questRequestItems.toJson());
    try {
      await laconic.table('quest_request_items').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateQuestRequestItems(
    int originalKey,
    QuestRequestItemsEntity questRequestItems,
  ) async {
    await _beforeUpdate(originalKey, questRequestItems);
    final json = _prepareWriteJson(questRequestItems.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('quest_request_items'),
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

  Future<void> _beforeStore(QuestRequestItemsEntity questRequestItems) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    QuestRequestItemsEntity questRequestItems,
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
