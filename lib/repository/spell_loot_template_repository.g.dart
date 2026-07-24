// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_loot_template_repository.dart';

mixin _SpellLootTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellLootTemplate(SpellLootTemplateKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('spell_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellLootTemplateEntity?> getSpellLootTemplate(
    SpellLootTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('spell_loot_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellLootTemplate(
    SpellLootTemplateEntity spellLootTemplate,
  ) async {
    await _beforeStore(spellLootTemplate);
    final json = _prepareWriteJson(spellLootTemplate.toJson());
    try {
      await laconic.table('spell_loot_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellLootTemplate(
    SpellLootTemplateKey originalKey,
    SpellLootTemplateEntity spellLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, spellLootTemplate);
    final json = _prepareWriteJson(spellLootTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('spell_loot_template'),
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

  Future<void> _beforeStore(SpellLootTemplateEntity spellLootTemplate) async {}

  Future<void> _beforeUpdate(
    SpellLootTemplateKey originalKey,
    SpellLootTemplateEntity spellLootTemplate,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, SpellLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}
