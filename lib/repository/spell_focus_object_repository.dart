import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_focus_object_entity.dart';
import 'package:foxy/entity/spell_focus_object_filter_entity.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellFocusObjectRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_spell_focus_object';

  @override
  String get dbcLocaleTableName => _table;

  Future<List<BriefSpellFocusObjectEntity>> getBriefSpellFocusObjects({
    int page = 1,
    SpellFocusObjectFilterEntity? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select(['ID', 'Name_lang_zhCN', 'Name_lang_enUS']),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefSpellFocusObjectEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<SpellFocusObjectEntity>> getSpellFocusObjects() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => SpellFocusObjectEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<int> countSpellFocusObjects({SpellFocusObjectFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<SpellFocusObjectEntity?> getSpellFocusObject(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty
        ? null
        : SpellFocusObjectEntity.fromJson(rows.first.toMap());
  }

  Future<SpellFocusObjectEntity> createSpellFocusObject() async =>
      SpellFocusObjectEntity(id: await _getNextId());

  Future<int> storeSpellFocusObject(SpellFocusObjectEntity entity) async {
    final json = entity.toJson();
    final id = entity.id > 0 ? entity.id : await _getNextId();
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateSpellFocusObject(SpellFocusObjectEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  Future<void> destroySpellFocusObject(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copySpellFocusObject(int id) async {
    final source = await getSpellFocusObject(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await _getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSpellFocusObject(SpellFocusObjectEntity entity) async {
    if (await getSpellFocusObject(entity.id) == null) {
      await storeSpellFocusObject(entity);
    } else {
      await updateSpellFocusObject(entity);
    }
  }

  Future<List<DbcLocaleFieldValue>> getSpellFocusObjectLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveSpellFocusObjectLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> _getNextId() => nextMaxPlusOne(_table, 'ID');

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellFocusObjectFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.whereAny(
        ['Name_lang_zhCN', 'Name_lang_enUS'],
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
