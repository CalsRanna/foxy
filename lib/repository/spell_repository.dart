import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'SpellFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'name',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class SpellRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_spell';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copySpell(int key) async {
    final source = await getSpell(key);
    if (source == null) {
      throw StateError('原法术不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeSpell(copied);
    return copied.id;
  }

  Future<int> countSpells({SpellFilter? filter}) async {
    var builder = laconic.table('$_table AS ds');
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellEntity> createSpell() async {
    return SpellEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroySpell(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原法术不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSpellEntity>> getBriefSpells({
    int page = 1,
    SpellFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS ds');
    const fields = [
      'ds.ID',
      'ds.Name_lang_enUS AS name',
      'ds.NameSubtext_lang_enUS AS subtext',
      'ds.Name_lang_zhCN AS localeName',
      'ds.NameSubtext_lang_zhCN AS localeSubtext',
      'ds.Description_lang_enUS AS description',
      'ds.Description_lang_zhCN AS localeDescription',
      'ds.AuraDescription_lang_enUS AS auraDescription',
      'ds.AuraDescription_lang_zhCN AS localeAuraDescription',
      'dsi.TextureFilename AS textureFilename',
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

  Future<SpellEntity?> getSpell(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
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

  Future<void> saveSpellLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeSpell(SpellEntity spell) async {
    if (spell.id <= 0) {
      throw StateError('法术 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([spell.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('法术 ${spell.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateSpell(int originalKey, SpellEntity spell) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(spell.toJson());
      if (matchedRows == 0) {
        throw StateError('原法术不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的法术 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, SpellFilter? filter) {
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
