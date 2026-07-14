import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class PlayerCreateInfoCastSpellRepository with RepositoryMixin {
  static const _table = 'playercreateinfo_cast_spell';

  Future<List<PlayerCreateInfoCastSpellEntity>>
  getBriefPlayerCreateInfoCastSpells(int race, int playerClass) async {
    final raceBit = playerCreateRaceBit(race);
    final classBit = playerCreateClassBit(playerClass);
    final rows = await laconic
        .table(_table)
        .whereRaw('(`raceMask` = 0 OR (`raceMask` & ?) <> 0)', [raceBit])
        .whereRaw('(`classMask` = 0 OR (`classMask` & ?) <> 0)', [classBit])
        .orderBy('raceMask')
        .orderBy('classMask')
        .orderBy('spell')
        .get();
    return rows
        .map((row) => PlayerCreateInfoCastSpellEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<PlayerCreateInfoCastSpellEntity?> getPlayerCreateInfoCastSpell(
    int raceMask,
    int classMask,
    int spell,
  ) async {
    final rows = await laconic
        .table(_table)
        .where('raceMask', raceMask)
        .where('classMask', classMask)
        .where('spell', spell)
        .limit(1)
        .get();
    return rows.isEmpty
        ? null
        : PlayerCreateInfoCastSpellEntity.fromJson(rows.first.toMap());
  }

  Future<PlayerCreateInfoCastSpellEntity> createPlayerCreateInfoCastSpell(
    int race,
    int playerClass,
  ) async => PlayerCreateInfoCastSpellEntity(
    raceMask: playerCreateRaceBit(race),
    classMask: playerCreateClassBit(playerClass),
  );

  Future<void> storePlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellEntity entity,
  ) async {
    entity.validate();
    await laconic.table(_table).insert([entity.toJson()]);
  }

  Future<void> updatePlayerCreateInfoCastSpell(
    int raceMask,
    int classMask,
    int spell,
    PlayerCreateInfoCastSpellEntity entity,
  ) async {
    entity.validate();
    await laconic
        .table(_table)
        .where('raceMask', raceMask)
        .where('classMask', classMask)
        .where('spell', spell)
        .update(entity.toJson());
  }

  Future<void> destroyPlayerCreateInfoCastSpell(
    int raceMask,
    int classMask,
    int spell,
  ) async {
    await laconic
        .table(_table)
        .where('raceMask', raceMask)
        .where('classMask', classMask)
        .where('spell', spell)
        .delete();
  }

  Future<void> copyPlayerCreateInfoCastSpell(
    int raceMask,
    int classMask,
    int spell,
  ) async {
    throw UnsupportedError('登录施法表没有数据库主键，请新增唯一组合。');
  }

  Future<void> savePlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellEntity entity,
  ) async {
    final existing = await getPlayerCreateInfoCastSpell(
      entity.raceMask,
      entity.classMask,
      entity.spell,
    );
    if (existing == null) {
      await storePlayerCreateInfoCastSpell(entity);
    } else {
      await updatePlayerCreateInfoCastSpell(
        entity.raceMask,
        entity.classMask,
        entity.spell,
        entity,
      );
    }
  }
}
