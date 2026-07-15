import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/condition_error_types.dart';
import 'package:foxy/constant/condition_source_type.dart';
import 'package:foxy/constant/condition_type.dart';
import 'package:foxy/constant/condition_value_config.dart';
import 'package:foxy/entity/condition_entity.dart';

void main() {
  test('conditions Entity 精确覆盖 15 个物理列且全部为标量', () {
    final json = const ConditionEntity().toJson();
    expect(json.keys.toList(), [
      'SourceTypeOrReferenceId',
      'SourceGroup',
      'SourceEntry',
      'SourceId',
      'ElseGroup',
      'ConditionTypeOrReference',
      'ConditionTarget',
      'ConditionValue1',
      'ConditionValue2',
      'ConditionValue3',
      'NegativeCondition',
      'ErrorType',
      'ErrorTextId',
      'ScriptName',
      'Comment',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('来源类型精确排除 NONE、3.3.5a 不支持值和枚举哨兵', () {
    expect(kConditionSourceTypeLabels.keys.toSet(), {
      for (var value = 1; value <= 24; value++) value,
      28,
      29,
      30,
    });
    expect(kConditionSourceTypeLabels, isNot(contains(0)));
    expect(kConditionSourceTypeLabels, isNot(contains(25)));
    expect(kConditionSourceTypeLabels, isNot(contains(31)));
  });

  test('条件类型精确匹配 ConditionMgr 当前可加载集合', () {
    expect(kConditionTypeLabels.keys.toSet(), {
      for (var value = 1; value <= 40; value++) value,
      for (var value = 42; value <= 49; value++) value,
      for (var value = 101; value <= 106; value++) value,
    });
    expect(kConditionTypeLabels, isNot(contains(0)));
    expect(kConditionTypeLabels, isNot(contains(41)));
    expect(kConditionTypeLabels, isNot(contains(50)));
    expect(kConditionTypeLabels, isNot(contains(100)));
    expect(kConditionTypeLabels, isNot(contains(107)));
  });

  test('ConditionTarget 数量按 ConditionMgr 来源分支计算', () {
    expect(conditionTargetCount(22), 3);
    expect(conditionTargetCount(17), 2);
    expect(conditionTargetCount(30), 2);
    expect(conditionTargetCount(19), 1);
  });

  test('ErrorType 和 ErrorTextId 使用 SpellCastResult 精确枚举', () {
    expect(kConditionErrorTypeOptions.keys.toSet(), {
      for (var value = 0; value <= 187; value++) value,
    });
    expect(kConditionErrorTypeOptions, isNot(contains(255)));
    expect(kConditionCustomErrorOptions.keys.toSet(), {
      for (var value = 0; value <= 99; value++) value,
    });
  });

  test('三个 Value 字段分别使用运行时消费的枚举、Flags 和引用', () {
    final item = conditionValueConfig(2);
    expect(item.value1.reference, ConditionValueReference.item);
    expect(item.value2.label, '数量');
    expect(item.value3.options, kConditionBooleanOptions);

    final instance = conditionValueConfig(13);
    expect(instance.value3.options!.keys.toSet(), {0, 1, 2, 3});
    expect(
      conditionValueConfig(31, value1: 3).value2.reference,
      ConditionValueReference.creature,
    );
    expect(
      conditionValueConfig(31, value1: 5).value2.reference,
      ConditionValueReference.gameObject,
    );
    expect(conditionValueConfig(47).value2.flags, kConditionQuestStatusFlags);
    expect(conditionValueConfig(103).value1.label, '世界脚本条件 ID');
  });

  test('核心跨字段约束会在保存前拒绝无效条件', () {
    const valid = ConditionEntity(
      sourceTypeOrReferenceId: 17,
      sourceEntry: 1,
      conditionTypeOrReference: 2,
      conditionValue1: 1,
      conditionValue2: 1,
      conditionValue3: 2,
      errorType: 12,
    );
    expect(valid.validate, returnsNormally);
    expect(
      () => valid.copyWith(sourceTypeOrReferenceId: 0).validate(),
      throwsArgumentError,
    );
    expect(
      () => valid.copyWith(conditionTypeOrReference: 41).validate(),
      throwsArgumentError,
    );
    expect(
      () => valid.copyWith(conditionTarget: 2).validate(),
      throwsArgumentError,
    );
    expect(
      () =>
          valid.copyWith(sourceTypeOrReferenceId: 19, errorType: 12).validate(),
      throwsArgumentError,
    );
    expect(
      () => valid
          .copyWith(
            conditionTypeOrReference: 38,
            conditionValue1: 101,
            conditionValue3: 0,
          )
          .validate(),
      throwsRangeError,
    );
    expect(
      () => valid.copyWith(errorType: 255).validate(),
      throwsArgumentError,
    );
    expect(
      () => valid.copyWith(errorTextId: 1).validate(),
      throwsArgumentError,
    );
    expect(
      valid.copyWith(errorType: 172, errorTextId: 99).validate,
      returnsNormally,
    );
  });

  test('负数引用模板和条件引用保留且拒绝自引用及未使用字段', () {
    const referenceTemplate = ConditionEntity(
      sourceTypeOrReferenceId: -7,
      conditionTypeOrReference: 36,
    );
    expect(referenceTemplate.validate, returnsNormally);

    const reference = ConditionEntity(
      sourceTypeOrReferenceId: 17,
      sourceEntry: 1,
      conditionTypeOrReference: -7,
    );
    expect(reference.validate, returnsNormally);
    expect(
      () => reference.copyWith(sourceTypeOrReferenceId: -7).validate(),
      throwsArgumentError,
    );
    expect(
      () => reference.copyWith(conditionValue1: 1).validate(),
      throwsArgumentError,
    );
  });

  test('详情页显式管理字段并保持每行四列等宽', () {
    final view = File(
      'lib/page/condition/condition_view.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/condition/condition_detail_view_model.dart',
    ).readAsStringSync();
    expect(view, contains('Expanded(child: fourth)'));
    expect(view, isNot(contains('flex: 3')));
    expect(view, isNot(contains('List.generate')));
    expect(viewModel, contains('IntFieldController()'));
    expect(viewModel, contains('validateConditionFields(data)'));
    expect(viewModel, isNot(contains('SelectFieldController<int>')));
  });
}
