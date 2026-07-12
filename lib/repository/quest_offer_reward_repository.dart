import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestOfferRewardRepository with RepositoryMixin {
  static const _table = 'quest_offer_reward';

  Future<List<BriefQuestOfferRewardEntity>> getBriefQuestOfferRewards({
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'Emote1', 'RewardText']);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefQuestOfferRewardEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestOfferRewardEntity>> getQuestOfferRewards() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => QuestOfferRewardEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countQuestOfferRewards() async {
    return laconic.table(_table).count();
  }

  Future<QuestOfferRewardEntity?> getQuestOfferReward(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return QuestOfferRewardEntity.fromJson(results.first.toMap());
  }

  Future<QuestOfferRewardEntity> createQuestOfferReward([int id = 0]) async {
    return QuestOfferRewardEntity(id: id);
  }

  Future<void> storeQuestOfferReward(QuestOfferRewardEntity model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateQuestOfferReward(
    int id,
    QuestOfferRewardEntity model,
  ) async {
    final json = model.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', id).update(json);
  }

  Future<void> destroyQuestOfferReward(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyQuestOfferReward(int id) async {
    var source = await getQuestOfferReward(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveQuestOfferReward(QuestOfferRewardEntity model) async {
    var existing = await getQuestOfferReward(model.id);
    if (existing != null) {
      await updateQuestOfferReward(model.id, model);
    } else {
      await storeQuestOfferReward(model);
    }
  }

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }
}
