import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_faction_reward_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
class QuestFactionRewardRepository
    with RepositoryMixin, _QuestFactionRewardRepositoryMixin {
  // The generated query layer inlines the table-name literal (mixins cannot
  // access class statics); this only serves as a contract check.
  // ignore: unused_field

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
    throw DuplicateKeyException(
      'fixed quest faction reward records 1 and 2 already exist',
    );
  }
}
