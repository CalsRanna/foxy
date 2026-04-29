import 'package:foxy/entity/quest_faction_reward.dart';
import 'package:foxy/entity/quest_faction_reward_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestFactionRewardRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_quest_faction_reward';

  Future<List<QuestFactionReward>> getQuestFactionRewards({
    int page = 1,
    QuestFactionRewardFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => QuestFactionReward.fromJson(e.toMap())).toList();
  }

  Future<int> countQuestFactionRewards({
    QuestFactionRewardFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestFactionReward?> getQuestFactionReward(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return QuestFactionReward.fromJson(result.toMap());
  }

  Future<void> storeQuestFactionReward(QuestFactionReward data) async {
    var json = data.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateQuestFactionReward(QuestFactionReward data) async {
    var json = data.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', data.id).update(json);
  }

  Future<void> destroyQuestFactionReward(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyQuestFactionReward(int id) async {
    var source = await getQuestFactionReward(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(
    dynamic builder,
    QuestFactionRewardFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
