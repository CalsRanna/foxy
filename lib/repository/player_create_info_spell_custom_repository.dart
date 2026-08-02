import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_spell_custom_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'player_create_info_spell_custom_repository.g.dart';

@FoxyRepository(
  PlayerCreateInfoSpellCustomEntity,
  parentKey: ['raceMask', 'classMask'],
)
class PlayerCreateInfoSpellCustomRepository
    with RepositoryMixin, _PlayerCreateInfoSpellCustomRepositoryMixin {
  static const _table = 'playercreateinfo_spell_custom';

  @override
  Future<PlayerCreateInfoSpellCustomKey> copyPlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomKey key,
  ) async {
    throw CopyNotSupportedException(
      'spell ID is part of a composite primary key; add a new record and select a valid spell',
    );
  }

  @override
  Future<int> countPlayerCreateInfoSpellCustoms(int raceMask, int classMask) {
    final raceBit = playerCreateRaceBit(raceMask);
    final classBit = playerCreateClassBit(classMask);
    return laconic
        .table(_table)
        .whereRaw('(racemask = 0 OR (racemask & ?) <> 0)', [raceBit])
        .whereRaw('(classmask = 0 OR (classmask & ?) <> 0)', [classBit])
        .count();
  }

  @override
  Future<PlayerCreateInfoSpellCustomEntity> createPlayerCreateInfoSpellCustom(
    int raceMask,
    int classMask,
  ) async => PlayerCreateInfoSpellCustomEntity(
    raceMask: playerCreateRaceBit(raceMask),
    classMask: playerCreateClassBit(classMask),
  );

  @override
  Future<List<BriefPlayerCreateInfoSpellCustomEntity>>
  getBriefPlayerCreateInfoSpellCustoms(
    int raceMask,
    int classMask, {
    int page = 1,
  }) async {
    final raceBit = playerCreateRaceBit(raceMask);
    final classBit = playerCreateClassBit(classMask);
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
