import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/gem_property_constants.dart';

void main() {

  test('颜色值使用 GemProperties 专属 SocketColor 组合', () {
    expect(GemPropertyConstants.gemPropertyColorOptions.keys.toSet(), {
      0x01,
      0x02,
      0x04,
      0x08,
      0x06,
      0x0a,
      0x0c,
      0x0e,
    });
    expect(GemPropertyConstants.gemPropertyColorOptions, containsPair(0x01, '多彩'));
    expect(GemPropertyConstants.gemPropertyColorOptions, containsPair(0x06, '橙色（红色 + 黄色）'));
    expect(GemPropertyConstants.gemPropertyColorOptions, containsPair(0x0e, '棱彩（红色 + 黄色 + 蓝色）'));
    expect(GemPropertyConstants.gemPropertyColorOptions, isNot(contains(0)));
    expect(GemPropertyConstants.gemPropertyColorOptions, isNot(contains(3)));
    expect(GemPropertyConstants.gemPropertyColorOptions, isNot(contains(15)));
  });

  test('DBC definition 使用 3.3.5.12340 的 5 列物理格式', () {
    final definition = DbcDefinitions.byTable['dbc_gem_properties']!;
    expect(definition.fileName, 'GemProperties.dbc');
    expect(definition.schema.format, 'niiii');
    expect(definition.schema.fields, hasLength(5));
  });
}
