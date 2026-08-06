// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_default_trainer_repository.dart';

mixin _CreatureDefaultTrainerRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureDefaultTrainer(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_default_trainer'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'creature_default_trainer record not found',
      );
    }
  }

  Future<CreatureDefaultTrainerEntity?> getCreatureDefaultTrainer(
    int key,
  ) async {
    final results = await _whereKey(
      laconic.table('creature_default_trainer'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureDefaultTrainerEntity.fromJson(results.first.toMap());
  }

  Future<int> storeCreatureDefaultTrainer(
    CreatureDefaultTrainerEntity creatureDefaultTrainer,
  ) async {
    if (creatureDefaultTrainer.creatureId <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(creatureDefaultTrainer);
    final json = prepareWriteJson(creatureDefaultTrainer.toJson());
    try {
      await laconic.table('creature_default_trainer').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureDefaultTrainer.copyWith(
        creatureId: await nextMaxPlusOne(
          'creature_default_trainer',
          '`CreatureId`',
        ),
      );
      try {
        await laconic.table('creature_default_trainer').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.creatureId;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in creature_default_trainer',
          );
        }
        rethrow;
      }
    }
    return creatureDefaultTrainer.creatureId;
  }

  Future<void> updateCreatureDefaultTrainer(
    int originalKey,
    CreatureDefaultTrainerEntity creatureDefaultTrainer,
  ) async {
    await _beforeUpdate(originalKey, creatureDefaultTrainer);
    final json = prepareWriteJson(creatureDefaultTrainer.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('creature_default_trainer'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in creature_default_trainer',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'creature_default_trainer record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    CreatureDefaultTrainerEntity creatureDefaultTrainer,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureDefaultTrainerEntity creatureDefaultTrainer,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`CreatureId`', key);
  }
}
