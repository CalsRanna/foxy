import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestOfferRewardRepository with RepositoryMixin {
  static const _table = 'quest_offer_reward';

  Future<int> copyQuestOfferReward(int key) async {
    final source = await getQuestOfferReward(key);
    if (source == null) {
      throw StateError('原任务奖励数据不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeQuestOfferReward(copied);
    return copied.id;
  }

  Future<int> countQuestOfferRewards() {
    return laconic.table(_table).count();
  }

  Future<QuestOfferRewardEntity> createQuestOfferReward([int? id]) async {
    return QuestOfferRewardEntity(id: id ?? await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyQuestOfferReward(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原任务奖励数据不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefQuestOfferRewardEntity>> getBriefQuestOfferRewards({
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select(['ID', 'Emote1', 'RewardText'])
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefQuestOfferRewardEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<QuestOfferRewardEntity?> getQuestOfferReward(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return QuestOfferRewardEntity.fromJson(results.first.toMap());
  }

  Future<List<QuestOfferRewardEntity>> getQuestOfferRewards() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => QuestOfferRewardEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeQuestOfferReward(QuestOfferRewardEntity model) async {
    if (model.id <= 0) {
      throw StateError('任务奖励数据 ID 必须显式指定');
    }
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('任务奖励数据 ${model.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateQuestOfferReward(
    int originalKey,
    QuestOfferRewardEntity model,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(model.toJson());
      if (matchedRows == 0) {
        throw StateError('原任务奖励数据不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的任务奖励数据 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
