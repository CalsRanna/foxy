// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_skill_repository.dart';

mixin _PlayerCreateInfoSkillRepositoryMixin on RepositoryMixin {
  Future<void> destroyPlayerCreateInfoSkill(
    PlayerCreateInfoSkillKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('playercreateinfo_skills'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<PlayerCreateInfoSkillEntity?> getPlayerCreateInfoSkill(
    PlayerCreateInfoSkillKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('playercreateinfo_skills'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoSkillEntity.fromJson(results.first.toMap());
  }

  Future<void> storePlayerCreateInfoSkill(
    PlayerCreateInfoSkillEntity playerCreateInfoSkill,
  ) async {
    await _beforeStore(playerCreateInfoSkill);
    final json = _prepareWriteJson(playerCreateInfoSkill.toJson());
    try {
      await laconic.table('playercreateinfo_skills').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePlayerCreateInfoSkill(
    PlayerCreateInfoSkillKey originalKey,
    PlayerCreateInfoSkillEntity playerCreateInfoSkill,
  ) async {
    await _beforeUpdate(originalKey, playerCreateInfoSkill);
    final json = _prepareWriteJson(playerCreateInfoSkill.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('playercreateinfo_skills'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(
    PlayerCreateInfoSkillEntity playerCreateInfoSkill,
  ) async {}

  Future<void> _beforeUpdate(
    PlayerCreateInfoSkillKey originalKey,
    PlayerCreateInfoSkillEntity playerCreateInfoSkill,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, PlayerCreateInfoSkillKey key) {
    var query = builder;
    query = query.where('raceMask', key.raceMask);
    query = query.where('classMask', key.classMask);
    query = query.where('skill', key.skill);
    return query;
  }
}
