import 'package:foxy/entity/dbc_faction_entity.dart';
import 'package:foxy/entity/dbc_faction_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class DbcFactionRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_faction';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyDbcFaction(int key) async {
    final source = await getDbcFaction(key);
    if (source == null) {
      throw StateError('原阵营不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeDbcFaction(copied);
    return copied.id;
  }

  Future<int> countDbcFactions({DbcFactionFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<DbcFactionEntity> createDbcFaction() async {
    return DbcFactionEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyDbcFaction(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原阵营不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefDbcFactionEntity>> getBriefDbcFactions({
    int page = 1,
    DbcFactionFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'Name_lang_zhCN', 'Description_lang_zhCN']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefDbcFactionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<DbcFactionEntity?> getDbcFaction(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return DbcFactionEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getDbcFactionLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<DbcFactionEntity>> getDbcFactions() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => DbcFactionEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveDbcFactionLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeDbcFaction(DbcFactionEntity faction) async {
    if (faction.id <= 0) {
      throw StateError('阵营 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([faction.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('阵营 ${faction.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateDbcFaction(
    int originalKey,
    DbcFactionEntity faction,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(faction.toJson());
      if (matchedRows == 0) {
        throw StateError('原阵营不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的阵营 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    DbcFactionFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
