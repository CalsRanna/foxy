import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_skill_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'player_create_info_skill_repository.g.dart';

@FoxyRepository(linkKey: ['raceMask', 'classMask'])
class PlayerCreateInfoSkillRepository
    with RepositoryMixin, _PlayerCreateInfoSkillRepositoryMixin {
  @override
  Future<PlayerCreateInfoSkillKey> copyPlayerCreateInfoSkill(
    PlayerCreateInfoSkillKey key,
  ) async {
    throw CopyNotSupportedException(
      'skill ID is part of a composite primary key; add a new record',
    );
  }

  @override
  Future<int> countPlayerCreateInfoSkills(int raceMask, int classMask) {
    final raceBit = PlayerCreateInfoConstants.raceBit(raceMask);
    final classBit = PlayerCreateInfoConstants.classBit(classMask);
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
    raceMask: PlayerCreateInfoConstants.raceBit(raceMask),
    classMask: PlayerCreateInfoConstants.classBit(classMask),
  );

  @override
  Future<List<BriefPlayerCreateInfoSkillEntity>> getBriefPlayerCreateInfoSkills(
    int raceMask,
    int classMask, {
    int page = 1,
  }) async {
    final raceBit = PlayerCreateInfoConstants.raceBit(raceMask);
    final classBit = PlayerCreateInfoConstants.classBit(classMask);
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
