import 'package:flutter_test/flutter_test.dart';
import 'support/entity_validation_test_extensions.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/gem_property_constants.dart';
import 'package:foxy/entity/gem_property_entity.dart';

void main() {
  test('Entity 精确覆盖 GemProperties.dbc 的 5 个物理列', () {
    final json = const GemPropertyEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'Enchant_ID',
      'Maxcount_inv',
      'Maxcount_item',
      'Type',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('颜色值使用 GemProperties 专属 SocketColor 组合', () {
    expect(kGemPropertyColorOptions.keys.toSet(), {
      0x01,
      0x02,
      0x04,
      0x08,
      0x06,
      0x0a,
      0x0c,
      0x0e,
    });
    expect(kGemPropertyColorOptions, containsPair(0x01, '多彩'));
    expect(kGemPropertyColorOptions, containsPair(0x06, '橙色（红色 + 黄色）'));
    expect(kGemPropertyColorOptions, containsPair(0x0e, '棱彩（红色 + 黄色 + 蓝色）'));
    expect(kGemPropertyColorOptions, isNot(contains(0)));
    expect(kGemPropertyColorOptions, isNot(contains(3)));
    expect(kGemPropertyColorOptions, isNot(contains(15)));
  });

  test('校验允许零附魔和客户端计数列并拒绝非法颜色和值域', () {
    expect(
      const GemPropertyEntity(
        id: 2,
        enchantId: 0,
        maxCountInv: 1,
        maxCountItem: 0,
        type: 2,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const GemPropertyEntity(id: 1, type: 0).validate(),
      throwsArgumentError,
    );
    expect(
      () => const GemPropertyEntity(id: 1, type: 3).validate(),
      throwsArgumentError,
    );
    expect(
      () => const GemPropertyEntity(id: 1, maxCountInv: -1, type: 2).validate(),
      throwsArgumentError,
    );
  });

  test('DBC definition 使用 3.3.5.12340 的 5 列物理格式', () {
    final definition = dbcDefinitionByTable['dbc_gem_properties']!;
    expect(definition.fileName, 'GemProperties.dbc');
    expect(definition.schema.format, 'niiii');
    expect(definition.schema.fields, hasLength(5));
  });
}
