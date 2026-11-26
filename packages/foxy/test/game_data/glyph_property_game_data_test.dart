import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';

void main() {
  test('The DBC definition matches the four-column 3.3.5.12340 format', () {
    final definition = DbcDefinitions.byTable['dbc_glyph_properties']!;
    expect(definition.fileName, 'GlyphProperties.dbc');
    expect(definition.schema.format, 'niii');
    expect(definition.schema.fields, hasLength(4));
  });
}
