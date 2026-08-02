// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_bonus_data_repository.dart';

mixin _SpellBonusDataRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellBonusData(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('spell_bonus_data'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('spell_bonus_data record not found');
    }
  }

  Future<SpellBonusDataEntity?> getSpellBonusData(int key) async {
    final results = await _whereKey(
      laconic.table('spell_bonus_data'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellBonusDataEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellBonusData(SpellBonusDataEntity spellBonusData) async {
    if (spellBonusData.entry <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(spellBonusData);
    final json = prepareWriteJson(spellBonusData.toJson());
    try {
      await laconic.table('spell_bonus_data').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in spell_bonus_data');
      }
      rethrow;
    }
  }

  Future<void> updateSpellBonusData(
    int originalKey,
    SpellBonusDataEntity spellBonusData,
  ) async {
    await _beforeUpdate(originalKey, spellBonusData);
    final json = prepareWriteJson(spellBonusData.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('spell_bonus_data'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in spell_bonus_data');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('spell_bonus_data record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(SpellBonusDataEntity spellBonusData) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellBonusDataEntity spellBonusData,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`entry`', key);
  }
}
