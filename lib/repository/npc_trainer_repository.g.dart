// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_trainer_repository.dart';

mixin _NpcTrainerRepositoryMixin on RepositoryMixin {
  Future<NpcTrainerKey> copyNpcTrainer(NpcTrainerKey key) async {
    final source = await getNpcTrainer(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createNpcTrainer(source.trainerId);
    final copied = source.copyWith(
      trainerId: blank.trainerId,
      spellId: blank.spellId,
    );
    await storeNpcTrainer(copied);
    return NpcTrainerKey.fromEntity(copied);
  }

  Future<int> countNpcTrainers(int trainerId) async {
    return laconic
        .table('trainer_spell')
        .where('`TrainerId`', trainerId)
        .count();
  }

  Future<NpcTrainerEntity> createNpcTrainer(int trainerId) async {
    return NpcTrainerEntity(
      trainerId: trainerId,
      spellId: await nextMaxPlusOne(
        'trainer_spell',
        '`SpellId`',
        where: {'TrainerId': trainerId},
      ),
    );
  }

  Future<void> destroyNpcTrainer(NpcTrainerKey key) async {
    await _beforeDestroy(key);
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

  Future<List<BriefNpcTrainerEntity>> getBriefNpcTrainers(
    int trainerId, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('trainer_spell').select([
      '`TrainerId`',
      '`SpellId`',
      '`MoneyCost`',
      '`ReqSkillLine`',
      '`ReqLevel`',
    ]);
    builder = builder.where('`TrainerId`', trainerId);
    builder = builder.orderBy('`TrainerId`').orderBy('`SpellId`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefNpcTrainerEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeNpcTrainer(NpcTrainerEntity npcTrainer) async {
    await _beforeStore(npcTrainer);
    final json = prepareWriteJson(npcTrainer.toJson());
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
    final json = prepareWriteJson(npcTrainer.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('trainer_spell'),
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

  Future<void> _beforeDestroy(NpcTrainerKey key) async {}

  Future<void> _beforeStore(NpcTrainerEntity npcTrainer) async {}

  Future<void> _beforeUpdate(
    NpcTrainerKey originalKey,
    NpcTrainerEntity npcTrainer,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, NpcTrainerKey key) {
    var query = builder;
    query = query.where('`TrainerId`', key.trainerId);
    query = query.where('`SpellId`', key.spellId);
    return query;
  }
}
