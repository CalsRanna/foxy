import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/entity/quest_faction_reward_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestFactionRewardRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_quest_faction_reward';

  Future<void> copyQuestFactionReward(int id) async {
    throw StateError('任务声望固定记录不能复制');
  }

  Future<int> countQuestFactionRewards({
    QuestFactionRewardFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestFactionRewardEntity> createQuestFactionReward() async {
    return QuestFactionRewardEntity(id: await _getAvailableId());
  }

  Future<void> destroyQuestFactionReward(int id) async {
    throw StateError('任务声望固定记录不能删除');
  }

  Future<List<BriefQuestFactionRewardEntity>> getBriefQuestFactionRewards({
    int page = 1,
    QuestFactionRewardFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'Difficulty0',
      'Difficulty1',
      'Difficulty2',
      'Difficulty3',
      'Difficulty4',
      'Difficulty5',
      'Difficulty6',
      'Difficulty7',
      'Difficulty8',
      'Difficulty9',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefQuestFactionRewardEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<QuestFactionRewardEntity?> getQuestFactionReward(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return QuestFactionRewardEntity.fromJson(results.first.toMap());
  }

  Future<List<QuestFactionRewardEntity>> getQuestFactionRewards() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => QuestFactionRewardEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveQuestFactionReward(
    QuestFactionRewardEntity questFactionReward,
  ) async {
    if (questFactionReward.id == 0) {
      await storeQuestFactionReward(questFactionReward);
      return;
    }
    var existing = await getQuestFactionReward(questFactionReward.id);
    if (existing != null) {
      await updateQuestFactionReward(questFactionReward);
    } else {
      await laconic.table(_table).insert([questFactionReward.toJson()]);
    }
  }

  Future<int> storeQuestFactionReward(
    QuestFactionRewardEntity questFactionReward,
  ) async {
    final id = questFactionReward.id > 0
        ? questFactionReward.id
        : await _getAvailableId();
    final candidate = questFactionReward.copyWith(id: id);
    var json = candidate.toJson();
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateQuestFactionReward(
    QuestFactionRewardEntity questFactionReward,
  ) async {
    var json = questFactionReward.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', questFactionReward.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    QuestFactionRewardFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  Future<int> _getAvailableId() async {
    if (await getQuestFactionReward(1) == null) return 1;
    if (await getQuestFactionReward(2) == null) return 2;
    throw StateError('任务声望固定记录 1 和 2 已存在，不能继续新增');
  }
}
