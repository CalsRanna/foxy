import 'package:foxy/entity/brief_creature_on_kill_reputation_entity.dart';
import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureOnKillReputationRepository with RepositoryMixin {
  static const _table = 'creature_onkill_reputation';
  static const primaryKeyColumns = {'creature_id'};

  Future<int> copyCreatureOnKillReputation(int sourceKey) async {
    final source = await getCreatureOnKillReputation(sourceKey);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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

  Future<void> destroyCreatureOnKillReputation(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
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

  Future<CreatureOnKillReputationEntity?> getCreatureOnKillReputation(
    int key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureOnKillReputationEntity.fromJson(results.first.toMap());
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

  Future<void> storeCreatureOnKillReputation(
    CreatureOnKillReputationEntity rep,
  ) async {
    try {
      await laconic.table(_table).insert([rep.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('击杀声望主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureOnKillReputation(
    int originalKey,
    CreatureOnKillReputationEntity rep,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(rep.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的击杀声望主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('creature_id', key);
  }
}
