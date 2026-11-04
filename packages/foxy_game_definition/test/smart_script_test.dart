import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
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
    expect(
      SmartScriptConstants.eventTypesForSource(1),
      containsPair(70, 'GO_STATE_CHANGED'),
    );
    expect(SmartScriptConstants.eventTypesForSource(1), isNot(contains(4)));
    expect(
      SmartScriptConstants.eventTypesForSource(9).keys.toSet(),
      SmartScriptConstants.eventTypes.keys.toSet(),
    );
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
    expect(
      SmartScriptConstants.eventFlagItems.map((item) => item.value).toSet(),
      {0x001, 0x002, 0x004, 0x008, 0x010, 0x020, 0x040, 0x080, 0x100, 0x200},
    );
    expect(
      SmartScriptConstants.smartCastFlagItems.map((item) => item.value).toSet(),
      {0x001, 0x002, 0x020, 0x040, 0x080, 0x100, 0x200, 0x400},
    );
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
    expect(SmartScriptConstants.eventParameterConfig(4).param1.label, '未使用');
    expect(SmartScriptConstants.targetParameterConfig(8).param1.label, '未使用');
  });
}
