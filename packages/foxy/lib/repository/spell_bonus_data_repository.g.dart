// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_bonus_data_repository.dart';

mixin _SpellBonusDataRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellBonusData(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('spell_bonus_data record not found');
    }
  }

  Future<SpellBonusDataEntity?> getSpellBonusData(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellBonusDataEntity.fromJson(results.first.toMap());
  }

  Future<int> storeSpellBonusData(SpellBonusDataEntity spellBonusData) async {
    if (spellBonusData.entry <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(spellBonusData);
    final json = prepareWriteJson(spellBonusData.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = spellBonusData.copyWith(
        entry: await nextMaxPlusOne(_table, '`entry`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.entry;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in spell_bonus_data');
        }
        rethrow;
      }
    }
    return spellBonusData.entry;
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
        laconic.table(_table),
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

const _table = 'spell_bonus_data';
