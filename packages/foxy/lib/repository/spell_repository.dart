import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name', column: 'ds.Name_lang_zhCN')
class SpellRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _SpellRepositoryMixin {
  @override
  String get dbcLocaleTableName => _table;

  @override
  Future<int> copySpell(int key) async {
    final source = await getSpell(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeSpell(copied);
    return copied.id;
  }

  @override
  Future<int> countSpells({SpellFilter? filter}) async {
    var builder = laconic.table('$_table as ds');
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  @override
  Future<SpellEntity> createSpell() async {
    return SpellEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  @override
  Future<List<BriefSpellEntity>> getBriefSpells({
    int page = 1,
    SpellFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table as ds');
    const fields = [
      'ds.ID',
      'ds.Name_lang_enUS as name',
      'ds.NameSubtext_lang_enUS as subtext',
      'ds.Name_lang_zhCN as localeName',
      'ds.NameSubtext_lang_zhCN as localeSubtext',
      'ds.Description_lang_enUS as description',
      'ds.Description_lang_zhCN as localeDescription',
      'ds.AuraDescription_lang_enUS as auraDescription',
      'ds.AuraDescription_lang_zhCN as localeAuraDescription',
      'dsi.TextureFilename as textureFilename',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'foxy.dbc_spell_duration as dsd',
      (join) => join.on('ds.DurationIndex', 'dsd.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_icon as dsi',
      (join) => join.on('ds.SpellIconID', 'dsi.ID'),
    );
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefSpellEntity.fromJson(e.toMap())).toList();
  }

  @override
  Future<List<SpellEntity>> getSpells() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SpellEntity.fromJson(e.toMap())).toList();
  }

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, SpellFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ds.ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.whereAny(
        ['ds.Name_lang_zhCN', 'ds.Name_lang_enUS'],
        '%${ParseUtil.escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
