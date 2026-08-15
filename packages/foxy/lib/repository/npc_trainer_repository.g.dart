// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_trainer_repository.dart';

mixin _NpcTrainerRepositoryMixin on RepositoryMixin {
  String get _table => 'trainer_spell';

  Future<NpcTrainerKey> copyNpcTrainer(NpcTrainerKey key) async {
    final source = await getNpcTrainer(key);
    if (source == null) {
      throw RecordNotFoundException('trainer_spell record not found');
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
    return laconic.table(_table).where('`TrainerId`', trainerId).count();
  }

  Future<NpcTrainerEntity> createNpcTrainer(int trainerId) async {
    return NpcTrainerEntity(
      trainerId: trainerId,
      spellId: await nextMaxPlusOne(
        _table,
        '`SpellId`',
        where: {'`TrainerId`': trainerId},
      ),
    );
  }

  Future<void> destroyNpcTrainer(NpcTrainerKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('trainer_spell record not found');
    }
  }

  Future<NpcTrainerEntity?> getNpcTrainer(NpcTrainerKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return NpcTrainerEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefNpcTrainerEntity>> getBriefNpcTrainers(
    int trainerId, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
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
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = npcTrainer.copyWith(
        spellId: await nextMaxPlusOne(
          _table,
          '`SpellId`',
          where: {'`TrainerId`': npcTrainer.trainerId},
        ),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in trainer_spell');
        }
        rethrow;
      }
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
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in trainer_spell');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('trainer_spell record not found');
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
