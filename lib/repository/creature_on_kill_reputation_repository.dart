import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureOnKillReputationRepository with RepositoryMixin {
  static const _table = 'creature_onkill_reputation';

  Future<CreatureOnKillReputationEntity?> getCreatureOnKillReputation(
    int creatureID,
  ) async {
    var results = await laconic
        .table(_table)
        .where('creature_id', creatureID)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return CreatureOnKillReputationEntity.fromJson(results.first.toMap());
  }

  Future<CreatureOnKillReputationEntity> createCreatureOnKillReputation([
    int creatureID = 0,
  ]) async {
    return CreatureOnKillReputationEntity(creatureID: creatureID);
  }

  Future<void> storeCreatureOnKillReputation(
    CreatureOnKillReputationEntity rep,
  ) async {
    await laconic.table(_table).insert([rep.toJson()]);
  }

  Future<void> updateCreatureOnKillReputation(
    CreatureOnKillReputationEntity rep,
  ) async {
    var json = rep.toJson();
    json.remove('creature_id');
    await laconic
        .table(_table)
        .where('creature_id', rep.creatureID)
        .update(json);
  }

  Future<void> destroyCreatureOnKillReputation(int creatureID) async {
    await laconic.table(_table).where('creature_id', creatureID).delete();
  }

  Future<void> copyCreatureOnKillReputation(int creatureID) async {
    var source = await getCreatureOnKillReputation(creatureID);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextCreatureId();
    json['creature_id'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveCreatureOnKillReputation(
    CreatureOnKillReputationEntity rep,
  ) async {
    var existing = await getCreatureOnKillReputation(rep.creatureID);
    if (existing != null) {
      await updateCreatureOnKillReputation(rep);
    } else {
      await storeCreatureOnKillReputation(rep);
    }
  }

  Future<int> _getNextCreatureId() async {
    var result = await laconic.table(_table).select([
      'MAX(creature_id) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }
}
