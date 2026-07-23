import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

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

  test('Entity 校验 uint16 ID 和镜像表非负 int32 物理值域', () {
    expect(
      const GlyphPropertyEntity(
        id: 0xffff,
        spellId: 80877,
        glyphSlotFlags: 162,
        spellIconId: 3312,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const GlyphPropertyEntity(id: 0).validate(),
      throwsArgumentError,
    );
    expect(
      () => const GlyphPropertyEntity(id: 0x10000).validate(),
      throwsArgumentError,
    );
    expect(
      () => const GlyphPropertyEntity(id: 1, spellId: -1).validate(),
      throwsArgumentError,
    );
  });

  test('详情页使用法术/图标 Picker 和专属类型下拉且一行四列等宽', () {
    final view = File(
      'lib/page/glyph_property/glyph_property_view.dart',
    ).readAsStringSync();
    expect(view, contains('FoxyEntityPickerDelegates.spell,'));
    expect(view, contains('FoxyEntityPickerDelegates.spellIcon,'));
    expect(view, contains('kGlyphPropertySlotTypeOptions'));
    expect(view, contains('FoxyIntShadSelect('));
    expect('Expanded(child:'.allMatches(view), hasLength(4));
    expect(view, isNot(contains('FoxyFlagPicker')));
    expect(view, isNot(contains('flex:')));
  });

  test('Repository 使用原始键、完整 candidate 和单表边界', () {
    final repository = File(
      'lib/repository/glyph_property_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/glyph_property/glyph_property_detail_view_model.dart',
    ).readAsStringSync();
    expect(repository, contains('glyphProperty.id <= 0'));
    expect(repository, isNot(contains('.validate()')));
    expect(viewModel, contains('validateGlyphPropertyFields(candidate);'));
    expect(repository, contains('int originalKey'));
    expect(repository, contains('.update(glyphProperty.toJson())'));
    expect(repository, contains('matchedRows == 0'));
    expect(repository, contains('deletedRows == 0'));
    expect(repository, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(repository, isNot(contains("table('foxy.dbc_spell')")));
    expect(repository, isNot(contains('character_glyphs')));
    expect(repository, isNot(contains("remove('ID')")));
  });

  test('详情使用 persistedKey 区分增改并在成功后切换身份', () {
    final viewModel = File(
      'lib/page/glyph_property/glyph_property_detail_view_model.dart',
    ).readAsStringSync();
    final page = File(
      'lib/page/glyph_property/glyph_property_detail_page.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/glyph_property/glyph_property_view.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/glyph_property/glyph_property_list_page.dart',
    ).readAsStringSync();
    expect(viewModel, contains('signal<int?>(null)'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(viewModel, contains('updateGlyphProperty(originalKey, candidate)'));
    expect(viewModel, contains('persistedKey.value = candidate.id'));
    expect(viewModel, isNot(contains('getGlyphProperty(candidate.id)')));
    expect(page, contains('final int? glyphPropertyKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(view, isNot(contains('readOnly: true')));
    expect(list, contains('items[row].key'));
  });

  test('DBC definition 使用 3.3.5.12340 的 4 列物理格式', () {
    final definition = dbcDefinitionByTable['dbc_glyph_properties']!;
    expect(definition.fileName, 'GlyphProperties.dbc');
    expect(definition.schema.format, 'niii');
    expect(definition.schema.fields, hasLength(4));
  });
}
