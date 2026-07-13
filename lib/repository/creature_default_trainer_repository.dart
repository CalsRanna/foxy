import 'package:foxy/entity/creature_default_trainer_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureDefaultTrainerRepository with RepositoryMixin {
  static const _table = 'creature_default_trainer';

  Future<CreatureDefaultTrainerEntity?> getCreatureDefaultTrainer(
    int creatureId,
  ) async {
    var results = await laconic
        .table(_table)
        .where('CreatureId', creatureId)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return CreatureDefaultTrainerEntity.fromJson(results.first.toMap());
  }

  Future<CreatureDefaultTrainerEntity> createCreatureDefaultTrainer(
    int creatureId,
  ) async {
    return CreatureDefaultTrainerEntity(creatureId: creatureId);
  }

  Future<void> storeCreatureDefaultTrainer(
    CreatureDefaultTrainerEntity relation,
  ) async {
    await laconic.table(_table).insert([relation.toJson()]);
  }

  Future<void> updateCreatureDefaultTrainer(
    CreatureDefaultTrainerEntity relation,
  ) async {
    var json = relation.toJson()..remove('CreatureId');
    await laconic
        .table(_table)
        .where('CreatureId', relation.creatureId)
        .update(json);
  }

  Future<void> destroyCreatureDefaultTrainer(int creatureId) async {
    await laconic.table(_table).where('CreatureId', creatureId).delete();
  }

  Future<void> saveCreatureDefaultTrainer(
    CreatureDefaultTrainerEntity relation,
  ) async {
    final existing = await getCreatureDefaultTrainer(relation.creatureId);
    if (existing == null) {
      await storeCreatureDefaultTrainer(relation);
    } else {
      await updateCreatureDefaultTrainer(relation);
    }
  }
}
