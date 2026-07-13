import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class NpcTrainerRepository with RepositoryMixin {
  static const _table = 'trainer_spell';
  static const primaryKeyColumns = {'TrainerId', 'SpellId'};

  Future<List<BriefNpcTrainerEntity>> getBriefNpcTrainers(int trainerId) async {
    var builder = laconic.table('$_table AS ts');
    builder = builder.select([
      'ts.*',
      'ds.Name_lang_zhCN as spellName',
      'ds.NameSubtext_lang_zhCN as spellSubtext',
    ]);
    builder = builder.leftJoin(
      'foxy.dbc_spell AS ds',
      (join) => join.on('ts.SpellId', 'ds.ID'),
    );
    builder = builder.where('ts.TrainerId', trainerId);
    builder = builder.orderBy('ts.SpellId');
    var results = await builder.get();
    return results
        .map((e) => BriefNpcTrainerEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<NpcTrainerEntity?> getNpcTrainer(int trainerId, int spellId) async {
    var results = await laconic
        .table(_table)
        .where('TrainerId', trainerId)
        .where('SpellId', spellId)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return NpcTrainerEntity.fromJson(results.first.toMap());
  }

  Future<NpcTrainerEntity> createNpcTrainer(int trainerId) async {
    return NpcTrainerEntity(trainerId: trainerId);
  }

  Future<void> storeNpcTrainer(NpcTrainerEntity trainer) async {
    await laconic.table(_table).insert([trainer.toJson()]);
  }

  Future<void> updateNpcTrainer(
    int trainerId,
    int spellId,
    NpcTrainerEntity trainer,
  ) async {
    var json = trainer.toJson();
    json.remove('TrainerId');
    json.remove('SpellId');
    await laconic
        .table(_table)
        .where('TrainerId', trainerId)
        .where('SpellId', spellId)
        .update(json);
  }

  Future<void> destroyNpcTrainer(int trainerId, int spellId) async {
    await laconic
        .table(_table)
        .where('TrainerId', trainerId)
        .where('SpellId', spellId)
        .delete();
  }

  Future<void> saveNpcTrainer(NpcTrainerEntity trainer) async {
    var existing = await getNpcTrainer(trainer.trainerId, trainer.spellId);
    if (existing != null) {
      await updateNpcTrainer(trainer.trainerId, trainer.spellId, trainer);
    } else {
      await storeNpcTrainer(trainer);
    }
  }
}
