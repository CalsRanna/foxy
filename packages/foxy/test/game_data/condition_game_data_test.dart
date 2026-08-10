import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/condition_error_types.dart';
import 'package:foxy/constant/condition_source_type.dart';
import 'package:foxy/constant/condition_type.dart';
import 'package:foxy/constant/condition_value_config.dart';
import 'package:foxy/constant/integer_field_spec.dart';
import 'package:foxy/entity/condition_entity.dart';

void main() {

  test('来源类型精确排除 NONE、3.3.5a 不支持值和枚举哨兵', () {
    expect(ConditionSourceTypes.conditionSourceTypeLabels.keys.toSet(), {
      for (var value = 1; value <= 24; value++) value,
      28,
      29,
      30,
    });
    expect(ConditionSourceTypes.conditionSourceTypeLabels, isNot(contains(0)));
    expect(ConditionSourceTypes.conditionSourceTypeLabels, isNot(contains(25)));
    expect(ConditionSourceTypes.conditionSourceTypeLabels, isNot(contains(31)));
  });

  test('条件类型精确匹配 ConditionMgr 当前可加载集合', () {
    expect(ConditionType.conditionTypeLabels.keys.toSet(), {
      for (var value = 1; value <= 40; value++) value,
      for (var value = 42; value <= 49; value++) value,
      for (var value = 101; value <= 106; value++) value,
    });
    expect(ConditionType.conditionTypeLabels, isNot(contains(0)));
    expect(ConditionType.conditionTypeLabels, isNot(contains(41)));
    expect(ConditionType.conditionTypeLabels, isNot(contains(50)));
    expect(ConditionType.conditionTypeLabels, isNot(contains(100)));
    expect(ConditionType.conditionTypeLabels, isNot(contains(107)));
  });

  test('ConditionTarget 数量按 ConditionMgr 来源分支计算', () {
    expect(ConditionSourceTypes.targetCount(22), 3);
    expect(ConditionSourceTypes.targetCount(17), 2);
    expect(ConditionSourceTypes.targetCount(30), 2);
    expect(ConditionSourceTypes.targetCount(19), 1);
  });

  test('ErrorType 和 ErrorTextId 使用 SpellCastResult 精确枚举', () {
    expect(ConditionErrorTypes.conditionErrorTypeOptions.keys.toSet(), {
      for (var value = 0; value <= 187; value++) value,
    });
    expect(ConditionErrorTypes.conditionErrorTypeOptions, isNot(contains(255)));
    expect(ConditionErrorTypes.conditionCustomErrorOptions.keys.toSet(), {
      for (var value = 0; value <= 99; value++) value,
    });
  });

  test('三个 Value 字段分别使用运行时消费的枚举、Flags 和引用', () {
    final item = ConditionValueConfig.forType(2);
    expect(
      (item.value1 as IntegerReferenceFieldSpec).reference,
      ConditionValueReference.item,
    );
    expect(item.value2.label, '数量');
    expect(
      (item.value3 as IntegerSelectFieldSpec).options,
      ConditionValueConfig.conditionBooleanOptions,
    );

    final instance = ConditionValueConfig.forType(13);
    expect((instance.value3 as IntegerSelectFieldSpec).options.keys.toSet(), {
      0,
      1,
      2,
      3,
    });
    expect(
      (ConditionValueConfig.forType(31, value1: 3).value2 as IntegerReferenceFieldSpec)
          .reference,
      ConditionValueReference.creature,
    );
    expect(
      (ConditionValueConfig.forType(31, value1: 5).value2 as IntegerReferenceFieldSpec)
          .reference,
      ConditionValueReference.gameObject,
    );
    expect(
      (ConditionValueConfig.forType(31, value1: 4).value2 as IntegerNumberFieldSpec)
          .label,
      '对象条目',
    );
    expect(
      (ConditionValueConfig.forType(47).value2 as IntegerFlagsFieldSpec).flags,
      ConditionValueConfig.conditionQuestStatusFlags,
    );
    expect(ConditionValueConfig.forType(103).value1.label, '世界脚本 ID');
  });

  test('参数1 按条件类型动态映射为标签', () {
    // 布尔 select 规格（105 检查当前难度）映射为 是/否。
    const boolean = BriefConditionEntity(
      conditionTypeOrReference: 105,
      conditionValue1: 1,
    );
    expect(boolean.conditionValue1Label, '是');
    // flags 规格（16 种族掩码）展开为标签列表。
    const flags = BriefConditionEntity(
      conditionTypeOrReference: 16,
      conditionValue1: 0x01 | 0x02,
    );
    expect(flags.conditionValue1Label, '人类, 兽人');
    // number 规格回退为原始数字。
    const number = BriefConditionEntity(
      conditionTypeOrReference: 11,
      conditionValue1: 42,
    );
    expect(number.conditionValue1Label, '42');
    // 负数类型（引用）回退为原始数字。
    const reference = BriefConditionEntity(
      conditionTypeOrReference: -1,
      conditionValue1: 7,
    );
    expect(reference.conditionValue1Label, '7');
  });

}
