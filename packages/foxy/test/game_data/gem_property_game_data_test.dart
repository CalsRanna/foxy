import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';

void main() {
  test('The DBC definition matches the five-column 3.3.5.12340 format', () {
    final definition = DbcDefinitions.byTable['dbc_gem_properties']!;
    expect(definition.fileName, 'GemProperties.dbc');
    expect(definition.schema.format, 'niiii');
    expect(definition.schema.fields, hasLength(5));
  });
}
