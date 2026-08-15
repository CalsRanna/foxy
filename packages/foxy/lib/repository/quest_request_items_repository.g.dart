// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_request_items_repository.dart';

mixin _QuestRequestItemsRepositoryMixin on RepositoryMixin {
  String get _table => 'quest_request_items';

  Future<void> destroyQuestRequestItems(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('quest_request_items record not found');
    }
  }

  Future<QuestRequestItemsEntity?> getQuestRequestItems(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return QuestRequestItemsEntity.fromJson(results.first.toMap());
  }

  Future<int> storeQuestRequestItems(
    QuestRequestItemsEntity questRequestItems,
  ) async {
    if (questRequestItems.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(questRequestItems);
    final json = prepareWriteJson(questRequestItems.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = questRequestItems.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in quest_request_items');
        }
        rethrow;
      }
    }
    return questRequestItems.id;
  }

  Future<void> updateQuestRequestItems(
    int originalKey,
    QuestRequestItemsEntity questRequestItems,
  ) async {
    await _beforeUpdate(originalKey, questRequestItems);
    final json = prepareWriteJson(questRequestItems.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in quest_request_items');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('quest_request_items record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(QuestRequestItemsEntity questRequestItems) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    QuestRequestItemsEntity questRequestItems,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
