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
        .table('$_table as pcis')
        .select([
          'pcis.raceMask',
          'pcis.classMask',
          'pcis.skill',
          'pcis.`rank`',
          'pcis.comment',
          'dsl.DisplayName_lang_zhCN as skillName',
          'dsli.TextureFilename as textureFilename',
        ])
        .leftJoin(
          'foxy.dbc_skill_line as dsl',
          (join) => join.on('pcis.skill', 'dsl.ID'),
        )
        .leftJoin(
          'foxy.dbc_spell_icon as dsli',
          (join) => join.on('dsl.SpellIconID', 'dsli.ID'),
        )
        .whereRaw('(`pcis`.`raceMask` = 0 OR (`pcis`.`raceMask` & ?) <> 0)', [
          raceBit,
        ])
        .whereRaw('(`pcis`.`classMask` = 0 OR (`pcis`.`classMask` & ?) <> 0)', [
          classBit,
        ])
        .orderBy('pcis.raceMask')
        .orderBy('pcis.classMask')
        .orderBy('pcis.skill')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefPlayerCreateInfoSkillEntity.fromJson(row.toMap()))
        .toList();
  }
}
