// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_request_items_locale_repository.dart';

mixin _QuestRequestItemsLocaleRepositoryMixin on RepositoryMixin {
  String get _table => 'quest_request_items_locale';

  Future<void> destroyQuestRequestItemsLocale(
    QuestRequestItemsLocaleKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'quest_request_items_locale record not found',
      );
    }
  }

  Future<QuestRequestItemsLocaleEntity?> getQuestRequestItemsLocale(
    QuestRequestItemsLocaleKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return QuestRequestItemsLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeQuestRequestItemsLocale(
    QuestRequestItemsLocaleEntity questRequestItemsLocale,
  ) async {
    await _beforeStore(questRequestItemsLocale);
    final json = prepareWriteJson(questRequestItemsLocale.toJson());
    try {
      await trackActivityWrite(
        _table,
        afterKey: activityKey(
          QuestRequestItemsLocaleKey.fromEntity(questRequestItemsLocale),
        ),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = questRequestItemsLocale.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await trackActivityWrite(
          _table,
          afterKey: activityKey(QuestRequestItemsLocaleKey.fromEntity(retried)),
          write: () => laconic.table(_table).insert([
            prepareWriteJson(retried.toJson()),
          ]),
        );
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
    final values = questRequestItemsLocale.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(
          QuestRequestItemsLocaleKey.fromEntity(questRequestItemsLocale),
        ),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
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

  Map<String, Object?> activityKey(QuestRequestItemsLocaleKey key) => {
    'ID': key.id,
    'locale': key.locale,
  };

  QueryBuilder _whereKey(QueryBuilder builder, QuestRequestItemsLocaleKey key) {
    var query = builder;
    query = query.where('`ID`', key.id);
    query = query.where('`locale`', key.locale);
    return query;
  }
}
