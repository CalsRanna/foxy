import 'package:foxy/entity/creature_display_info_entity.dart';
import 'package:foxy/entity/creature_display_info_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureDisplayInfoRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_creature_display_info';
  static const _modelDataTable = 'foxy.dbc_creature_model_data';

  Future<void> copyCreatureDisplayInfo(int id) async {
    var source = await getCreatureDisplayInfo(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await nextMaxPlusOne(_table, 'ID');
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countCreatureDisplayInfos({
    CreatureDisplayInfoFilterEntity? filter,
  }) async {
    final needsModelJoin = filter != null && filter.modelName.isNotEmpty;
    if (!needsModelJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.id.isNotEmpty) {
        builder = builder.where('ID', filter.id);
      }
      return builder.count();
    }
    var builder = laconic.table('$_table AS cdi');
    builder = _joinModelData(builder);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureDisplayInfoEntity> createCreatureDisplayInfo() async {
    return CreatureDisplayInfoEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyCreatureDisplayInfo(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefCreatureDisplayInfoEntity>> getBriefCreatureDisplayInfos({
    int page = 1,
    CreatureDisplayInfoFilterEntity? filter,
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
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('cdi.ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCreatureDisplayInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureDisplayInfoEntity?> getCreatureDisplayInfo(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureDisplayInfoEntity.fromJson(results.first.toMap());
  }

  Future<List<CreatureDisplayInfoEntity>> getCreatureDisplayInfos() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureDisplayInfoEntity.fromJson(e.toMap()))
        .toList();
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

  Future<int> storeCreatureDisplayInfo(CreatureDisplayInfoEntity info) async {
    var json = info.toJson();
    final nextId = info.id > 0 ? info.id : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateCreatureDisplayInfo(CreatureDisplayInfoEntity info) async {
    var json = info.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', info.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureDisplayInfoFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('cdi.ID', filter.id);
    }
    if (filter.modelName.isNotEmpty) {
      builder = builder.where(
        'cmd.ModelName',
        '%${filter.modelName}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _joinModelData(QueryBuilder builder) {
    return builder.leftJoin(
      '$_modelDataTable AS cmd',
      (join) => join.on('cdi.ModelID', 'cmd.ID'),
    );
  }
}
