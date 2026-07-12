import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/area_table_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class AreaTableRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_area_table';

  @override
  String get dbcLocaleTableName => _table;

  Future<List<BriefAreaTableEntity>> getBriefAreaTables({
    int page = 1,
    AreaTableFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'AreaName_lang_zhCN',
      'ContinentID',
      'MinElevation',
      'ZoneMusic',
      'ExplorationLevel',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefAreaTableEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<AreaTableEntity>> getAreaTables() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => AreaTableEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countAreaTables({AreaTableFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<AreaTableEntity?> getAreaTable(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return AreaTableEntity.fromJson(results.first.toMap());
  }

  Future<AreaTableEntity> createAreaTable() async {
    return const AreaTableEntity();
  }

  Future<int> storeAreaTable(AreaTableEntity area) async {
    var json = area.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateAreaTable(AreaTableEntity area) async {
    var json = area.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', area.id).update(json);
  }

  Future<void> destroyAreaTable(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyAreaTable(int id) async {
    var source = await getAreaTable(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveAreaTable(AreaTableEntity area) async {
    if (area.id == 0) {
      await storeAreaTable(area);
      return;
    }
    var existing = await getAreaTable(area.id);
    if (existing != null) {
      await updateAreaTable(area);
    } else {
      await laconic.table(_table).insert([area.toJson()]);
    }
  }

  Future<List<DbcLocaleFieldValue>> getAreaTableLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveAreaTableLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    AreaTableFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'AreaName_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}