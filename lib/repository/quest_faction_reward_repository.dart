import 'package:foxy/entity/brief_quest_faction_reward_entity.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/entity/quest_faction_reward_filter_entity.dart';
import 'package:foxy/entity/quest_faction_reward_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestFactionRewardRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_quest_faction_reward';

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

  Future<void> destroyQuestFactionReward(QuestFactionRewardKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原任务声望不存在，可能已被其他操作修改或删除');
    }
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

  Future<QuestFactionRewardEntity?> getQuestFactionReward(
    QuestFactionRewardKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return QuestFactionRewardEntity.fromJson(results.first.toMap());
  }

  Future<List<QuestFactionRewardEntity>> getQuestFactionRewards() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => QuestFactionRewardEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeQuestFactionReward(
    QuestFactionRewardEntity questFactionReward,
  ) async {
    if (questFactionReward.id <= 0) {
      throw StateError('任务声望 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([questFactionReward.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('任务声望 ${questFactionReward.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateQuestFactionReward(
    QuestFactionRewardKey originalKey,
    QuestFactionRewardEntity questFactionReward,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(questFactionReward.toJson());
      if (matchedRows == 0) {
        throw StateError('原任务声望不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的任务声望 ID 已存在，无法保存');
      }
      rethrow;
    }
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
    if (await getQuestFactionReward(const QuestFactionRewardKey(id: 1)) ==
        null) {
      return 1;
    }
    if (await getQuestFactionReward(const QuestFactionRewardKey(id: 2)) ==
        null) {
      return 2;
    }
    throw StateError('任务声望固定记录 1 和 2 已存在，不能继续新增');
  }

  QueryBuilder _whereKey(QueryBuilder builder, QuestFactionRewardKey key) {
    return builder.where('ID', key.id);
  }
}
