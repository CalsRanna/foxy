import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_focus_object_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_focus_object_repository.g.dart';

@FoxyRepository(SpellFocusObjectEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class SpellFocusObjectRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _SpellFocusObjectRepositoryMixin {
  static const _table = 'foxy.dbc_spell_focus_object';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copySpellFocusObject(int key) async {
    final source = await getSpellFocusObject(key);
    if (source == null) {
      throw StateError('原法术焦点不存在，可能已被其他操作修改或删除');
    }
    final copied = SpellFocusObjectEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeSpellFocusObject(copied);
    return copied.id;
  }

  Future<int> countSpellFocusObjects({SpellFocusObjectFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<SpellFocusObjectEntity> createSpellFocusObject() async =>
      SpellFocusObjectEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<BriefSpellFocusObjectEntity>> getBriefSpellFocusObjects({
    int page = 1,
    SpellFocusObjectFilter? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select(['ID', 'Name_lang_zhCN', 'Name_lang_enUS']),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefSpellFocusObjectEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<DbcLocaleFieldValue>> getSpellFocusObjectLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<SpellFocusObjectEntity>> getSpellFocusObjects() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => SpellFocusObjectEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> saveSpellFocusObjectLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeSpellFocusObject(SpellFocusObjectEntity entity) async {
    if (entity.id <= 0) {
      throw StateError('法术焦点 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('法术焦点 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellFocusObjectFilter? filter,
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
