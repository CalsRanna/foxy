// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_cast_spell_repository.dart';

mixin _PlayerCreateInfoCastSpellRepositoryMixin on RepositoryMixin {
  Future<void> destroyPlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('playercreateinfo_cast_spell'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<PlayerCreateInfoCastSpellEntity?> getPlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('playercreateinfo_cast_spell'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoCastSpellEntity.fromJson(results.first.toMap());
  }

  Future<void> storePlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellEntity playerCreateInfoCastSpell,
  ) async {
    await _beforeStore(playerCreateInfoCastSpell);
    final json = _prepareWriteJson(playerCreateInfoCastSpell.toJson());
    try {
      await laconic.table('playercreateinfo_cast_spell').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePlayerCreateInfoCastSpell(
    PlayerCreateInfoCastSpellKey originalKey,
    PlayerCreateInfoCastSpellEntity playerCreateInfoCastSpell,
  ) async {
    await _beforeUpdate(originalKey, playerCreateInfoCastSpell);
    final json = _prepareWriteJson(playerCreateInfoCastSpell.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('playercreateinfo_cast_spell'),
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
    PlayerCreateInfoCastSpellEntity playerCreateInfoCastSpell,
  ) async {}

  Future<void> _beforeUpdate(
    PlayerCreateInfoCastSpellKey originalKey,
    PlayerCreateInfoCastSpellEntity playerCreateInfoCastSpell,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(
    QueryBuilder builder,
    PlayerCreateInfoCastSpellKey key,
  ) {
    var query = builder;
    query = query.where('raceMask', key.raceMask);
    query = query.where('classMask', key.classMask);
    query = query.where('spell', key.spell);
    query = query.where('note', key.note);
    return query;
  }
}
