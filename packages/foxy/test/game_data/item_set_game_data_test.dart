import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';

void main() {
  test('The DBC definitions match the exact 3.3.5.12340 physical formats', () {
    final itemSet = DbcDefinitions.byTable['dbc_item_set']!;
    expect(itemSet.fileName, 'ItemSet.dbc');
    expect(
      itemSet.schema.format,
      'nssssssssssssssssiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
    );
    expect(itemSet.schema.fields, hasLength(53));

    final skillLine = DbcDefinitions.byTable['dbc_skill_line']!;
    expect(skillLine.fileName, 'SkillLine.dbc');
    expect(skillLine.schema.fields, hasLength(56));
  });
}
