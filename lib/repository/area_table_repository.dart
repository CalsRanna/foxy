import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'area_table_repository.g.dart';

@FoxyRepository(AreaTableEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class AreaTableRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _AreaTableRepositoryMixin {
  static const _table = 'foxy.dbc_area_table';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyAreaTable(int key) async {
    final source = await getAreaTable(key);
    if (source == null) {
      throw StateError('原区域不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(
      id: await nextMaxPlusOne(_table, 'ID'),
      areaBit: await nextMaxPlusOne(_table, 'AreaBit'),
    );
    await storeAreaTable(copied);
    return copied.id;
  }

  Future<int> countAreaTables({AreaTableFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<AreaTableEntity> createAreaTable() async {
    return AreaTableEntity(
      id: await nextMaxPlusOne(_table, 'ID'),
      areaBit: await nextMaxPlusOne(_table, 'AreaBit'),
    );
  }

  Future<List<DbcLocaleFieldValue>> getAreaTableLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<AreaTableEntity>> getAreaTables() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => AreaTableEntity.fromJson(e.toMap())).toList();
  }

  Future<List<BriefAreaTableEntity>> getBriefAreaTables({
    int page = 1,
    AreaTableFilter? filter,
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

  Future<bool> isAreaBitAvailable(int areaBit, {int? excludingKey}) async {
    var builder = laconic.table(_table).where('AreaBit', areaBit);
    if (excludingKey != null) {
      builder = builder.where('ID', excludingKey, comparator: '!=');
    }
    final count = await builder.count();
    return count == 0;
  }

  Future<void> saveAreaTableLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeAreaTable(AreaTableEntity area) async {
    if (area.id <= 0) {
      throw StateError('区域 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([area.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('区域 ${area.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, AreaTableFilter? filter) {
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
