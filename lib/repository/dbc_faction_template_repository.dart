import 'package:foxy/entity/brief_dbc_faction_template_entity.dart';
import 'package:foxy/entity/dbc_faction_template_entity.dart';
import 'package:foxy/entity/dbc_faction_template_filter_entity.dart';
import 'package:foxy/entity/dbc_faction_template_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class DbcFactionTemplateRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_faction_template';
  static const _factionTable = 'foxy.dbc_faction';

  Future<DbcFactionTemplateKey> copyDbcFactionTemplate(
    DbcFactionTemplateKey key,
  ) async {
    final source = await getDbcFactionTemplate(key);
    if (source == null) {
      throw StateError('原阵营模板不存在，可能已被其他操作修改或删除');
    }
    final copied = DbcFactionTemplateEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeDbcFactionTemplate(copied);
    return DbcFactionTemplateKey.fromEntity(copied);
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
    return DbcFactionTemplateEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyDbcFactionTemplate(DbcFactionTemplateKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原阵营模板不存在，可能已被其他操作修改或删除');
    }
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

  Future<DbcFactionTemplateEntity?> getDbcFactionTemplate(
    DbcFactionTemplateKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return DbcFactionTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcFactionTemplateEntity>> getDbcFactionTemplates() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => DbcFactionTemplateEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeDbcFactionTemplate(
    DbcFactionTemplateEntity factionTemplate,
  ) async {
    if (factionTemplate.id <= 0) {
      throw StateError('阵营模板 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([factionTemplate.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('阵营模板 ${factionTemplate.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateDbcFactionTemplate(
    DbcFactionTemplateKey originalKey,
    DbcFactionTemplateEntity factionTemplate,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(factionTemplate.toJson());
      if (matchedRows == 0) {
        throw StateError('原阵营模板不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的阵营模板 ID 已存在，无法保存');
      }
      rethrow;
    }
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

  QueryBuilder _joinFaction(QueryBuilder builder) {
    return builder.leftJoin(
      '$_factionTable AS df',
      (join) => join.on('dft.Faction', 'df.ID'),
    );
  }

  QueryBuilder _whereKey(QueryBuilder builder, DbcFactionTemplateKey key) {
    return builder.where('ID', key.id);
  }
}
