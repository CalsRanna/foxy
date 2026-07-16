import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/entity/spell_filter_entity.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_spell';

  @override
  String get dbcLocaleTableName => _table;

  Future<void> copySpell(int id) async {
    var source = await getSpell(id);
    if (source == null) return;
    var json = source.toJson();
    var newId = await nextMaxPlusOne(_table, 'ID');
    json['ID'] = newId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countSpells({SpellFilterEntity? filter}) async {
    var builder = laconic.table('$_table AS ds');
    builder.select(['ds.ID']);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellEntity> createSpell() async {
    return SpellEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroySpell(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefSpellEntity>> getBriefSpells({
    int page = 1,
    SpellFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS ds');
    const fields = [
      'ds.ID',
      'ds.Name_lang_enUS',
      'ds.NameSubtext_lang_enUS',
      'ds.Name_lang_zhCN',
      'ds.NameSubtext_lang_zhCN',
      'ds.Description_lang_enUS',
      'ds.Description_lang_zhCN',
      'ds.AuraDescription_lang_enUS',
      'ds.AuraDescription_lang_zhCN',
      'dsi.TextureFilename',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'foxy.dbc_spell_duration AS dsd',
      (join) => join.on('ds.DurationIndex', 'dsd.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_icon AS dsi',
      (join) => join.on('ds.SpellIconID', 'dsi.ID'),
    );
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefSpellEntity.fromJson(e.toMap())).toList();
  }

  Future<SpellEntity?> getSpell(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return SpellEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getSpellLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<SpellEntity>> getSpells() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SpellEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveSpell(SpellEntity spell) async {
    if (spell.id == 0) {
      await storeSpell(spell);
      return;
    }
    var existing = await getSpell(spell.id);
    if (existing != null) {
      await updateSpell(spell);
    } else {
      await laconic.table(_table).insert([spell.toJson()]);
    }
  }

  Future<void> saveSpellLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeSpell(SpellEntity spell) async {
    var json = spell.toJson();
    final newId = spell.id > 0 ? spell.id : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = newId;
    await laconic.table(_table).insert([json]);
    return newId;
  }

  Future<void> updateSpell(SpellEntity spell) async {
    var json = spell.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', spell.id).update(json);
  }

  QueryBuilder _applyFilter(QueryBuilder builder, SpellFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ds.ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.whereAny(
        ['ds.Name_lang_zhCN', 'ds.Name_lang_enUS'],
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
