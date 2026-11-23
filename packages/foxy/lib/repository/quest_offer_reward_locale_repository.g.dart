// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_offer_reward_locale_repository.dart';

mixin _QuestOfferRewardLocaleRepositoryMixin on RepositoryMixin {
  String get _table => 'quest_offer_reward_locale';

  Future<void> destroyQuestOfferRewardLocale(
    QuestOfferRewardLocaleKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'quest_offer_reward_locale record not found',
      );
    }
  }

  Future<QuestOfferRewardLocaleEntity?> getQuestOfferRewardLocale(
    QuestOfferRewardLocaleKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return QuestOfferRewardLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeQuestOfferRewardLocale(
    QuestOfferRewardLocaleEntity questOfferRewardLocale,
  ) async {
    await _beforeStore(questOfferRewardLocale);
    final json = prepareWriteJson(questOfferRewardLocale.toJson());
    try {
      await trackActivityWrite(
        _table,
        afterKey: activityKey(
          QuestOfferRewardLocaleKey.fromEntity(questOfferRewardLocale),
        ),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = questOfferRewardLocale.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await trackActivityWrite(
          _table,
          afterKey: activityKey(QuestOfferRewardLocaleKey.fromEntity(retried)),
          write: () => laconic.table(_table).insert([
            prepareWriteJson(retried.toJson()),
          ]),
        );
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in quest_offer_reward_locale',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateQuestOfferRewardLocale(
    QuestOfferRewardLocaleKey originalKey,
    QuestOfferRewardLocaleEntity questOfferRewardLocale,
  ) async {
    await _beforeUpdate(originalKey, questOfferRewardLocale);
    final values = questOfferRewardLocale.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(
          QuestOfferRewardLocaleKey.fromEntity(questOfferRewardLocale),
        ),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in quest_offer_reward_locale',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'quest_offer_reward_locale record not found',
      );
    }
  }

  Future<void> _beforeDestroy(QuestOfferRewardLocaleKey key) async {}

  Future<void> _beforeStore(
    QuestOfferRewardLocaleEntity questOfferRewardLocale,
  ) async {}

  Future<void> _beforeUpdate(
    QuestOfferRewardLocaleKey originalKey,
    QuestOfferRewardLocaleEntity questOfferRewardLocale,
  ) async {}

  Map<String, Object?> activityKey(QuestOfferRewardLocaleKey key) => {
    'ID': key.id,
    'locale': key.locale,
  };

  QueryBuilder _whereKey(QueryBuilder builder, QuestOfferRewardLocaleKey key) {
    var query = builder;
    query = query.where('`ID`', key.id);
    query = query.where('`locale`', key.locale);
    return query;
  }
}
