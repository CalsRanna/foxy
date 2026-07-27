import 'package:flutter_test/flutter_test.dart';
import 'support/entity_validation_test_extensions.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/item_flags.dart';
import 'package:foxy/constant/scaling_stat_value_constants.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';

void main() {
  test('Entity 精确覆盖 ScalingStatValues.dbc 的 24 个标量物理列', () {
    final json = const ScalingStatValueEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'Charlevel',
      'ShoulderBudget',
      'TrinketBudget',
      'WeaponBudget1H',
      'RangedBudget',
      'ClothShoulderArmor',
      'LeatherShoulderArmor',
      'MailShoulderArmor',
      'PlateShoulderArmor',
      'WeaponDPS1H',
      'WeaponDPS2H',
      'SpellcasterDPS1H',
      'SpellcasterDPS2H',
      'RangedDPS',
      'WandDPS',
      'SpellPower',
      'PrimaryBudget',
      'TertiaryBudget',
      'ClothCloakArmor',
      'ClothChestArmor',
      'LeatherChestArmor',
      'MailChestArmor',
      'PlateChestArmor',
    ]);
    expect(json.values, everyElement(isA<int>()));
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('Entity 按 core uint32 语义限制为 DBC 可写出的非负 int32', () {
    expect(
      const ScalingStatValueEntity(id: 1, charlevel: 1).validate,
      returnsNormally,
    );
    expect(
      () => const ScalingStatValueEntity(id: 0, charlevel: 1).validate(),
      throwsArgumentError,
    );
    expect(
      () => const ScalingStatValueEntity(id: 1, charlevel: 0).validate(),
      throwsArgumentError,
    );
    expect(
      () => const ScalingStatValueEntity(
        id: 1,
        charlevel: 1,
        plateChestArmor: -1,
      ).validate(),
      throwsArgumentError,
    );
  });

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

  test('物品缩放掩码排除未消费位并限制同组最多选择一列', () {
    expect(
      const ItemTemplateEntity(scalingStatValue: 0x00808208).validate,
      returnsNormally,
    );
    expect(
      () => const ItemTemplateEntity(scalingStatValue: 0x00010000).validate(),
      throwsArgumentError,
    );
    expect(
      () => const ItemTemplateEntity(scalingStatValue: 0x00020000).validate(),
      throwsArgumentError,
    );
    expect(
      () => const ItemTemplateEntity(scalingStatValue: 0x00000003).validate(),
      throwsArgumentError,
    );
    expect(
      () => const ItemTemplateEntity(scalingStatValue: 0x00000060).validate(),
      throwsArgumentError,
    );
    expect(
      () => const ItemTemplateEntity(scalingStatValue: 0x00000600).validate(),
      throwsArgumentError,
    );
  });

  test('DBC definition 使用 3.3.5.12340 的 24 列物理格式', () {
    final definition = dbcDefinitionByTable['dbc_scaling_stat_values']!;
    expect(definition.fileName, 'ScalingStatValues.dbc');
    expect(definition.schema.format, 'niiiiiiiiiiiiiiiiiiiiiii');
    expect(definition.schema.fields, hasLength(24));
  });
}
