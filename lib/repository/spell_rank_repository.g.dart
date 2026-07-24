// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_rank_repository.dart';

mixin _SpellRankRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellRank(SpellRankKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('spell_ranks'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellRankEntity?> getSpellRank(SpellRankKey key) async {
    final results = await _whereKey(
      laconic.table('spell_ranks'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellRankEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellRank(SpellRankEntity spellRank) async {
    await _beforeStore(spellRank);
    final json = _prepareWriteJson(spellRank.toJson());
    try {
      await laconic.table('spell_ranks').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellRank(
    SpellRankKey originalKey,
    SpellRankEntity spellRank,
  ) async {
    await _beforeUpdate(originalKey, spellRank);
    final json = _prepareWriteJson(spellRank.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('spell_ranks'),
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

  Future<void> _beforeStore(SpellRankEntity spellRank) async {}

  Future<void> _beforeUpdate(
    SpellRankKey originalKey,
    SpellRankEntity spellRank,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, SpellRankKey key) {
    var query = builder;
    query = query.where('first_spell_id', key.firstSpellId);
    query = query.where('rank', key.rank);
    return query;
  }
}
