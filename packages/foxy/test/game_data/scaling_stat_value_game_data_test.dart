import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';

void main() {
  test(
    'The DBC definition matches the 24-column 3.3.5.12340 physical format',
    () {
      final definition = DbcDefinitions.byTable['dbc_scaling_stat_values']!;
      expect(definition.fileName, 'ScalingStatValues.dbc');
      expect(definition.schema.format, 'niiiiiiiiiiiiiiiiiiiiiii');
      expect(definition.schema.fields, hasLength(24));
    },
  );
}
