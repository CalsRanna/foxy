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

mixin _AreaTableRepositoryMixin on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<int> copyAreaTable(int key) async {
    final source = await getAreaTable(key);
    if (source == null) {
      throw RecordNotFoundException('foxy.dbc_area_table record not found');
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
      throw RecordNotFoundException('foxy.dbc_area_table record not found');
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

  Future<List<DbcLocaleFieldValue>> getAreaTableLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveAreaTableLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeAreaTable(AreaTableEntity areaTable) async {
    if (areaTable.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(areaTable);
    final json = prepareWriteJson(areaTable.toJson());
    try {
      await laconic.table('foxy.dbc_area_table').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = areaTable.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_area_table', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_area_table').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_area_table');
        }
        rethrow;
      }
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
        throw DuplicateKeyException('duplicate key in foxy.dbc_area_table');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_area_table record not found');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, AreaTableFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', int.tryParse(filter.id) ?? 0);
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
