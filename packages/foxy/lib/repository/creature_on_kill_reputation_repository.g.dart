// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_on_kill_reputation_repository.dart';

mixin _CreatureOnKillReputationRepositoryMixin on RepositoryMixin {
  String get _table => 'creature_onkill_reputation';

  Future<void> destroyCreatureOnKillReputation(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'creature_onkill_reputation record not found',
      );
    }
  }

  Future<CreatureOnKillReputationEntity?> getCreatureOnKillReputation(
    int key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureOnKillReputationEntity.fromJson(results.first.toMap());
  }

  Future<int> storeCreatureOnKillReputation(
    CreatureOnKillReputationEntity creatureOnKillReputation,
  ) async {
    if (creatureOnKillReputation.creatureID <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(creatureOnKillReputation);
    final json = prepareWriteJson(creatureOnKillReputation.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureOnKillReputation.copyWith(
        creatureID: await nextMaxPlusOne(_table, '`creature_id`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.creatureID;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in creature_onkill_reputation',
          );
        }
        rethrow;
      }
    }
    return creatureOnKillReputation.creatureID;
  }

  Future<void> updateCreatureOnKillReputation(
    int originalKey,
    CreatureOnKillReputationEntity creatureOnKillReputation,
  ) async {
    await _beforeUpdate(originalKey, creatureOnKillReputation);
    final json = prepareWriteJson(creatureOnKillReputation.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in creature_onkill_reputation',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'creature_onkill_reputation record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    CreatureOnKillReputationEntity creatureOnKillReputation,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureOnKillReputationEntity creatureOnKillReputation,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`creature_id`', key);
  }
}
