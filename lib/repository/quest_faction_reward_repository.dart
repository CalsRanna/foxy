import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_faction_reward_repository.g.dart';

@FoxyRepository(QuestFactionRewardEntity)
@FoxyFilter.text('id')
class QuestFactionRewardRepository
    with RepositoryMixin, _QuestFactionRewardRepositoryMixin {
  static const _table = 'foxy.dbc_quest_faction_reward';

  Future<int> countQuestFactionRewards({
    QuestFactionRewardFilter? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestFactionRewardEntity> createQuestFactionReward() async {
    return QuestFactionRewardEntity(id: await _getAvailableId());
  }

  Future<List<BriefQuestFactionRewardEntity>> getBriefQuestFactionRewards({
    int page = 1,
    QuestFactionRewardFilter? filter,
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    QuestFactionRewardFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  Future<int> _getAvailableId() async {
    if (await getQuestFactionReward(1) == null) {
      return 1;
    }
    if (await getQuestFactionReward(2) == null) {
      return 2;
    }
    throw StateError('任务声望固定记录 1 和 2 已存在，不能继续新增');
  }
}
