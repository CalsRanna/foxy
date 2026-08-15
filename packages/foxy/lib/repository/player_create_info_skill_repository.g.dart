// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_skill_repository.dart';

mixin _PlayerCreateInfoSkillRepositoryMixin on RepositoryMixin {
  String get _table => 'playercreateinfo_skills';

  Future<PlayerCreateInfoSkillKey> copyPlayerCreateInfoSkill(
    PlayerCreateInfoSkillKey key,
  ) async {
    final source = await getPlayerCreateInfoSkill(key);
    if (source == null) {
      throw RecordNotFoundException('playercreateinfo_skills record not found');
    }
    final blank = await createPlayerCreateInfoSkill(
      source.raceMask,
      source.classMask,
    );
    final copied = source.copyWith(
      raceMask: blank.raceMask,
      classMask: blank.classMask,
      skill: blank.skill,
    );
    await storePlayerCreateInfoSkill(copied);
    return PlayerCreateInfoSkillKey.fromEntity(copied);
  }

  Future<int> countPlayerCreateInfoSkills(int raceMask, int classMask) async {
    return laconic
        .table(_table)
        .where('`raceMask`', raceMask)
        .where('`classMask`', classMask)
        .count();
  }

  Future<PlayerCreateInfoSkillEntity> createPlayerCreateInfoSkill(
    int raceMask,
    int classMask,
  ) async {
    return PlayerCreateInfoSkillEntity(
      raceMask: raceMask,
      classMask: classMask,
      skill: await nextMaxPlusOne(
        _table,
        '`skill`',
        where: {'`raceMask`': raceMask, '`classMask`': classMask},
      ),
    );
  }

  Future<void> destroyPlayerCreateInfoSkill(
    PlayerCreateInfoSkillKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('playercreateinfo_skills record not found');
    }
  }

  Future<PlayerCreateInfoSkillEntity?> getPlayerCreateInfoSkill(
    PlayerCreateInfoSkillKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoSkillEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefPlayerCreateInfoSkillEntity>> getBriefPlayerCreateInfoSkills(
    int raceMask,
    int classMask, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`raceMask`',
      '`classMask`',
      '`skill`',
      '`rank`',
      '`comment`',
    ]);
    builder = builder
        .where('`raceMask`', raceMask)
        .where('`classMask`', classMask);
    builder = builder
        .orderBy('`raceMask`')
        .orderBy('`classMask`')
        .orderBy('`skill`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefPlayerCreateInfoSkillEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storePlayerCreateInfoSkill(
    PlayerCreateInfoSkillEntity playerCreateInfoSkill,
  ) async {
    await _beforeStore(playerCreateInfoSkill);
    final json = prepareWriteJson(playerCreateInfoSkill.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = playerCreateInfoSkill.copyWith(
        skill: await nextMaxPlusOne(
          _table,
          '`skill`',
          where: {
            '`raceMask`': playerCreateInfoSkill.raceMask,
            '`classMask`': playerCreateInfoSkill.classMask,
          },
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
            'duplicate key in playercreateinfo_skills',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updatePlayerCreateInfoSkill(
    PlayerCreateInfoSkillKey originalKey,
    PlayerCreateInfoSkillEntity playerCreateInfoSkill,
  ) async {
    await _beforeUpdate(originalKey, playerCreateInfoSkill);
    final json = prepareWriteJson(playerCreateInfoSkill.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in playercreateinfo_skills');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('playercreateinfo_skills record not found');
    }
  }

  Future<void> _beforeDestroy(PlayerCreateInfoSkillKey key) async {}

  Future<void> _beforeStore(
    PlayerCreateInfoSkillEntity playerCreateInfoSkill,
  ) async {}

  Future<void> _beforeUpdate(
    PlayerCreateInfoSkillKey originalKey,
    PlayerCreateInfoSkillEntity playerCreateInfoSkill,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, PlayerCreateInfoSkillKey key) {
    var query = builder;
    query = query.where('`raceMask`', key.raceMask);
    query = query.where('`classMask`', key.classMask);
    query = query.where('`skill`', key.skill);
    return query;
  }
}
