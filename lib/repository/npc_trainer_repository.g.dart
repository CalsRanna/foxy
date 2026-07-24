// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_trainer_repository.dart';

mixin _NpcTrainerRepositoryMixin on RepositoryMixin {
  Future<void> destroyNpcTrainer(NpcTrainerKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('trainer_spell'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<NpcTrainerEntity?> getNpcTrainer(NpcTrainerKey key) async {
    final results = await _whereKey(
      laconic.table('trainer_spell'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return NpcTrainerEntity.fromJson(results.first.toMap());
  }

  Future<void> storeNpcTrainer(NpcTrainerEntity npcTrainer) async {
    await _beforeStore(npcTrainer);
    final json = _prepareWriteJson(npcTrainer.toJson());
    try {
      await laconic.table('trainer_spell').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateNpcTrainer(
    NpcTrainerKey originalKey,
    NpcTrainerEntity npcTrainer,
  ) async {
    await _beforeUpdate(originalKey, npcTrainer);
    final json = _prepareWriteJson(npcTrainer.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('trainer_spell'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(NpcTrainerEntity npcTrainer) async {}

  Future<void> _beforeUpdate(
    NpcTrainerKey originalKey,
    NpcTrainerEntity npcTrainer,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, NpcTrainerKey key) {
    var query = builder;
    query = query.where('TrainerId', key.trainerId);
    query = query.where('SpellId', key.spellId);
    return query;
  }
}
