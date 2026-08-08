import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_on_kill_reputation_repository.g.dart';

@FoxyRepository()
class CreatureOnKillReputationRepository
    with RepositoryMixin, _CreatureOnKillReputationRepositoryMixin {
  static const primaryKeyColumns = {'creature_id'};

  Future<int> copyCreatureOnKillReputation(int sourceKey) async {
    final source = await getCreatureOnKillReputation(sourceKey);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final candidate = source.copyWith(
      creatureID: await nextMaxPlusOne(_table, 'creature_id'),
    );
    await storeCreatureOnKillReputation(candidate);
    return candidate.creatureID;
  }

  Future<int> countCreatureOnKillReputations() {
    return laconic.table(_table).count();
  }

  Future<CreatureOnKillReputationEntity> createCreatureOnKillReputation([
    int creatureID = 0,
  ]) async {
    return CreatureOnKillReputationEntity(creatureID: creatureID);
  }

  Future<List<BriefCreatureOnKillReputationEntity>>
  getBriefCreatureOnKillReputations({int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select([
          'creature_id',
          'RewOnKillRepFaction1',
          'RewOnKillRepFaction2',
          'RewOnKillRepValue1',
          'RewOnKillRepValue2',
          'TeamDependent',
        ])
        .orderBy('creature_id')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map(
          (result) =>
              BriefCreatureOnKillReputationEntity.fromJson(result.toMap()),
        )
        .toList();
  }

  Future<List<CreatureOnKillReputationEntity>>
  getCreatureOnKillReputations() async {
    final results = await laconic.table(_table).get();
    return results
        .map(
          (result) => CreatureOnKillReputationEntity.fromJson(result.toMap()),
        )
        .toList();
  }
}
