// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_text_locale_repository.dart';

mixin _NpcTextLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyNpcTextLocale(NpcTextLocaleKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('npc_text_locale'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<NpcTextLocaleEntity?> getNpcTextLocale(NpcTextLocaleKey key) async {
    final results = await _whereKey(
      laconic.table('npc_text_locale'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return NpcTextLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeNpcTextLocale(NpcTextLocaleEntity npcTextLocale) async {
    await _beforeStore(npcTextLocale);
    final json = _prepareWriteJson(npcTextLocale.toJson());
    try {
      await laconic.table('npc_text_locale').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateNpcTextLocale(
    NpcTextLocaleKey originalKey,
    NpcTextLocaleEntity npcTextLocale,
  ) async {
    await _beforeUpdate(originalKey, npcTextLocale);
    final json = _prepareWriteJson(npcTextLocale.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('npc_text_locale'),
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

  Future<void> _beforeStore(NpcTextLocaleEntity npcTextLocale) async {}

  Future<void> _beforeUpdate(
    NpcTextLocaleKey originalKey,
    NpcTextLocaleEntity npcTextLocale,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, NpcTextLocaleKey key) {
    var query = builder;
    query = query.where('ID', key.id);
    query = query.where('Locale', key.locale);
    return query;
  }
}
