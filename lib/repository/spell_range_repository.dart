import 'package:foxy/entity/spell_range_entity.dart';
import 'package:foxy/entity/spell_range_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellRangeRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_spell_range';

  @override
  String get dbcLocaleTableName => _table;

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

  Future<List<SpellRangeEntity>> getSpellRanges() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SpellRangeEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countSpellRanges({SpellRangeFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellRangeEntity?> getSpellRange(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return SpellRangeEntity.fromJson(results.first.toMap());
  }

  Future<SpellRangeEntity> createSpellRange() async {
    return const SpellRangeEntity();
  }

  Future<int> storeSpellRange(SpellRangeEntity range) async {
    var json = range.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateSpellRange(SpellRangeEntity range) async {
    var json = range.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', range.id).update(json);
  }

  Future<void> destroySpellRange(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copySpellRange(int id) async {
    var source = await getSpellRange(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSpellRange(SpellRangeEntity range) async {
    if (range.id == 0) {
      await storeSpellRange(range);
      return;
    }
    var existing = await getSpellRange(range.id);
    if (existing != null) {
      await updateSpellRange(range);
    } else {
      await laconic.table(_table).insert([range.toJson()]);
    }
  }

  Future<List<DbcLocaleFieldValue>> getSpellRangeLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveSpellRangeLocales(
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
}
