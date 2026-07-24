import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class NpcTrainerRepository with RepositoryMixin {
  static const _table = 'trainer_spell';
  static const primaryKeyColumns = {'TrainerId', 'SpellId'};

  Future<int> countNpcTrainers(int trainerId) {
    return laconic.table(_table).where('TrainerId', trainerId).count();
  }

  Future<NpcTrainerEntity> createNpcTrainer(int trainerId) async {
    return NpcTrainerEntity(trainerId: trainerId);
  }

  Future<void> destroyNpcTrainer(NpcTrainerKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefNpcTrainerEntity>> getBriefNpcTrainers(
    int trainerId, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table AS ts');
    builder = builder.select([
      'ts.TrainerId',
      'ts.SpellId',
      'ts.MoneyCost',
      'ts.ReqSkillLine',
      'ts.ReqLevel',
      'ds.Name_lang_zhCN as spellName',
      'ds.NameSubtext_lang_zhCN as spellSubtext',
    ]);
    builder = builder.leftJoin(
      'foxy.dbc_spell AS ds',
      (join) => join.on('ts.SpellId', 'ds.ID'),
    );
    builder = builder.where('ts.TrainerId', trainerId);
    builder = builder.orderBy('ts.SpellId');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefNpcTrainerEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<NpcTrainerEntity?> getNpcTrainer(NpcTrainerKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return NpcTrainerEntity.fromJson(results.first.toMap());
  }

  Future<void> storeNpcTrainer(NpcTrainerEntity trainer) async {
    try {
      await laconic.table(_table).insert([trainer.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('训练师技能主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateNpcTrainer(
    NpcTrainerKey originalKey,
    NpcTrainerEntity trainer,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(trainer.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, NpcTrainerKey key) {
    return builder
        .where('TrainerId', key.trainerId)
        .where('SpellId', key.spellId);
  }
}
