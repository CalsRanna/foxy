// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_action_repository.dart';

mixin _PlayerCreateInfoActionRepositoryMixin on RepositoryMixin {
  Future<PlayerCreateInfoActionKey> copyPlayerCreateInfoAction(
    PlayerCreateInfoActionKey key,
  ) async {
    final source = await getPlayerCreateInfoAction(key);
    if (source == null) {
      throw RecordNotFoundException('playercreateinfo_action record not found');
    }
    final blank = await createPlayerCreateInfoAction(
      source.race,
      source.class_,
    );
    final copied = source.copyWith(
      race: blank.race,
      class_: blank.class_,
      button: blank.button,
    );
    await storePlayerCreateInfoAction(copied);
    return PlayerCreateInfoActionKey.fromEntity(copied);
  }

  Future<int> countPlayerCreateInfoActions(int race, int class_) async {
    return laconic
        .table(_table)
        .where('`race`', race)
        .where('`class`', class_)
        .count();
  }

  Future<PlayerCreateInfoActionEntity> createPlayerCreateInfoAction(
    int race,
    int class_,
  ) async {
    return PlayerCreateInfoActionEntity(
      race: race,
      class_: class_,
      button: await nextMaxPlusOne(
        _table,
        '`button`',
        where: {'`race`': race, '`class`': class_},
      ),
    );
  }

  Future<void> destroyPlayerCreateInfoAction(
    PlayerCreateInfoActionKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('playercreateinfo_action record not found');
    }
  }

  Future<PlayerCreateInfoActionEntity?> getPlayerCreateInfoAction(
    PlayerCreateInfoActionKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoActionEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefPlayerCreateInfoActionEntity>>
  getBriefPlayerCreateInfoActions(int race, int class_, {int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`race`',
      '`class`',
      '`button`',
      '`action`',
      '`type`',
    ]);
    builder = builder.where('`race`', race).where('`class`', class_);
    builder = builder.orderBy('`race`').orderBy('`class`').orderBy('`button`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefPlayerCreateInfoActionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storePlayerCreateInfoAction(
    PlayerCreateInfoActionEntity playerCreateInfoAction,
  ) async {
    await _beforeStore(playerCreateInfoAction);
    final json = prepareWriteJson(playerCreateInfoAction.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = playerCreateInfoAction.copyWith(
        button: await nextMaxPlusOne(
          _table,
          '`button`',
          where: {
            '`race`': playerCreateInfoAction.race,
            '`class`': playerCreateInfoAction.class_,
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
            'duplicate key in playercreateinfo_action',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updatePlayerCreateInfoAction(
    PlayerCreateInfoActionKey originalKey,
    PlayerCreateInfoActionEntity playerCreateInfoAction,
  ) async {
    await _beforeUpdate(originalKey, playerCreateInfoAction);
    final json = prepareWriteJson(playerCreateInfoAction.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in playercreateinfo_action');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('playercreateinfo_action record not found');
    }
  }

  Future<void> _beforeDestroy(PlayerCreateInfoActionKey key) async {}

  Future<void> _beforeStore(
    PlayerCreateInfoActionEntity playerCreateInfoAction,
  ) async {}

  Future<void> _beforeUpdate(
    PlayerCreateInfoActionKey originalKey,
    PlayerCreateInfoActionEntity playerCreateInfoAction,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, PlayerCreateInfoActionKey key) {
    var query = builder;
    query = query.where('`race`', key.race);
    query = query.where('`class`', key.class_);
    query = query.where('`button`', key.button);
    return query;
  }
}

const _table = 'playercreateinfo_action';
