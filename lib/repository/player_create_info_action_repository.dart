import 'package:foxy/entity/player_create_info_action_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'player_create_info_action_repository.g.dart';

@FoxyRepository(PlayerCreateInfoActionEntity, parentKey: ['race', 'class_'])
class PlayerCreateInfoActionRepository
    with RepositoryMixin, _PlayerCreateInfoActionRepositoryMixin {
  static const _table = 'playercreateinfo_action';

  @override
  Future<PlayerCreateInfoActionKey> copyPlayerCreateInfoAction(
    PlayerCreateInfoActionKey key,
  ) async {
    throw CopyNotSupportedException(
      'action button index must be explicitly selected within 0..143; add a new record',
    );
  }

  @override
  Future<int> countPlayerCreateInfoActions(int race, int class_) {
    return laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .count();
  }

  @override
  Future<PlayerCreateInfoActionEntity> createPlayerCreateInfoAction(
    int race,
    int class_,
  ) async => PlayerCreateInfoActionEntity(race: race, class_: class_);

  @override
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
