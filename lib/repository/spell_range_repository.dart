import 'package:foxy/entity/brief_spell_range_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_range_entity.dart';
import 'package:foxy/entity/spell_range_filter_entity.dart';
import 'package:foxy/entity/spell_range_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellRangeRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_spell_range';

  @override
  String get dbcLocaleTableName => _table;

  Future<SpellRangeKey> copySpellRange(SpellRangeKey key) async {
    final source = await getSpellRange(key);
    if (source == null) {
      throw StateError('原法术射程不存在，可能已被其他操作修改或删除');
    }
    final copied = SpellRangeEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeSpellRange(copied);
    return SpellRangeKey.fromEntity(copied);
  }

  Future<int> countSpellRanges({SpellRangeFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellRangeEntity> createSpellRange() async {
    return SpellRangeEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroySpellRange(SpellRangeKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原法术射程不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSpellRangeEntity>> getBriefSpellRanges({
    int page = 1,
    SpellRangeFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'RangeMin0',
      'RangeMax0',
      'DisplayName_lang_zhCN',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSpellRangeEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<SpellRangeEntity?> getSpellRange(SpellRangeKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellRangeEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getSpellRangeLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<SpellRangeEntity>> getSpellRanges() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SpellRangeEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveSpellRangeLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeSpellRange(SpellRangeEntity range) async {
    if (range.id <= 0) {
      throw StateError('法术射程 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([range.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('法术射程 ${range.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateSpellRange(
    SpellRangeKey originalKey,
    SpellRangeEntity range,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(range.toJson());
      if (matchedRows == 0) {
        throw StateError('原法术射程不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的法术射程 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellRangeFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'DisplayName_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, SpellRangeKey key) {
    return builder.where('ID', key.id);
  }
}
