import 'package:foxy/entity/player_create_info_cast_spell_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

class PlayerCreateInfoCastSpellRepository with RepositoryMixin {
  static const _table = 'playercreateinfo_cast_spell';

  Map<String, Object?> activityKey(PlayerCreateInfoCastSpellKey key) => {
    'raceMask': key.raceMask,
    'classMask': key.classMask,
    'spell': key.spell,
    'note': key.note,
  };

  Future<void> copyPlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellKey key,
  ) async {
    throw CopyNotSupportedException(
      'login cast spell table has no database primary key; add a unique combination',
    );
  }

  Future<int> countPlayerCreateInfoCastSpells(int race, int playerClass) {
    final raceBit = PlayerCreateInfoConstants.raceBit(race);
    final classBit = PlayerCreateInfoConstants.classBit(playerClass);
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
    raceMask: PlayerCreateInfoConstants.raceBit(race),
    classMask: PlayerCreateInfoConstants.classBit(playerClass),
  );

  Future<void> destroyPlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellKey key,
  ) async {
    const sql =
        'delete from `playercreateinfo_cast_spell` '
        'where `raceMask` = ? and `classMask` = ? and `spell` = ? '
        'and binary `note` <=> binary ? limit 1';
    final values = activityKey(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: values,
      write: () => laconic.affectingStatement(sql, values.values.toList()),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException('record not found');
    }
  }

  Future<List<BriefPlayerCreateInfoCastSpellEntity>>
  getBriefPlayerCreateInfoCastSpells(
    int race,
    int playerClass, {
    int page = 1,
  }) async {
    final raceBit = PlayerCreateInfoConstants.raceBit(race);
    final classBit = PlayerCreateInfoConstants.classBit(playerClass);
    final rows = await laconic
        .table(_table)
        .select([
          'raceMask',
          'classMask',
          'spell',
          'note',
          'ds.Name_lang_zhCN as spellName',
          'dsi.TextureFilename as textureFilename',
        ])
        .leftJoin('foxy.dbc_spell as ds', (join) => join.on('spell', 'ds.ID'))
        .leftJoin(
          'foxy.dbc_spell_icon as dsi',
          (join) => join.on('ds.SpellIconID', 'dsi.ID'),
        )
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
        .whereRaw('binary `note` <=> binary ?', [key.note])
        .limit(1)
        .get();
    return rows.isEmpty
        ? null
        : PlayerCreateInfoCastSpellEntity.fromJson(rows.first.toMap());
  }

  Future<void> storePlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellEntity entity,
  ) async {
    await trackActivityWrite(
      _table,
      afterKey: activityKey(PlayerCreateInfoCastSpellKey.fromEntity(entity)),
      write: () => laconic.table(_table).insert([entity.toJson()]),
    );
  }

  Future<void> updatePlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellKey originalKey,
    PlayerCreateInfoCastSpellEntity entity,
  ) async {
    const sql =
        'update `playercreateinfo_cast_spell` '
        'set `raceMask` = ?, `classMask` = ?, `spell` = ?, `note` = ? '
        'where `raceMask` = ? and `classMask` = ? and `spell` = ? '
        'and binary `note` <=> binary ? limit 1';
    final before = activityKey(originalKey);
    final after = activityKey(PlayerCreateInfoCastSpellKey.fromEntity(entity));
    final matchedRows = await trackActivityWrite(
      _table,
      beforeKey: before,
      afterKey: after,
      columns: after.keys,
      binaryKeyColumns: const {'note'},
      write: () =>
          laconic.affectingStatement(sql, [...after.values, ...before.values]),
    );
    if (matchedRows == 0) {
      throw RecordNotFoundException('record not found');
    }
  }
}
