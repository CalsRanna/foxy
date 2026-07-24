import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_skill_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'player_create_info_skill_repository.g.dart';

@FoxyRepository(PlayerCreateInfoSkillEntity)
class PlayerCreateInfoSkillRepository
    with RepositoryMixin, _PlayerCreateInfoSkillRepositoryMixin {
  static const _table = 'playercreateinfo_skills';

  Future<void> copyPlayerCreateInfoSkill(PlayerCreateInfoSkillKey key) async {
    throw UnsupportedError('技能 ID 是复合主键的一部分，请新增记录。');
  }

  Future<int> countPlayerCreateInfoSkills(int race, int playerClass) {
    final raceBit = playerCreateRaceBit(race);
    final classBit = playerCreateClassBit(playerClass);
    return laconic
        .table(_table)
        .whereRaw('(`raceMask` = 0 OR (`raceMask` & ?) <> 0)', [raceBit])
        .whereRaw('(`classMask` = 0 OR (`classMask` & ?) <> 0)', [classBit])
        .count();
  }

  Future<PlayerCreateInfoSkillEntity> createPlayerCreateInfoSkill(
    int race,
    int playerClass,
  ) async => PlayerCreateInfoSkillEntity(
    raceMask: playerCreateRaceBit(race),
    classMask: playerCreateClassBit(playerClass),
  );

  Future<List<BriefPlayerCreateInfoSkillEntity>> getBriefPlayerCreateInfoSkills(
    int race,
    int playerClass, {
    int page = 1,
  }) async {
    final raceBit = playerCreateRaceBit(race);
    final classBit = playerCreateClassBit(playerClass);
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
