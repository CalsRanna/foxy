// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_tiers_repository.dart';

mixin _SkillTiersRepositoryMixin on RepositoryMixin {
  Future<void> destroySkillTiers(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_skill_tiers record not found');
    }
  }

  Future<SkillTiersEntity?> getSkillTiers(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SkillTiersEntity.fromJson(results.first.toMap());
  }

  Future<int> storeSkillTiers(SkillTiersEntity skillTiers) async {
    if (skillTiers.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(skillTiers);
    final json = prepareWriteJson(skillTiers.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = skillTiers.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_skill_tiers');
        }
        rethrow;
      }
    }
    return skillTiers.id;
  }

  Future<void> updateSkillTiers(
    int originalKey,
    SkillTiersEntity skillTiers,
  ) async {
    await _beforeUpdate(originalKey, skillTiers);
    final json = prepareWriteJson(skillTiers.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_skill_tiers');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_skill_tiers record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(SkillTiersEntity skillTiers) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SkillTiersEntity skillTiers,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}

const _table = 'foxy.dbc_skill_tiers';
