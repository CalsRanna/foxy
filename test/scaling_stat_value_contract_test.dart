import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/item_flags.dart';
import 'package:foxy/constant/scaling_stat_value_constants.dart';

void main() {

  test('物品缩放位精确对应 ScalingStatValuesEntry 当前消费列', () {
    expect(kScalingStatValueBudgetMask, 0x0004001F);
    expect(kScalingStatValueArmorMask, 0x00F801E0);
    expect(kScalingStatValueDpsMask, 0x00007E00);
    expect(kScalingStatValueSpellPowerMask, 0x00008000);
    expect(kScalingStatValueSupportedMask, 0x00FCFFFF);
    expect(kItemScalingStatValueOptions.map((item) => item.value).toList(), [
      0x00000001,
      0x00000002,
      0x00000004,
      0x00000008,
      0x00000010,
      0x00000020,
      0x00000040,
      0x00000080,
      0x00000100,
      0x00000200,
      0x00000400,
      0x00000800,
      0x00001000,
      0x00002000,
      0x00004000,
      0x00008000,
      0x00040000,
      0x00080000,
      0x00100000,
      0x00200000,
      0x00400000,
      0x00800000,
    ]);
  });

  test('DBC definition 使用 3.3.5.12340 的 24 列物理格式', () {
    final definition = dbcDefinitionByTable['dbc_scaling_stat_values']!;
    expect(definition.fileName, 'ScalingStatValues.dbc');
    expect(definition.schema.format, 'niiiiiiiiiiiiiiiiiiiiiii');
    expect(definition.schema.fields, hasLength(24));
  });
}
