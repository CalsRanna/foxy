// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_race_class_info_repository.dart';

mixin _SkillRaceClassInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroySkillRaceClassInfo(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_skill_race_class_info record not found',
      );
    }
  }

  Future<SkillRaceClassInfoEntity?> getSkillRaceClassInfo(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SkillRaceClassInfoEntity.fromJson(results.first.toMap());
  }

  Future<int> storeSkillRaceClassInfo(
    SkillRaceClassInfoEntity skillRaceClassInfo,
  ) async {
    if (skillRaceClassInfo.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(skillRaceClassInfo);
    final json = prepareWriteJson(skillRaceClassInfo.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = skillRaceClassInfo.copyWith(
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
            'duplicate key in foxy.dbc_skill_race_class_info',
          );
        }
        rethrow;
      }
    }
    return skillRaceClassInfo.id;
  }

  Future<void> updateSkillRaceClassInfo(
    int originalKey,
    SkillRaceClassInfoEntity skillRaceClassInfo,
  ) async {
    await _beforeUpdate(originalKey, skillRaceClassInfo);
    final json = prepareWriteJson(skillRaceClassInfo.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_skill_race_class_info',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_skill_race_class_info record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    SkillRaceClassInfoEntity skillRaceClassInfo,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SkillRaceClassInfoEntity skillRaceClassInfo,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}

const _table = 'foxy.dbc_skill_race_class_info';
