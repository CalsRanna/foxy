import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/brief_player_create_info_skill_entity.dart';
import 'package:foxy/entity/player_create_info_skill_entity.dart';
import 'package:foxy/entity/player_create_info_skill_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class PlayerCreateInfoSkillRepository with RepositoryMixin {
  static const _table = 'playercreateinfo_skills';

  Future<void> copyPlayerCreateInfoSkill(PlayerCreateInfoSkillKey key) async {
    throw UnsupportedError('技能 ID 是复合主键的一部分，请新增记录。');
  }

  Future<int> countPlayerCreateInfoSkills(int race, int playerClass) {
    final raceBit = playerCreateRaceBit(race);
    final classBit = playerCreateClassBit(playerClass);
    return laconic
        .table(_table)
        .whereRaw('(`raceMask` = 0 OR (`raceMask` & ?) <> 0)', [raceBit])
        .whereRaw('(`classMask` = 0 OR (`classMask` & ?) <> 0)', [classBit])
        .count();
  }

  Future<PlayerCreateInfoSkillEntity> createPlayerCreateInfoSkill(
    int race,
    int playerClass,
  ) async => PlayerCreateInfoSkillEntity(
    raceMask: playerCreateRaceBit(race),
    classMask: playerCreateClassBit(playerClass),
  );

  Future<void> destroyPlayerCreateInfoSkill(
    PlayerCreateInfoSkillKey key,
  ) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原出生技能记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefPlayerCreateInfoSkillEntity>> getBriefPlayerCreateInfoSkills(
    int race,
    int playerClass, {
    int page = 1,
  }) async {
    final raceBit = playerCreateRaceBit(race);
    final classBit = playerCreateClassBit(playerClass);
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

  Future<PlayerCreateInfoSkillEntity?> getPlayerCreateInfoSkill(
    PlayerCreateInfoSkillKey key,
  ) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty
        ? null
        : PlayerCreateInfoSkillEntity.fromJson(rows.first.toMap());
  }

  Future<void> storePlayerCreateInfoSkill(
    PlayerCreateInfoSkillEntity entity,
  ) async {
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同种族、职业与技能 ID 的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePlayerCreateInfoSkill(
    PlayerCreateInfoSkillKey originalKey,
    PlayerCreateInfoSkillEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原出生技能记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的种族、职业与技能 ID 组合已存在');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, PlayerCreateInfoSkillKey key) {
    return builder
        .where('raceMask', key.raceMask)
        .where('classMask', key.classMask)
        .where('skill', key.skill);
  }
}
