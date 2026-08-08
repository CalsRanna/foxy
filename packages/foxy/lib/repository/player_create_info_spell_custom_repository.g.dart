// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_spell_custom_repository.dart';

mixin _PlayerCreateInfoSpellCustomRepositoryMixin on RepositoryMixin {
  Future<PlayerCreateInfoSpellCustomKey> copyPlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomKey key,
  ) async {
    final source = await getPlayerCreateInfoSpellCustom(key);
    if (source == null) {
      throw RecordNotFoundException(
        'playercreateinfo_spell_custom record not found',
      );
    }
    final blank = await createPlayerCreateInfoSpellCustom(
      source.raceMask,
      source.classMask,
    );
    final copied = source.copyWith(
      raceMask: blank.raceMask,
      classMask: blank.classMask,
      spell: blank.spell,
    );
    await storePlayerCreateInfoSpellCustom(copied);
    return PlayerCreateInfoSpellCustomKey.fromEntity(copied);
  }

  Future<int> countPlayerCreateInfoSpellCustoms(
    int raceMask,
    int classMask,
  ) async {
    return laconic
        .table(_table)
        .where('`racemask`', raceMask)
        .where('`classmask`', classMask)
        .count();
  }

  Future<PlayerCreateInfoSpellCustomEntity> createPlayerCreateInfoSpellCustom(
    int raceMask,
    int classMask,
  ) async {
    return PlayerCreateInfoSpellCustomEntity(
      raceMask: raceMask,
      classMask: classMask,
      spell: await nextMaxPlusOne(
        _table,
        '`Spell`',
        where: {'`racemask`': raceMask, '`classmask`': classMask},
      ),
    );
  }

  Future<void> destroyPlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'playercreateinfo_spell_custom record not found',
      );
    }
  }

  Future<PlayerCreateInfoSpellCustomEntity?> getPlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoSpellCustomEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefPlayerCreateInfoSpellCustomEntity>>
  getBriefPlayerCreateInfoSpellCustoms(
    int raceMask,
    int classMask, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`racemask`',
      '`classmask`',
      '`Spell`',
      '`Note`',
    ]);
    builder = builder
        .where('`racemask`', raceMask)
        .where('`classmask`', classMask);
    builder = builder
        .orderBy('`racemask`')
        .orderBy('`classmask`')
        .orderBy('`Spell`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefPlayerCreateInfoSpellCustomEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storePlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
  ) async {
    await _beforeStore(playerCreateInfoSpellCustom);
    final json = prepareWriteJson(playerCreateInfoSpellCustom.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = playerCreateInfoSpellCustom.copyWith(
        spell: await nextMaxPlusOne(
          _table,
          '`Spell`',
          where: {
            '`racemask`': playerCreateInfoSpellCustom.raceMask,
            '`classmask`': playerCreateInfoSpellCustom.classMask,
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
            'duplicate key in playercreateinfo_spell_custom',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updatePlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomKey originalKey,
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
  ) async {
    await _beforeUpdate(originalKey, playerCreateInfoSpellCustom);
    final json = prepareWriteJson(playerCreateInfoSpellCustom.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in playercreateinfo_spell_custom',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'playercreateinfo_spell_custom record not found',
      );
    }
  }

  Future<void> _beforeDestroy(PlayerCreateInfoSpellCustomKey key) async {}

  Future<void> _beforeStore(
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
  ) async {}

  Future<void> _beforeUpdate(
    PlayerCreateInfoSpellCustomKey originalKey,
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
  ) async {}

  QueryBuilder _whereKey(
    QueryBuilder builder,
    PlayerCreateInfoSpellCustomKey key,
  ) {
    var query = builder;
    query = query.where('`racemask`', key.raceMask);
    query = query.where('`classmask`', key.classMask);
    query = query.where('`Spell`', key.spell);
    return query;
  }
}

const _table = 'playercreateinfo_spell_custom';
