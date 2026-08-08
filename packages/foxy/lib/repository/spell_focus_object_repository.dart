import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_focus_object_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_focus_object_repository.g.dart';

@FoxyRepository()
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
      throw RecordNotFoundException('record not found');
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

  Future<List<SpellFocusObjectEntity>> getSpellFocusObjects() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => SpellFocusObjectEntity.fromJson(row.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellFocusObjectFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.whereAny(
        ['Name_lang_zhCN', 'Name_lang_enUS'],
        '%${escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
