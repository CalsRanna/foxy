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
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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

  Future<void> storeCreatureDefaultTrainer(
    CreatureDefaultTrainerEntity creatureDefaultTrainer,
  ) async {
    if (creatureDefaultTrainer.creatureId <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(creatureDefaultTrainer);
    final json = prepareWriteJson(creatureDefaultTrainer.toJson());
    try {
      await laconic.table('creature_default_trainer').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
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
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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
