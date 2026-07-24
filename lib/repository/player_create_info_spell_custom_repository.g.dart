// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_spell_custom_repository.dart';

mixin _PlayerCreateInfoSpellCustomRepositoryMixin on RepositoryMixin {
  Future<void> destroyPlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('playercreateinfo_spell_custom'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<PlayerCreateInfoSpellCustomEntity?> getPlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('playercreateinfo_spell_custom'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoSpellCustomEntity.fromJson(results.first.toMap());
  }

  Future<void> storePlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
  ) async {
    await _beforeStore(playerCreateInfoSpellCustom);
    final json = _prepareWriteJson(playerCreateInfoSpellCustom.toJson());
    try {
      await laconic.table('playercreateinfo_spell_custom').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomKey originalKey,
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
  ) async {
    await _beforeUpdate(originalKey, playerCreateInfoSpellCustom);
    final json = _prepareWriteJson(playerCreateInfoSpellCustom.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('playercreateinfo_spell_custom'),
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
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
  ) async {}

  Future<void> _beforeUpdate(
    PlayerCreateInfoSpellCustomKey originalKey,
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
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
    PlayerCreateInfoSpellCustomKey key,
  ) {
    var query = builder;
    query = query.where('racemask', key.raceMask);
    query = query.where('classmask', key.classMask);
    query = query.where('Spell', key.spell);
    return query;
  }
}
