import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class PlayerCreateInfoSkillRepository with RepositoryMixin {
  static const _table = 'playercreateinfo_skills';

  Future<void> copyPlayerCreateInfoSkill(
    int raceMask,
    int classMask,
    int skill,
  ) async {
    throw UnsupportedError('技能 ID 是复合主键的一部分，请新增记录。');
  }

  Future<PlayerCreateInfoSkillEntity> createPlayerCreateInfoSkill(
    int race,
    int playerClass,
  ) async => PlayerCreateInfoSkillEntity(
    raceMask: playerCreateRaceBit(race),
    classMask: playerCreateClassBit(playerClass),
  );

  Future<void> destroyPlayerCreateInfoSkill(
    int raceMask,
    int classMask,
    int skill,
  ) async {
    await laconic
        .table(_table)
        .where('raceMask', raceMask)
        .where('classMask', classMask)
        .where('skill', skill)
        .delete();
  }

  Future<List<PlayerCreateInfoSkillEntity>> getBriefPlayerCreateInfoSkills(
    int race,
    int playerClass,
  ) async {
    final raceBit = playerCreateRaceBit(race);
    final classBit = playerCreateClassBit(playerClass);
    final rows = await laconic
        .table(_table)
        .whereRaw('(`raceMask` = 0 OR (`raceMask` & ?) <> 0)', [raceBit])
        .whereRaw('(`classMask` = 0 OR (`classMask` & ?) <> 0)', [classBit])
        .orderBy('raceMask')
        .orderBy('classMask')
        .orderBy('skill')
        .get();
    return rows
        .map((row) => PlayerCreateInfoSkillEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<PlayerCreateInfoSkillEntity?> getPlayerCreateInfoSkill(
    int raceMask,
    int classMask,
    int skill,
  ) async {
    final rows = await laconic
        .table(_table)
        .where('raceMask', raceMask)
        .where('classMask', classMask)
        .where('skill', skill)
        .limit(1)
        .get();
    return rows.isEmpty
        ? null
        : PlayerCreateInfoSkillEntity.fromJson(rows.first.toMap());
  }

  Future<void> savePlayerCreateInfoSkill(
    PlayerCreateInfoSkillEntity entity,
  ) async {
    final existing = await getPlayerCreateInfoSkill(
      entity.raceMask,
      entity.classMask,
      entity.skill,
    );
    if (existing == null) {
      await storePlayerCreateInfoSkill(entity);
    } else {
      await updatePlayerCreateInfoSkill(
        entity.raceMask,
        entity.classMask,
        entity.skill,
        entity,
      );
    }
  }

  Future<void> storePlayerCreateInfoSkill(
    PlayerCreateInfoSkillEntity entity,
  ) async {
    await laconic.table(_table).insert([entity.toJson()]);
  }

  Future<void> updatePlayerCreateInfoSkill(
    int raceMask,
    int classMask,
    int skill,
    PlayerCreateInfoSkillEntity entity,
  ) async {
    await laconic
        .table(_table)
        .where('raceMask', raceMask)
        .where('classMask', classMask)
        .where('skill', skill)
        .update(entity.toJson());
  }
}
