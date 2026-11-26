import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Source types exclude NONE, unsupported 3.3.5a values, and enum sentinels',
    () {
      expect(ConditionSourceTypes.conditionSourceTypeLabels.keys.toSet(), {
        for (var value = 1; value <= 24; value++) value,
        28,
        29,
        30,
      });
      expect(
        ConditionSourceTypes.conditionSourceTypeLabels,
        isNot(contains(0)),
      );
      expect(
        ConditionSourceTypes.conditionSourceTypeLabels,
        isNot(contains(25)),
      );
      expect(
        ConditionSourceTypes.conditionSourceTypeLabels,
        isNot(contains(31)),
      );
    },
  );

  test('Condition types match the set ConditionMgr can load', () {
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

  test('ConditionTarget counts come from the ConditionMgr source branches', () {
    expect(ConditionSourceTypes.targetCount(22), 3);
    expect(ConditionSourceTypes.targetCount(17), 2);
    expect(ConditionSourceTypes.targetCount(30), 2);
    expect(ConditionSourceTypes.targetCount(19), 1);
  });

  test('ErrorType and ErrorTextId use the exact SpellCastResult enum', () {
    expect(ConditionErrorTypes.conditionErrorTypeOptions.keys.toSet(), {
      for (var value = 0; value <= 187; value++) value,
    });
    expect(ConditionErrorTypes.conditionErrorTypeOptions, isNot(contains(255)));
    expect(ConditionErrorTypes.conditionCustomErrorOptions.keys.toSet(), {
      for (var value = 0; value <= 99; value++) value,
    });
  });

  test('Each Value field uses the enums, flags, and references consumed at runtime', () {
    final item = ConditionValueConfig.forType(2);
    expect(
      (item.value1 as IntegerReferenceFieldSpec).reference,
      ConditionValueReference.item,
    );
    expect(item.value2.label, '数量');
    expect(
      (item.value3 as IntegerEnumFieldSpec).options,
      ConditionValueConfig.conditionBooleanOptions,
    );

    final instance = ConditionValueConfig.forType(13);
    expect((instance.value3 as IntegerEnumFieldSpec).options.keys.toSet(), {
      0,
      1,
      2,
      3,
    });
    expect(
      (ConditionValueConfig.forType(31, value1: 3).value2
              as IntegerReferenceFieldSpec)
          .reference,
      ConditionValueReference.creature,
    );
    expect(
      (ConditionValueConfig.forType(31, value1: 5).value2
              as IntegerReferenceFieldSpec)
          .reference,
      ConditionValueReference.gameObject,
    );
    expect(
      (ConditionValueConfig.forType(31, value1: 4).value2
              as IntegerNumberFieldSpec)
          .label,
      '对象条目',
    );
    expect(
      (ConditionValueConfig.forType(47).value2 as IntegerFlagsFieldSpec).flags,
      ConditionValueConfig.conditionQuestStatusFlags,
    );
    expect(ConditionValueConfig.forType(103).value1.label, '世界脚本 ID');
  });
}
