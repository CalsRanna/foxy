import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_faction_reward_repository.g.dart';

@FoxyRepository(QuestFactionRewardEntity)
@FoxyFilter.text('id')
class QuestFactionRewardRepository
    with RepositoryMixin, _QuestFactionRewardRepositoryMixin {
  // 生成版查询层内联表名字面量（mixin 无法访问类静态成员），此处仅作契约校验。
  // ignore: unused_field
  static const _table = 'foxy.dbc_quest_faction_reward';

  @override
  Future<QuestFactionRewardEntity> createQuestFactionReward() async {
    return QuestFactionRewardEntity(id: await _getAvailableId());
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
