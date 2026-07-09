import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class NpcTrainerRepository with RepositoryMixin {
  static const _table = 'npc_trainer';

  Future<List<BriefNpcTrainerEntity>> getBriefNpcTrainers(int id) async {
    var builder = laconic.table('$_table AS nt');
    const fields = [
      'nt.*',
      'ds.Name_lang_zhCN as spellName',
      'ds.NameSubtext_lang_zhCN as spellSubtext',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'foxy.dbc_spell AS ds',
      (join) => join.on('nt.SpellID', 'ds.ID'),
    );
    builder = builder.where('nt.ID', id);
    builder = builder.orderBy('nt.SpellID');
    var results = await builder.get();
    return results
        .map((e) => BriefNpcTrainerEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<NpcTrainerEntity?> getNpcTrainer(int id, int spellID) async {
    var results = await laconic
        .table(_table)
        .where('ID', id)
        .where('SpellID', spellID)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return NpcTrainerEntity.fromJson(results.first.toMap());
  }

  Future<NpcTrainerEntity> createNpcTrainer(int id) async {
    return NpcTrainerEntity(id: id);
  }

  Future<void> storeNpcTrainer(NpcTrainerEntity trainer) async {
    await laconic.table(_table).insert([trainer.toJson()]);
  }

  Future<void> updateNpcTrainer(
    int id,
    int spellID,
    NpcTrainerEntity trainer,
  ) async {
    var json = trainer.toJson();
    json.remove('ID');
    json.remove('SpellID');
    await laconic
        .table(_table)
        .where('ID', id)
        .where('SpellID', spellID)
        .update(json);
  }

  Future<void> destroyNpcTrainer(int id, int spellID) async {
    await laconic
        .table(_table)
        .where('ID', id)
        .where('SpellID', spellID)
        .delete();
  }

  Future<void> copyNpcTrainer(int id, int spellID) async {
    var source = await getNpcTrainer(id, spellID);
    if (source == null) return;
    var maxSpellResult = await laconic
        .table(_table)
        .select(['MAX(SpellID) AS maxSpellID'])
        .where('ID', id)
        .first();
    var maxSpellID = (maxSpellResult.toMap()['maxSpellID'] ?? 0) as int;
    var json = source.toJson();
    json['SpellID'] = maxSpellID + 1;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveNpcTrainer(NpcTrainerEntity trainer) async {
    var existing = await getNpcTrainer(trainer.id, trainer.spellID);
    if (existing != null) {
      await updateNpcTrainer(trainer.id, trainer.spellID, trainer);
    } else {
      await storeNpcTrainer(trainer);
    }
  }
}
