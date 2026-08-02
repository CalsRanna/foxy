import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_skill_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'player_create_info_skill_repository.g.dart';

@FoxyRepository(
  PlayerCreateInfoSkillEntity,
  parentKey: ['raceMask', 'classMask'],
)
class PlayerCreateInfoSkillRepository
    with RepositoryMixin, _PlayerCreateInfoSkillRepositoryMixin {
  static const _table = 'playercreateinfo_skills';

  @override
  Future<PlayerCreateInfoSkillKey> copyPlayerCreateInfoSkill(
    PlayerCreateInfoSkillKey key,
  ) async {
    throw UnsupportedError('技能 ID 是复合主键的一部分，请新增记录。');
  }

  @override
  Future<int> countPlayerCreateInfoSkills(int raceMask, int classMask) {
    final raceBit = playerCreateRaceBit(raceMask);
    final classBit = playerCreateClassBit(classMask);
    return laconic
        .table(_table)
        .whereRaw('(`raceMask` = 0 OR (`raceMask` & ?) <> 0)', [raceBit])
        .whereRaw('(`classMask` = 0 OR (`classMask` & ?) <> 0)', [classBit])
        .count();
  }

  @override
  Future<PlayerCreateInfoSkillEntity> createPlayerCreateInfoSkill(
    int raceMask,
    int classMask,
  ) async => PlayerCreateInfoSkillEntity(
    raceMask: playerCreateRaceBit(raceMask),
    classMask: playerCreateClassBit(classMask),
  );

  @override
  Future<List<BriefPlayerCreateInfoSkillEntity>> getBriefPlayerCreateInfoSkills(
    int raceMask,
    int classMask, {
    int page = 1,
  }) async {
    final raceBit = playerCreateRaceBit(raceMask);
    final classBit = playerCreateClassBit(classMask);
    final rows = await laconic
        .table(_table)
        .select(['raceMask', 'classMask', 'skill', 'rank', 'comment'])
        .whereRaw('(`raceMask` = 0 OR (`raceMask` & ?) <> 0)', [raceBit])
        .whereRaw('(`classMask` = 0 OR (`classMask` & ?) <> 0)', [classBit])
        .orderBy('raceMask')
        .orderBy('classMask')
        .orderBy('skill')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefPlayerCreateInfoSkillEntity.fromJson(row.toMap()))
        .toList();
  }
}
