import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/glyph_property_constants.dart';
import 'package:foxy/entity/glyph_property_entity.dart';

void main() {
  test('Entity 精确覆盖 GlyphProperties.dbc 的 4 个标量物理列', () {
    final json = const GlyphPropertyEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'SpellID',
      'GlyphSlotFlags',
      'SpellIconID',
    ]);
    expect(json.values, everyElement(isA<int>()));
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('雕文类型使用 GlyphProperties/GlyphSlot 专属 0 和 1', () {
    expect(kGlyphPropertySlotTypeOptions, {0: '小型雕文', 1: '大型雕文'});
    expect(kGlyphPropertySlotTypeOptions, isNot(contains(2)));
    expect(kApplyGlyphSpellEffect, 74);
  });

  test('DBC definition 使用 3.3.5.12340 的 4 列物理格式', () {
    final definition = dbcDefinitionByTable['dbc_glyph_properties']!;
    expect(definition.fileName, 'GlyphProperties.dbc');
    expect(definition.schema.format, 'niii');
    expect(definition.schema.fields, hasLength(4));
  });
}
