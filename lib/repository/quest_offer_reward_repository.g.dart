// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_offer_reward_repository.dart';

mixin _QuestOfferRewardRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestOfferReward(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('quest_offer_reward'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<QuestOfferRewardEntity?> getQuestOfferReward(int key) async {
    final results = await _whereKey(
      laconic.table('quest_offer_reward'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return QuestOfferRewardEntity.fromJson(results.first.toMap());
  }

  Future<void> storeQuestOfferReward(
    QuestOfferRewardEntity questOfferReward,
  ) async {
    if (questOfferReward.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(questOfferReward);
    final json = _prepareWriteJson(questOfferReward.toJson());
    try {
      await laconic.table('quest_offer_reward').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateQuestOfferReward(
    int originalKey,
    QuestOfferRewardEntity questOfferReward,
  ) async {
    await _beforeUpdate(originalKey, questOfferReward);
    final json = _prepareWriteJson(questOfferReward.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('quest_offer_reward'),
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

  Future<void> _beforeStore(QuestOfferRewardEntity questOfferReward) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    QuestOfferRewardEntity questOfferReward,
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
