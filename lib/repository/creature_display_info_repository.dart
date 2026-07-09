import 'package:foxy/entity/creature_display_info_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureDisplayInfoRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_creature_display_info';
  static const _modelDataTable = 'foxy.dbc_creature_model_data';

  Future<List<BriefCreatureDisplayInfoEntity>> getBriefCreatureDisplayInfos({
    int page = 1,
    String? id,
    String? modelName,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS cdi');
    builder = builder.select([
      'cdi.ID',
      'cdi.ModelID',
      'cdi.CreatureModelScale',
      'cdi.SizeClass',
      'cdi.BloodID',
      'cmd.ModelName',
    ]);
    builder = _joinModelData(builder);
    builder = _applyFilter(builder, id: id, modelName: modelName);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCreatureDisplayInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<CreatureDisplayInfoEntity>> getCreatureDisplayInfos() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureDisplayInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countCreatureDisplayInfos({
    String? id,
    String? modelName,
  }) async {
    var builder = laconic.table('$_table AS cdi');
    builder = _joinModelData(builder);
    builder = _applyFilter(builder, id: id, modelName: modelName);
    return builder.count();
  }

  Future<CreatureDisplayInfoEntity?> getCreatureDisplayInfo(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureDisplayInfoEntity.fromJson(results.first.toMap());
  }

  Future<CreatureDisplayInfoEntity> createCreatureDisplayInfo() async {
    return const CreatureDisplayInfoEntity();
  }

  Future<int> storeCreatureDisplayInfo(
    CreatureDisplayInfoEntity info,
  ) async {
    var json = info.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateCreatureDisplayInfo(
    CreatureDisplayInfoEntity info,
  ) async {
    var json = info.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', info.id).update(json);
  }

  Future<void> destroyCreatureDisplayInfo(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyCreatureDisplayInfo(int id) async {
    var source = await getCreatureDisplayInfo(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveCreatureDisplayInfo(CreatureDisplayInfoEntity info) async {
    if (info.id == 0) {
      await storeCreatureDisplayInfo(info);
      return;
    }
    var existing = await getCreatureDisplayInfo(info.id);
    if (existing != null) {
      await updateCreatureDisplayInfo(info);
    } else {
      await laconic.table(_table).insert([info.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _joinModelData(QueryBuilder builder) {
    return builder.leftJoin(
      '$_modelDataTable AS cmd',
      (join) => join.on('cdi.ModelID', 'cmd.ID'),
    );
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder, {
    String? id,
    String? modelName,
  }) {
    if (id != null && id.isNotEmpty) {
      builder = builder.where('cdi.ID', id);
    }
    if (modelName != null && modelName.isNotEmpty) {
      builder = builder.where(
        'cmd.ModelName',
        '%$modelName%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
