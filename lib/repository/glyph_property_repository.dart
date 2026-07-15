import 'package:foxy/constant/glyph_property_constants.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/entity/glyph_property_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GlyphPropertyRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_glyph_properties';

  Future<List<BriefGlyphPropertyEntity>> getBriefGlyphProperties({
    int page = 1,
    GlyphPropertyFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'SpellID', 'GlyphSlotFlags', 'SpellIconID'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefGlyphPropertyEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GlyphPropertyEntity>> getGlyphProperties() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => GlyphPropertyEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countGlyphProperties({GlyphPropertyFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<GlyphPropertyEntity?> getGlyphProperty(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return GlyphPropertyEntity.fromJson(results.first.toMap());
  }

  Future<GlyphPropertyEntity> createGlyphProperty() async {
    return GlyphPropertyEntity(id: await _getNextId());
  }

  Future<int> storeGlyphProperty(GlyphPropertyEntity glyphProperty) async {
    final id = glyphProperty.id > 0 ? glyphProperty.id : await _getNextId();
    final stored = glyphProperty.copyWith(id: id);
    await _validateReferences(stored, preserveExisting: false);
    await laconic.table(_table).insert([stored.toJson()]);
    return id;
  }

  Future<void> updateGlyphProperty(GlyphPropertyEntity glyphProperty) async {
    await _validateReferences(glyphProperty, preserveExisting: true);
    final json = glyphProperty.toJson()..remove('ID');
    await laconic.table(_table).where('ID', glyphProperty.id).update(json);
  }

  Future<void> destroyGlyphProperty(int id) async {
    final spellReferences = await _countSpellReferences(id);
    final characterReferences = await _countCharacterReferences(id);
    final references = spellReferences + characterReferences;
    if (references > 0) {
      throw StateError('雕文属性 $id 仍被 $references 条法术或角色雕文数据引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyGlyphProperty(int id) async {
    var source = await getGlyphProperty(id);
    if (source == null) return;
    await storeGlyphProperty(source.copyWith(id: await _getNextId()));
  }

  Future<void> saveGlyphProperty(GlyphPropertyEntity glyphProperty) async {
    final existing = glyphProperty.id == 0
        ? null
        : await getGlyphProperty(glyphProperty.id);
    if (existing == null) {
      await storeGlyphProperty(glyphProperty);
    } else {
      await updateGlyphProperty(glyphProperty);
    }
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0xffff) {
      throw StateError('GlyphProperties ID 已超出角色数据和客户端协议的 uint16 范围');
    }
    return id;
  }

  Future<void> _validateReferences(
    GlyphPropertyEntity glyphProperty, {
    required bool preserveExisting,
  }) async {
    final existing = preserveExisting
        ? await getGlyphProperty(glyphProperty.id)
        : null;
    await _validateReference(
      table: 'foxy.dbc_spell',
      value: glyphProperty.spellId,
      existingValue: existing?.spellId,
      field: 'SpellID',
      target: '法术',
      allowZero: false,
    );
    await _validateReference(
      table: 'foxy.dbc_spell_icon',
      value: glyphProperty.spellIconId,
      existingValue: existing?.spellIconId,
      field: 'SpellIconID',
      target: '法术图标',
      allowZero: true,
    );
    if (!kGlyphPropertySlotTypeOptions.containsKey(
          glyphProperty.glyphSlotFlags,
        ) &&
        existing?.glyphSlotFlags != glyphProperty.glyphSlotFlags) {
      throw StateError('GlyphSlotFlags 必须是 0（小型雕文）或 1（大型雕文）');
    }
  }

  Future<void> _validateReference({
    required String table,
    required int value,
    required int? existingValue,
    required String field,
    required String target,
    required bool allowZero,
  }) async {
    if (value == 0) {
      if (allowZero || existingValue == 0) return;
      throw StateError('$field 必须引用存在的$target');
    }
    final references = await laconic.table(table).where('ID', value).count();
    if (references > 0 || existingValue == value) return;
    throw StateError('$field 引用的$target $value 不存在');
  }

  Future<int> _countSpellReferences(int id) async {
    final effect0 = await laconic
        .table('foxy.dbc_spell')
        .where('Effect0', kApplyGlyphSpellEffect)
        .where('EffectMiscValue0', id)
        .count();
    final effect1 = await laconic
        .table('foxy.dbc_spell')
        .where('Effect1', kApplyGlyphSpellEffect)
        .where('EffectMiscValue1', id)
        .count();
    final effect2 = await laconic
        .table('foxy.dbc_spell')
        .where('Effect2', kApplyGlyphSpellEffect)
        .where('EffectMiscValue2', id)
        .count();
    return effect0 + effect1 + effect2;
  }

  Future<int> _countCharacterReferences(int id) async {
    final schemas = await laconic.select('''
SELECT DISTINCT TABLE_SCHEMA
FROM information_schema.COLUMNS
WHERE TABLE_NAME = 'character_glyphs'
  AND COLUMN_NAME IN ('glyph1', 'glyph2', 'glyph3', 'glyph4', 'glyph5', 'glyph6')
GROUP BY TABLE_SCHEMA
HAVING COUNT(DISTINCT COLUMN_NAME) = 6
''');
    var references = 0;
    for (final row in schemas) {
      final schema = row['TABLE_SCHEMA'] as String;
      if (!RegExp(r'^[0-9A-Za-z_$]+$').hasMatch(schema)) continue;
      references += await laconic
          .table('$schema.character_glyphs')
          .where('glyph1', id)
          .orWhere('glyph2', id)
          .orWhere('glyph3', id)
          .orWhere('glyph4', id)
          .orWhere('glyph5', id)
          .orWhere('glyph6', id)
          .count();
    }
    return references;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    GlyphPropertyFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
