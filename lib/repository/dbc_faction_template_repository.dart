import 'package:foxy/entity/dbc_faction_template_entity.dart';
import 'package:foxy/entity/dbc_faction_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class DbcFactionTemplateRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_faction_template';
  static const _factionTable = 'foxy.dbc_faction';

  Future<void> copyDbcFactionTemplate(int id) async {
    final source = await getDbcFactionTemplate(id);
    if (source == null) return;
    final json = source.toJson();
    json['ID'] = await _getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<int> countDbcFactionTemplates({
    DbcFactionTemplateFilterEntity? filter,
  }) async {
    var builder = laconic.table('$_table AS dft');
    if (filter != null && filter.name.isNotEmpty) {
      builder = _joinFaction(builder);
    }
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<DbcFactionTemplateEntity> createDbcFactionTemplate() async {
    return DbcFactionTemplateEntity(id: await _getNextId());
  }

  Future<void> destroyDbcFactionTemplate(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefDbcFactionTemplateEntity>> getBriefDbcFactionTemplates({
    int page = 1,
    DbcFactionTemplateFilterEntity? filter,
  }) async {
    final offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS dft');
    builder = builder.select([
      'dft.ID',
      'dft.Faction',
      'dft.Flags',
      'dft.FactionGroup',
      'dft.FriendGroup',
      'dft.EnemyGroup',
      'df.Name_lang_zhCN AS FactionNameZhCN',
      'df.Name_lang_enUS AS FactionNameEnUS',
    ]);
    builder = _joinFaction(builder);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('dft.ID');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((row) => BriefDbcFactionTemplateEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<DbcFactionTemplateEntity?> getDbcFactionTemplate(int id) async {
    final results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return DbcFactionTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcFactionTemplateEntity>> getDbcFactionTemplates() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => DbcFactionTemplateEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> saveDbcFactionTemplate(
    DbcFactionTemplateEntity factionTemplate,
  ) async {
    final existing = await getDbcFactionTemplate(factionTemplate.id);
    if (existing == null) {
      await storeDbcFactionTemplate(factionTemplate);
      return;
    }
    await updateDbcFactionTemplate(factionTemplate);
  }

  Future<int> storeDbcFactionTemplate(
    DbcFactionTemplateEntity factionTemplate,
  ) async {
    final json = factionTemplate.toJson();
    final nextId = factionTemplate.id > 0
        ? factionTemplate.id
        : await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateDbcFactionTemplate(
    DbcFactionTemplateEntity factionTemplate,
  ) async {
    final json = factionTemplate.toJson()..remove('ID');
    await laconic.table(_table).where('ID', factionTemplate.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    DbcFactionTemplateFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('dft.ID', filter.id);
    }
    if (filter.faction.isNotEmpty) {
      builder = builder.where('dft.Faction', filter.faction);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.whereAny(
        ['df.Name_lang_zhCN', 'df.Name_lang_enUS'],
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }

  QueryBuilder _joinFaction(QueryBuilder builder) {
    return builder.leftJoin(
      '$_factionTable AS df',
      (join) => join.on('dft.Faction', 'df.ID'),
    );
  }
}
