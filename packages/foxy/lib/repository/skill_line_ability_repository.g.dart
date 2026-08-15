// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_line_ability_repository.dart';

mixin _SkillLineAbilityRepositoryMixin on RepositoryMixin {
  String get _table => 'foxy.dbc_skill_line_ability';

  Future<SkillLineAbilityKey> copySkillLineAbility(
    SkillLineAbilityKey key,
  ) async {
    final source = await getSkillLineAbility(key);
    if (source == null) {
      throw RecordNotFoundException(
        'foxy.dbc_skill_line_ability record not found',
      );
    }
    final blank = await createSkillLineAbility(source.skillLine);
    final copied = source.copyWith(id: blank.id, skillLine: blank.skillLine);
    await storeSkillLineAbility(copied);
    return SkillLineAbilityKey.fromEntity(copied);
  }

  Future<int> countSkillLineAbilities(int skillLine) async {
    return laconic.table(_table).where('`SkillLine`', skillLine).count();
  }

  Future<SkillLineAbilityEntity> createSkillLineAbility(int skillLine) async {
    return SkillLineAbilityEntity(
      skillLine: skillLine,
      id: await nextMaxPlusOne(
        _table,
        '`ID`',
        where: {'`SkillLine`': skillLine},
      ),
    );
  }

  Future<void> destroySkillLineAbility(SkillLineAbilityKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_skill_line_ability record not found',
      );
    }
  }

  Future<SkillLineAbilityEntity?> getSkillLineAbility(
    SkillLineAbilityKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SkillLineAbilityEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefSkillLineAbilityEntity>> getBriefSkillLineAbilities(
    int skillLine, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`ID`',
      '`SkillLine`',
      '`Spell`',
      '`MinSkillLineRank`',
      '`AcquireMethod`',
    ]);
    builder = builder.where('`SkillLine`', skillLine);
    builder = builder.orderBy('`ID`').orderBy('`SkillLine`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefSkillLineAbilityEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeSkillLineAbility(
    SkillLineAbilityEntity skillLineAbility,
  ) async {
    await _beforeStore(skillLineAbility);
    final json = prepareWriteJson(skillLineAbility.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = skillLineAbility.copyWith(
        id: await nextMaxPlusOne(
          _table,
          '`ID`',
          where: {'`SkillLine`': skillLineAbility.skillLine},
        ),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_skill_line_ability',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateSkillLineAbility(
    SkillLineAbilityKey originalKey,
    SkillLineAbilityEntity skillLineAbility,
  ) async {
    await _beforeUpdate(originalKey, skillLineAbility);
    final json = prepareWriteJson(skillLineAbility.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_skill_line_ability',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_skill_line_ability record not found',
      );
    }
  }

  Future<void> _beforeDestroy(SkillLineAbilityKey key) async {}

  Future<void> _beforeStore(SkillLineAbilityEntity skillLineAbility) async {}

  Future<void> _beforeUpdate(
    SkillLineAbilityKey originalKey,
    SkillLineAbilityEntity skillLineAbility,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, SkillLineAbilityKey key) {
    var query = builder;
    query = query.where('`ID`', key.id);
    query = query.where('`SkillLine`', key.skillLine);
    return query;
  }
}
