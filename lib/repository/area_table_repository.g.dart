// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_table_repository.dart';

final class AreaTableFilter {
  final String id;
  final String name;

  const AreaTableFilter({this.id = '', this.name = ''});

  factory AreaTableFilter.fromJson(Map<String, dynamic> json) {
    return AreaTableFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  AreaTableFilter copyWith({String? id, String? name}) {
    return AreaTableFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _AreaTableRepositoryMixin on RepositoryMixin {
  Future<int> copyAreaTable(int key) async {
    final source = await getAreaTable(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createAreaTable();
    final copied = source.copyWith(id: blank.id);
    await storeAreaTable(copied);
    return copied.id;
  }

  Future<int> countAreaTables({AreaTableFilter? filter}) async {
    return _applyFilter(laconic.table('foxy.dbc_area_table'), filter).count();
  }

  Future<AreaTableEntity> createAreaTable() async {
    return AreaTableEntity(
      id: await nextMaxPlusOne('foxy.dbc_area_table', '`ID`'),
    );
  }

  Future<void> destroyAreaTable(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_area_table'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<AreaTableEntity?> getAreaTable(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_area_table'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return AreaTableEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefAreaTableEntity>> getBriefAreaTables({
    int page = 1,
    AreaTableFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_area_table').select([
      '`ID`',
      '`ContinentID`',
      '`ZoneMusic`',
      '`ExplorationLevel`',
      '`AreaName_lang_zhCN`',
      '`MinElevation`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefAreaTableEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<AreaTableEntity>> getAreaTables() async {
    var builder = laconic.table('foxy.dbc_area_table').orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => AreaTableEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeAreaTable(AreaTableEntity areaTable) async {
    if (areaTable.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(areaTable);
    final json = prepareWriteJson(areaTable.toJson());
    try {
      await laconic.table('foxy.dbc_area_table').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateAreaTable(
    int originalKey,
    AreaTableEntity areaTable,
  ) async {
    await _beforeUpdate(originalKey, areaTable);
    final json = prepareWriteJson(areaTable.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_area_table'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, AreaTableFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`AreaName_lang_zhCN`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(AreaTableEntity areaTable) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    AreaTableEntity areaTable,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
