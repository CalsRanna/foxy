// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_request_items_locale_repository.dart';

mixin _QuestRequestItemsLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestRequestItemsLocale(
    QuestRequestItemsLocaleKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('quest_request_items_locale'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'quest_request_items_locale record not found',
      );
    }
  }

  Future<QuestRequestItemsLocaleEntity?> getQuestRequestItemsLocale(
    QuestRequestItemsLocaleKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('quest_request_items_locale'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return QuestRequestItemsLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeQuestRequestItemsLocale(
    QuestRequestItemsLocaleEntity questRequestItemsLocale,
  ) async {
    await _beforeStore(questRequestItemsLocale);
    final json = prepareWriteJson(questRequestItemsLocale.toJson());
    try {
      await laconic.table('quest_request_items_locale').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = questRequestItemsLocale.copyWith(
        id: await nextMaxPlusOne('quest_request_items_locale', '`ID`'),
      );
      try {
        await laconic.table('quest_request_items_locale').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in quest_request_items_locale',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateQuestRequestItemsLocale(
    QuestRequestItemsLocaleKey originalKey,
    QuestRequestItemsLocaleEntity questRequestItemsLocale,
  ) async {
    await _beforeUpdate(originalKey, questRequestItemsLocale);
    final json = prepareWriteJson(questRequestItemsLocale.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('quest_request_items_locale'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in quest_request_items_locale',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'quest_request_items_locale record not found',
      );
    }
  }

  Future<void> _beforeDestroy(QuestRequestItemsLocaleKey key) async {}

  Future<void> _beforeStore(
    QuestRequestItemsLocaleEntity questRequestItemsLocale,
  ) async {}

  Future<void> _beforeUpdate(
    QuestRequestItemsLocaleKey originalKey,
    QuestRequestItemsLocaleEntity questRequestItemsLocale,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, QuestRequestItemsLocaleKey key) {
    var query = builder;
    query = query.where('`ID`', key.id);
    query = query.where('`locale`', key.locale);
    return query;
  }
}
