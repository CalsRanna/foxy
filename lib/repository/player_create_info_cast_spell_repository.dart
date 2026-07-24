import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_cast_spell_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class PlayerCreateInfoCastSpellRepository with RepositoryMixin {
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

  Future<void> destroyPlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellKey key,
  ) async {
    const sql =
        'DELETE FROM `playercreateinfo_cast_spell` '
        'WHERE `raceMask` = ? AND `classMask` = ? AND `spell` = ? '
        'AND BINARY `note` <=> BINARY ? LIMIT 1';
    final deletedRows = await laconic.affectingStatement(sql, [
      key.raceMask,
      key.classMask,
      key.spell,
      key.note,
    ]);
    if (deletedRows == 0) {
      throw StateError('原登录施法记录不存在，可能已被其他操作修改或删除');
    }
  }

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

  Future<PlayerCreateInfoCastSpellEntity?> getPlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellKey key,
  ) async {
    final rows = await laconic
        .table(_table)
        .where('raceMask', key.raceMask)
        .where('classMask', key.classMask)
        .where('spell', key.spell)
        .whereRaw('BINARY `note` <=> BINARY ?', [key.note])
        .limit(1)
        .get();
    return rows.isEmpty
        ? null
        : PlayerCreateInfoCastSpellEntity.fromJson(rows.first.toMap());
  }

  Future<void> storePlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellEntity entity,
  ) async {
    await laconic.table(_table).insert([entity.toJson()]);
  }

  Future<void> updatePlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellKey originalKey,
    PlayerCreateInfoCastSpellEntity entity,
  ) async {
    const sql =
        'UPDATE `playercreateinfo_cast_spell` '
        'SET `raceMask` = ?, `classMask` = ?, `spell` = ?, `note` = ? '
        'WHERE `raceMask` = ? AND `classMask` = ? AND `spell` = ? '
        'AND BINARY `note` <=> BINARY ? LIMIT 1';
    final matchedRows = await laconic.affectingStatement(sql, [
      entity.raceMask,
      entity.classMask,
      entity.spell,
      entity.note,
      originalKey.raceMask,
      originalKey.classMask,
      originalKey.spell,
      originalKey.note,
    ]);
    if (matchedRows == 0) {
      throw StateError('原登录施法记录不存在，可能已被其他操作修改或删除');
    }
  }
}
