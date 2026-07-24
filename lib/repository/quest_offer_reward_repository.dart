import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_offer_reward_repository.g.dart';

@FoxyRepository(QuestOfferRewardEntity)
class QuestOfferRewardRepository
    with RepositoryMixin, _QuestOfferRewardRepositoryMixin {
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

  Future<List<QuestOfferRewardEntity>> getQuestOfferRewards() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => QuestOfferRewardEntity.fromJson(row.toMap()))
        .toList();
  }
}
