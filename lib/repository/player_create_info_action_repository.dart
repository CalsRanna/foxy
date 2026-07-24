import 'package:foxy/entity/player_create_info_action_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'player_create_info_action_repository.g.dart';

@FoxyRepository(PlayerCreateInfoActionEntity)
class PlayerCreateInfoActionRepository
    with RepositoryMixin, _PlayerCreateInfoActionRepositoryMixin {
  static const _table = 'playercreateinfo_action';

  Future<void> copyPlayerCreateInfoAction(PlayerCreateInfoActionKey key) async {
    throw UnsupportedError('动作按钮编号必须在 0..143 内明确选择，请新增记录。');
  }

  Future<int> countPlayerCreateInfoActions(int race, int class_) {
    return laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .count();
  }

  Future<PlayerCreateInfoActionEntity> createPlayerCreateInfoAction(
    int race,
    int class_,
  ) async => PlayerCreateInfoActionEntity(race: race, class_: class_);

  Future<List<BriefPlayerCreateInfoActionEntity>>
  getBriefPlayerCreateInfoActions(int race, int class_, {int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select(['race', 'class', 'button', 'action', 'type'])
        .where('race', race)
        .where('class', class_)
        .orderBy('button')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefPlayerCreateInfoActionEntity.fromJson(row.toMap()))
        .toList();
  }
}
