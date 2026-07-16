import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureOnKillReputationRepository with RepositoryMixin {
  static const _table = 'creature_onkill_reputation';

  Future<void> copyCreatureOnKillReputation(int creatureID) async {
    var source = await getCreatureOnKillReputation(creatureID);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await nextMaxPlusOne(_table, 'creature_id');
    json['creature_id'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countCreatureOnKillReputations() async {
    return laconic.table(_table).count();
  }

  Future<CreatureOnKillReputationEntity> createCreatureOnKillReputation([
    int creatureID = 0,
  ]) async {
    return CreatureOnKillReputationEntity(creatureID: creatureID);
  }

  Future<void> destroyCreatureOnKillReputation(int creatureID) async {
    await laconic.table(_table).where('creature_id', creatureID).delete();
  }

  Future<List<BriefCreatureOnKillReputationEntity>>
  getBriefCreatureOnKillReputations({int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'creature_id',
      'RewOnKillRepFaction1',
      'RewOnKillRepFaction2',
      'RewOnKillRepValue1',
      'RewOnKillRepValue2',
      'TeamDependent',
    ]);
    builder = builder.orderBy('creature_id');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCreatureOnKillReputationEntity.fromJson(e.toMap()))
        .toList();
  }

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

  Future<List<CreatureOnKillReputationEntity>>
  getCreatureOnKillReputations() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureOnKillReputationEntity.fromJson(e.toMap()))
        .toList();
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
}
