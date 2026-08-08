// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_offer_reward_locale_repository.dart';

mixin _QuestOfferRewardLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestOfferRewardLocale(
    QuestOfferRewardLocaleKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
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
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = questOfferRewardLocale.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
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
    final json = prepareWriteJson(questOfferRewardLocale.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
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

  QueryBuilder _whereKey(QueryBuilder builder, QuestOfferRewardLocaleKey key) {
    var query = builder;
    query = query.where('`ID`', key.id);
    query = query.where('`locale`', key.locale);
    return query;
  }
}

const _table = 'quest_offer_reward_locale';
