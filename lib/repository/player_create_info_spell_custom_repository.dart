import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_spell_custom_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'player_create_info_spell_custom_repository.g.dart';

@FoxyRepository(PlayerCreateInfoSpellCustomEntity)
class PlayerCreateInfoSpellCustomRepository
    with RepositoryMixin, _PlayerCreateInfoSpellCustomRepositoryMixin {
  static const _table = 'playercreateinfo_spell_custom';

  Future<void> copyPlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomKey key,
  ) async {
    throw UnsupportedError('法术 ID 是复合主键的一部分，请新增并选择有效法术。');
  }

  Future<int> countPlayerCreateInfoSpellCustoms(int race, int playerClass) {
    final raceBit = playerCreateRaceBit(race);
    final classBit = playerCreateClassBit(playerClass);
    return laconic
        .table(_table)
        .whereRaw('(racemask = 0 OR (racemask & ?) <> 0)', [raceBit])
        .whereRaw('(classmask = 0 OR (classmask & ?) <> 0)', [classBit])
        .count();
  }

  Future<PlayerCreateInfoSpellCustomEntity> createPlayerCreateInfoSpellCustom(
    int race,
    int playerClass,
  ) async => PlayerCreateInfoSpellCustomEntity(
    raceMask: playerCreateRaceBit(race),
    classMask: playerCreateClassBit(playerClass),
  );

  Future<List<BriefPlayerCreateInfoSpellCustomEntity>>
  getBriefPlayerCreateInfoSpellCustoms(
    int race,
    int playerClass, {
    int page = 1,
  }) async {
    final raceBit = playerCreateRaceBit(race);
    final classBit = playerCreateClassBit(playerClass);
    final results = await laconic
        .table(_table)
        .select(['racemask', 'classmask', 'Spell', 'Note'])
        .whereRaw('(racemask = 0 OR (racemask & ?) <> 0)', [raceBit])
        .whereRaw('(classmask = 0 OR (classmask & ?) <> 0)', [classBit])
        .orderBy('racemask')
        .orderBy('classmask')
        .orderBy('Spell')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map(
          (row) => BriefPlayerCreateInfoSpellCustomEntity.fromJson(row.toMap()),
        )
        .toList();
  }
}
