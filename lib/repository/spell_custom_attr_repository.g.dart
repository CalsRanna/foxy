// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_custom_attr_repository.dart';

mixin _SpellCustomAttrRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellCustomAttr(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('spell_custom_attr'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('spell_custom_attr record not found');
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
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(spellCustomAttr);
    final json = prepareWriteJson(spellCustomAttr.toJson());
    try {
      await laconic.table('spell_custom_attr').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in spell_custom_attr');
      }
      rethrow;
    }
  }

  Future<void> updateSpellCustomAttr(
    int originalKey,
    SpellCustomAttrEntity spellCustomAttr,
  ) async {
    await _beforeUpdate(originalKey, spellCustomAttr);
    final json = prepareWriteJson(spellCustomAttr.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('spell_custom_attr'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in spell_custom_attr');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('spell_custom_attr record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(SpellCustomAttrEntity spellCustomAttr) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellCustomAttrEntity spellCustomAttr,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`spell_id`', key);
  }
}
