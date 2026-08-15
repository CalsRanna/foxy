// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_custom_attr_repository.dart';

mixin _SpellCustomAttrRepositoryMixin on RepositoryMixin {
  String get _table => 'spell_custom_attr';

  Future<void> destroySpellCustomAttr(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('spell_custom_attr record not found');
    }
  }

  Future<SpellCustomAttrEntity?> getSpellCustomAttr(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellCustomAttrEntity.fromJson(results.first.toMap());
  }

  Future<int> storeSpellCustomAttr(
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
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = spellCustomAttr.copyWith(
        spellId: await nextMaxPlusOne(_table, '`spell_id`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.spellId;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in spell_custom_attr');
        }
        rethrow;
      }
    }
    return spellCustomAttr.spellId;
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
        laconic.table(_table),
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
