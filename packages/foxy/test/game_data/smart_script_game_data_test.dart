import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/integer_field_spec.dart';
import 'package:foxy/constant/smart_script_constants.dart';
import 'package:foxy/entity/smart_script_entity.dart';

void main() {

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
    expect(SmartScriptConstants.sourceTypes.keys.toSet(), {0, 1, 2, 9});
  });

  test('SmartEvents 精确排除 3.3.5a 场景事件和枚举哨兵', () {
    expect(SmartScriptConstants.eventTypes.keys.toSet(), {
      for (var value = 0; value <= 77; value++) value,
      82,
      for (var value = 101; value <= 110; value++) value,
    });
    expect(SmartScriptConstants.eventTypesForSource(2).keys.toSet(), {46, 61});
    expect(SmartScriptConstants.eventTypesForSource(1), containsPair(70, 'GO_STATE_CHANGED'));
    expect(SmartScriptConstants.eventTypesForSource(1), isNot(contains(4)));
    expect(SmartScriptConstants.eventTypesForSource(9).keys.toSet(), SmartScriptConstants.eventTypes.keys.toSet());
  });

  test('SmartActions 只包含当前 core 已声明且可加载的动作', () {
    final expected = <int>{
      for (var value = 1; value <= 136; value++)
        if (!{16, 119, 120, 127, 128, 129, 130, 133}.contains(value)) value,
      142,
      201,
      for (var value = 203; value <= 242; value++) value,
    };
    expect(SmartScriptConstants.actionTypes.keys.toSet(), expected);
    expect(SmartScriptConstants.actionTypes, isNot(contains(0)));
    expect(SmartScriptConstants.actionTypes, isNot(contains(202)));
  });

  test('SmartTargets 排除哨兵区间与 core 明确不支持的 LOOT_RECIPIENTS', () {
    expect(SmartScriptConstants.targetTypes.keys.toSet(), {
      for (var value = 0; value <= 29; value++)
        if (value != 27) value,
      for (var value = 201; value <= 206; value++) value,
    });
  });

  test('事件与施法 Flags 不暴露运行时位或注释掉的旧位', () {
    expect(SmartScriptConstants.eventFlagItems.map((item) => item.value).toSet(), {
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
    expect(SmartScriptConstants.smartCastFlagItems.map((item) => item.value).toSet(), {
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
    SmartParameterReference referenceOf(
      IntegerFieldSpec<SmartParameterReference> spec,
    ) => switch (spec) {
      IntegerReferenceFieldSpec(:final reference) => reference,
      _ => fail('参数不是引用规格：${spec.label}'),
    };

    expect(
      referenceOf(SmartScriptConstants.eventParameterConfig(22).param1),
      SmartParameterReference.textEmote,
    );
    expect(
      referenceOf(SmartScriptConstants.actionParameterConfig(5).param1),
      SmartParameterReference.emote,
    );
    expect(
      referenceOf(SmartScriptConstants.actionParameterConfig(2).param1),
      SmartParameterReference.factionTemplate,
    );
    expect(
      referenceOf(SmartScriptConstants.actionParameterConfig(52).param1),
      SmartParameterReference.taxiPath,
    );
    expect(
      referenceOf(SmartScriptConstants.targetParameterConfig(201).param1),
      SmartParameterReference.spell,
    );
    expect(SmartScriptConstants.eventParameterConfig(4).param1.editable, isFalse);
    expect(SmartScriptConstants.targetParameterConfig(8).param1.editable, isFalse);
  });
}
