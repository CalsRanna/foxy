import 'package:foxy/entity/creature_model_info_entity.dart';
import 'package:foxy/entity/creature_model_info_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureModelInfoRepository with RepositoryMixin {
  static const _table = 'creature_model_info';

  Future<List<BriefCreatureModelInfoEntity>> getBriefCreatureModelInfos({
    int page = 1,
    CreatureModelInfoFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'DisplayID',
      'BoundingRadius',
      'CombatReach',
      'Gender',
      'DisplayID_Other_Gender',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('DisplayID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCreatureModelInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<CreatureModelInfoEntity>> getCreatureModelInfos() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureModelInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countCreatureModelInfos({
    CreatureModelInfoFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureModelInfoEntity?> getCreatureModelInfo(int displayId) async {
    var results = await laconic
        .table(_table)
        .where('DisplayID', displayId)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return CreatureModelInfoEntity.fromJson(results.first.toMap());
  }

  Future<CreatureModelInfoEntity> createCreatureModelInfo() async {
    return const CreatureModelInfoEntity();
  }

  Future<int> storeCreatureModelInfo(CreatureModelInfoEntity info) async {
    var json = info.toJson();
    var nextId = await _getNextDisplayId();
    json['DisplayID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateCreatureModelInfo(CreatureModelInfoEntity info) async {
    var json = info.toJson();
    json.remove('DisplayID');
    await laconic
        .table(_table)
        .where('DisplayID', info.displayId)
        .update(json);
  }

  Future<void> destroyCreatureModelInfo(int displayId) async {
    await laconic.table(_table).where('DisplayID', displayId).delete();
  }

  Future<void> copyCreatureModelInfo(int displayId) async {
    var source = await getCreatureModelInfo(displayId);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextDisplayId();
    json['DisplayID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveCreatureModelInfo(CreatureModelInfoEntity info) async {
    if (info.displayId == 0) {
      await storeCreatureModelInfo(info);
      return;
    }
    var existing = await getCreatureModelInfo(info.displayId);
    if (existing != null) {
      await updateCreatureModelInfo(info);
    } else {
      await laconic.table(_table).insert([info.toJson()]);
    }
  }

  Future<int> _getNextDisplayId() async {
    var result = await laconic.table(_table).select([
      'MAX(DisplayID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureModelInfoFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('DisplayID', filter.id);
    }
    return builder;
  }
}