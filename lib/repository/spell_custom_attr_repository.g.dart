// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_custom_attr_repository.dart';

mixin _SpellCustomAttrRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellCustomAttr(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('spell_custom_attr'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellCustomAttrEntity?> getSpellCustomAttr(int key) async {
    final results = await _whereKey(
      laconic.table('spell_custom_attr'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellCustomAttrEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellCustomAttr(
    SpellCustomAttrEntity spellCustomAttr,
  ) async {
    if (spellCustomAttr.spellId <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(spellCustomAttr);
    final json = _prepareWriteJson(spellCustomAttr.toJson());
    try {
      await laconic.table('spell_custom_attr').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellCustomAttr(
    int originalKey,
    SpellCustomAttrEntity spellCustomAttr,
  ) async {
    await _beforeUpdate(originalKey, spellCustomAttr);
    final json = _prepareWriteJson(spellCustomAttr.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('spell_custom_attr'),
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

  Future<void> _beforeStore(SpellCustomAttrEntity spellCustomAttr) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellCustomAttrEntity spellCustomAttr,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('spell_id', key);
  }
}
