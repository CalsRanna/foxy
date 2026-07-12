import 'package:foxy/entity/dbc_faction_entity.dart';
import 'package:foxy/entity/dbc_faction_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class DbcFactionRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_faction';

  @override
  String get dbcLocaleTableName => _table;

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

  Future<List<DbcFactionEntity>> getDbcFactions() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => DbcFactionEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countDbcFactions({DbcFactionFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<DbcFactionEntity?> getDbcFaction(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return DbcFactionEntity.fromJson(results.first.toMap());
  }

  Future<DbcFactionEntity> createDbcFaction() async {
    return const DbcFactionEntity();
  }

  Future<int> storeDbcFaction(DbcFactionEntity faction) async {
    var json = faction.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateDbcFaction(DbcFactionEntity faction) async {
    var json = faction.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', faction.id).update(json);
  }

  Future<void> destroyDbcFaction(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyDbcFaction(int id) async {
    var source = await getDbcFaction(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveDbcFaction(DbcFactionEntity faction) async {
    if (faction.id == 0) {
      await storeDbcFaction(faction);
      return;
    }
    var existing = await getDbcFaction(faction.id);
    if (existing != null) {
      await updateDbcFaction(faction);
    } else {
      await laconic.table(_table).insert([faction.toJson()]);
    }
  }

  Future<List<DbcLocaleFieldValue>> getDbcFactionLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveDbcFactionLocales(
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
}
