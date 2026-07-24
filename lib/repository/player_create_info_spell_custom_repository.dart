import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/brief_player_create_info_spell_custom_entity.dart';
import 'package:foxy/entity/player_create_info_spell_custom_entity.dart';
import 'package:foxy/entity/player_create_info_spell_custom_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class PlayerCreateInfoSpellCustomRepository with RepositoryMixin {
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

  Future<void> destroyPlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomKey key,
  ) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原自定义法术记录不存在，可能已被其他操作修改或删除');
    }
  }

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

  Future<PlayerCreateInfoSpellCustomEntity?> getPlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoSpellCustomEntity.fromJson(results.first.toMap());
  }

  Future<void> storePlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomEntity entity,
  ) async {
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同种族、职业与法术 ID 的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomKey originalKey,
    PlayerCreateInfoSpellCustomEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原自定义法术记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的种族、职业与法术 ID 组合已存在');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(
    QueryBuilder builder,
    PlayerCreateInfoSpellCustomKey key,
  ) {
    return builder
        .where('racemask', key.raceMask)
        .where('classmask', key.classMask)
        .where('Spell', key.spell);
  }
}
