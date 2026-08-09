// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_costs_data_repository.dart';

mixin _SkillCostsDataRepositoryMixin on RepositoryMixin {
  Future<void> destroySkillCostsData(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_skill_costs_data record not found',
      );
    }
  }

  Future<SkillCostsDataEntity?> getSkillCostsData(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SkillCostsDataEntity.fromJson(results.first.toMap());
  }

  Future<int> storeSkillCostsData(SkillCostsDataEntity skillCostsData) async {
    if (skillCostsData.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(skillCostsData);
    final json = prepareWriteJson(skillCostsData.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = skillCostsData.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_skill_costs_data',
          );
        }
        rethrow;
      }
    }
    return skillCostsData.id;
  }

  Future<void> updateSkillCostsData(
    int originalKey,
    SkillCostsDataEntity skillCostsData,
  ) async {
    await _beforeUpdate(originalKey, skillCostsData);
    final json = prepareWriteJson(skillCostsData.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_skill_costs_data',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_skill_costs_data record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(SkillCostsDataEntity skillCostsData) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SkillCostsDataEntity skillCostsData,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}

const _table = 'foxy.dbc_skill_costs_data';
