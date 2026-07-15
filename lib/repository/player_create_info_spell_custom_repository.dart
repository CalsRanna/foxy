import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/repository/repository_mixin.dart';

class PlayerCreateInfoSpellCustomRepository with RepositoryMixin {
  static const _table = 'playercreateinfo_spell_custom';

  Future<List<PlayerCreateInfoSpellCustomEntity>>
  getBriefPlayerCreateInfoSpellCustoms(int race, int playerClass) async {
    final raceBit = playerCreateRaceBit(race);
    final classBit = playerCreateClassBit(playerClass);
    var results = await laconic
        .table(_table)
        .whereRaw('(racemask = 0 OR (racemask & ?) <> 0)', [raceBit])
        .whereRaw('(classmask = 0 OR (classmask & ?) <> 0)', [classBit])
        .orderBy('racemask')
        .orderBy('classmask')
        .orderBy('Spell')
        .get();
    return results
        .map((e) => PlayerCreateInfoSpellCustomEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<PlayerCreateInfoSpellCustomEntity?> getPlayerCreateInfoSpellCustom(
    int racemask,
    int classmask,
    int spell,
  ) async {
    var results = await laconic
        .table(_table)
        .where('racemask', racemask)
        .where('classmask', classmask)
        .where('spell', spell)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoSpellCustomEntity.fromJson(results.first.toMap());
  }

  Future<PlayerCreateInfoSpellCustomEntity> createPlayerCreateInfoSpellCustom(
    int racemask,
    int classmask,
  ) async {
    return PlayerCreateInfoSpellCustomEntity(
      racemask: racemask,
      classmask: classmask,
    );
  }

  Future<void> storePlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomEntity spell,
  ) async {
    await laconic.table(_table).insert([spell.toJson()]);
  }

  Future<void> updatePlayerCreateInfoSpellCustom(
    int racemask,
    int classmask,
    int spell,
    PlayerCreateInfoSpellCustomEntity entity,
  ) async {
    var json = entity.toJson();
    json.remove('racemask');
    json.remove('classmask');
    json.remove('Spell');
    await laconic
        .table(_table)
        .where('racemask', racemask)
        .where('classmask', classmask)
        .where('spell', spell)
        .update(json);
  }

  Future<void> destroyPlayerCreateInfoSpellCustom(
    int racemask,
    int classmask,
    int spell,
  ) async {
    await laconic
        .table(_table)
        .where('racemask', racemask)
        .where('classmask', classmask)
        .where('spell', spell)
        .delete();
  }

  Future<void> copyPlayerCreateInfoSpellCustom(
    int racemask,
    int classmask,
    int spell,
  ) async {
    throw UnsupportedError('法术 ID 是复合主键的一部分，请新增并选择有效法术。');
  }

  Future<void> savePlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomEntity entity,
  ) async {
    var existing = await getPlayerCreateInfoSpellCustom(
      entity.racemask,
      entity.classmask,
      entity.spell,
    );
    if (existing != null) {
      await updatePlayerCreateInfoSpellCustom(
        entity.racemask,
        entity.classmask,
        entity.spell,
        entity,
      );
    } else {
      await storePlayerCreateInfoSpellCustom(entity);
    }
  }
}
