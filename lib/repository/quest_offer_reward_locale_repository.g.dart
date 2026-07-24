// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_offer_reward_locale_repository.dart';

mixin _QuestOfferRewardLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestOfferRewardLocale(
    QuestOfferRewardLocaleKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('quest_offer_reward_locale'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<QuestOfferRewardLocaleEntity?> getQuestOfferRewardLocale(
    QuestOfferRewardLocaleKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('quest_offer_reward_locale'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return QuestOfferRewardLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeQuestOfferRewardLocale(
    QuestOfferRewardLocaleEntity questOfferRewardLocale,
  ) async {
    await _beforeStore(questOfferRewardLocale);
    final json = _prepareWriteJson(questOfferRewardLocale.toJson());
    try {
      await laconic.table('quest_offer_reward_locale').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateQuestOfferRewardLocale(
    QuestOfferRewardLocaleKey originalKey,
    QuestOfferRewardLocaleEntity questOfferRewardLocale,
  ) async {
    await _beforeUpdate(originalKey, questOfferRewardLocale);
    final json = _prepareWriteJson(questOfferRewardLocale.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('quest_offer_reward_locale'),
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
    QuestOfferRewardLocaleEntity questOfferRewardLocale,
  ) async {}

  Future<void> _beforeUpdate(
    QuestOfferRewardLocaleKey originalKey,
    QuestOfferRewardLocaleEntity questOfferRewardLocale,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, QuestOfferRewardLocaleKey key) {
    var query = builder;
    query = query.where('ID', key.id);
    query = query.where('locale', key.locale);
    return query;
  }
}
