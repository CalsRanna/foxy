// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_offer_reward_repository.dart';

mixin _QuestOfferRewardRepositoryMixin on RepositoryMixin {
  Future<void> destroyQuestOfferReward(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('quest_offer_reward'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('quest_offer_reward record not found');
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
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(questOfferReward);
    final json = prepareWriteJson(questOfferReward.toJson());
    try {
      await laconic.table('quest_offer_reward').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in quest_offer_reward');
      }
      rethrow;
    }
  }

  Future<void> updateQuestOfferReward(
    int originalKey,
    QuestOfferRewardEntity questOfferReward,
  ) async {
    await _beforeUpdate(originalKey, questOfferReward);
    final json = prepareWriteJson(questOfferReward.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('quest_offer_reward'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in quest_offer_reward');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('quest_offer_reward record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(QuestOfferRewardEntity questOfferReward) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    QuestOfferRewardEntity questOfferReward,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
