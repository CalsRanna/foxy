import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/smart_script_constants.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/page/smart_script/smart_script_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

class _SmartScriptValidationViewModel
    with ViewModelValidationMixin, SmartScriptValidationMixin {}

void main() {
  test('smart_scripts Entity 精确覆盖 31 个物理列且全部为标量', () {
    final json = const SmartScriptEntity().toJson();
    expect(json.keys.toList(), [
      'entryorguid',
      'source_type',
      'id',
      'link',
      'event_type',
      'event_phase_mask',
      'event_chance',
      'event_flags',
      'event_param1',
      'event_param2',
      'event_param3',
      'event_param4',
      'event_param5',
      'event_param6',
      'action_type',
      'action_param1',
      'action_param2',
      'action_param3',
      'action_param4',
      'action_param5',
      'action_param6',
      'target_type',
      'target_param1',
      'target_param2',
      'target_param3',
      'target_param4',
      'target_x',
      'target_y',
      'target_z',
      'target_o',
      'comment',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
    expect(json['event_chance'], 100);
  });

  test('fromJson 接受 MySQL 整数坐标且 copyWith 不丢失联合字段', () {
    final source = const SmartScriptEntity(
      entryOrGuid: 1,
      sourceType: 0,
      id: 2,
      link: 3,
      eventType: 9,
      eventPhaseMask: 4,
      eventChance: 80,
      eventFlags: 0x101,
      eventParam1: 11,
      eventParam2: 12,
      eventParam3: 13,
      eventParam4: 14,
      eventParam5: 15,
      eventParam6: 16,
      actionType: 67,
      actionParam1: 21,
      actionParam2: 22,
      actionParam3: 23,
      actionParam4: 24,
      actionParam5: 25,
      actionParam6: 26,
      targetType: 28,
      targetParam1: 31,
      targetParam2: 1,
      targetParam3: 1,
      targetParam4: 34,
      targetX: 1,
      targetY: 2,
      targetZ: 3,
      targetO: 4,
      comment: 'all fields',
    );
    final copied = source.copyWith(id: 99);
    expect(copied.toJson(), {...source.toJson(), 'id': 99});

    final mysqlRow = {...source.toJson(), 'target_x': 1, 'target_y': 2};
    final decoded = SmartScriptEntity.fromJson(mysqlRow);
    expect(decoded.targetX, 1.0);
    expect(decoded.targetY, 2.0);
  });

  test('source_type 只提供当前 SmartAI loader 实际加载的四类', () {
    expect(kSourceTypes.keys.toSet(), {0, 1, 2, 9});
  });

  test('SmartEvents 精确排除 3.3.5a 场景事件和枚举哨兵', () {
    expect(kEventTypes.keys.toSet(), {
      for (var value = 0; value <= 77; value++) value,
      82,
      for (var value = 101; value <= 110; value++) value,
    });
    expect(smartEventTypesForSource(2).keys.toSet(), {46, 61});
    expect(smartEventTypesForSource(1), containsPair(70, 'GO_STATE_CHANGED'));
    expect(smartEventTypesForSource(1), isNot(contains(4)));
    expect(smartEventTypesForSource(9).keys.toSet(), kEventTypes.keys.toSet());
  });

  test('SmartActions 只包含当前 core 已声明且可加载的动作', () {
    final expected = <int>{
      for (var value = 1; value <= 136; value++)
        if (!{16, 119, 120, 127, 128, 129, 130, 133}.contains(value)) value,
      142,
      201,
      for (var value = 203; value <= 242; value++) value,
    };
    expect(kActionTypes.keys.toSet(), expected);
    expect(kActionTypes, isNot(contains(0)));
    expect(kActionTypes, isNot(contains(202)));
  });

  test('SmartTargets 排除哨兵区间与 core 明确不支持的 LOOT_RECIPIENTS', () {
    expect(kTargetTypes.keys.toSet(), {
      for (var value = 0; value <= 29; value++)
        if (value != 27) value,
      for (var value = 201; value <= 206; value++) value,
    });
  });

  test('事件与施法 Flags 不暴露运行时位或注释掉的旧位', () {
    expect(kEventFlagItems.map((item) => item.value).toSet(), {
      0x001,
      0x002,
      0x004,
      0x008,
      0x010,
      0x020,
      0x040,
      0x080,
      0x100,
      0x200,
    });
    expect(kSmartCastFlagItems.map((item) => item.value).toSet(), {
      0x001,
      0x002,
      0x020,
      0x040,
      0x080,
      0x100,
      0x200,
      0x400,
    });
  });

  test('关键联合参数指向 SmartScriptMgr 使用的精确表或 DBC', () {
    expect(
      smartEventParameterConfig(22).param1.reference,
      SmartParameterReference.textEmote,
    );
    expect(
      smartActionParameterConfig(5).param1.reference,
      SmartParameterReference.emote,
    );
    expect(
      smartActionParameterConfig(2).param1.reference,
      SmartParameterReference.factionTemplate,
    );
    expect(
      smartActionParameterConfig(52).param1.reference,
      SmartParameterReference.taxiPath,
    );
    expect(
      smartTargetParameterConfig(201).param1.reference,
      SmartParameterReference.spell,
    );
    expect(smartEventParameterConfig(4).param1.editable, isFalse);
    expect(smartTargetParameterConfig(8).param1.editable, isFalse);
  });

  test('关键 core 约束在保存前拒绝非法记录', () {
    final viewModel = _SmartScriptValidationViewModel();
    const valid = SmartScriptEntity(
      entryOrGuid: 1,
      sourceType: 0,
      eventType: 4,
      actionType: 24,
      targetType: 1,
    );
    expect(() => viewModel.validateSmartScriptFields(valid), returnsNormally);
    expect(
      () =>
          viewModel.validateSmartScriptFields(valid.copyWith(eventChance: 101)),
      throwsArgumentError,
    );
    expect(
      () => viewModel.validateSmartScriptFields(
        valid.copyWith(sourceType: 2, eventType: 4),
      ),
      throwsArgumentError,
    );
    expect(
      () =>
          viewModel.validateSmartScriptFields(valid.copyWith(actionType: 119)),
      throwsArgumentError,
    );
    expect(
      () => viewModel.validateSmartScriptFields(valid.copyWith(targetType: 27)),
      throwsArgumentError,
    );
    expect(
      () => viewModel.validateSmartScriptFields(valid.copyWith(eventParam1: 1)),
      throwsArgumentError,
    );
    expect(
      () => viewModel.validateSmartScriptFields(
        valid.copyWith(eventType: 61, id: 3, link: 3),
      ),
      throwsArgumentError,
    );
  });

  test('详情 UI 与 ViewModel 显式管理全部字段并保持四列布局', () {
    final view = File(
      'lib/page/smart_script/smart_script_view.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/smart_script/smart_script_detail_view_model.dart',
    ).readAsStringSync();
    expect(view, contains("'event_param6'"));
    expect(viewModel, contains('eventParam6Controller'));
    expect(viewModel, contains('eventParam6: eventParam6Controller.collect()'));
    expect(view, contains('Expanded(child: fourth)'));
    expect(view, isNot(contains('List.generate')));
    expect(viewModel, isNot(contains('List.generate')));
  });
}
