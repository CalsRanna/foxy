import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';

void main() {
  test('DBC definition 使用 3.3.5.12340 的 4 列物理格式', () {
    final definition = DbcDefinitions.byTable['dbc_glyph_properties']!;
    expect(definition.fileName, 'GlyphProperties.dbc');
    expect(definition.schema.format, 'niii');
    expect(definition.schema.fields, hasLength(4));
  });
}
