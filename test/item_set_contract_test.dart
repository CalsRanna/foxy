import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';

void main() {

  test('DBC definitions 使用 3.3.5.12340 的精确物理格式', () {
    final itemSet = dbcDefinitionByTable['dbc_item_set']!;
    expect(itemSet.fileName, 'ItemSet.dbc');
    expect(
      itemSet.schema.format,
      'nssssssssssssssssiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
    );
    expect(itemSet.schema.fields, hasLength(53));

    final skillLine = dbcDefinitionByTable['dbc_skill_line']!;
    expect(skillLine.fileName, 'SkillLine.dbc');
    expect(skillLine.schema.fields, hasLength(56));
  });
}
