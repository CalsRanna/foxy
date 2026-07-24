import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_cast_spell_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'player_create_info_cast_spell_repository.g.dart';

@FoxyRepository(PlayerCreateInfoCastSpellEntity)
class PlayerCreateInfoCastSpellRepository
    with RepositoryMixin, _PlayerCreateInfoCastSpellRepositoryMixin {
  static const _table = 'playercreateinfo_cast_spell';

  Future<void> copyPlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellKey key,
  ) async {
    throw UnsupportedError('登录施法表没有数据库主键，请新增唯一组合。');
  }

  Future<int> countPlayerCreateInfoCastSpells(int race, int playerClass) {
    final raceBit = playerCreateRaceBit(race);
    final classBit = playerCreateClassBit(playerClass);
    return laconic
        .table(_table)
        .whereRaw('(`raceMask` = 0 OR (`raceMask` & ?) <> 0)', [raceBit])
        .whereRaw('(`classMask` = 0 OR (`classMask` & ?) <> 0)', [classBit])
        .count();
  }

  Future<PlayerCreateInfoCastSpellEntity> createPlayerCreateInfoCastSpell(
    int race,
    int playerClass,
  ) async => PlayerCreateInfoCastSpellEntity(
    raceMask: playerCreateRaceBit(race),
    classMask: playerCreateClassBit(playerClass),
  );

  Future<List<BriefPlayerCreateInfoCastSpellEntity>>
  getBriefPlayerCreateInfoCastSpells(
    int race,
    int playerClass, {
    int page = 1,
  }) async {
    final raceBit = playerCreateRaceBit(race);
    final classBit = playerCreateClassBit(playerClass);
    final rows = await laconic
        .table(_table)
        .select(['raceMask', 'classMask', 'spell', 'note'])
        .whereRaw('(`raceMask` = 0 OR (`raceMask` & ?) <> 0)', [raceBit])
        .whereRaw('(`classMask` = 0 OR (`classMask` & ?) <> 0)', [classBit])
        .orderBy('raceMask')
        .orderBy('classMask')
        .orderBy('spell')
        .orderBy('note')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map(
          (row) => BriefPlayerCreateInfoCastSpellEntity.fromJson(row.toMap()),
        )
        .toList();
  }
}
