import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test('source_type exposes only the four classes loaded by the current SmartAI loader', () {
    expect(SmartScriptConstants.sourceTypes.keys.toSet(), {0, 1, 2, 9});
  });

  test('SmartEvents excludes 3.3.5a scene events and enum sentinels', () {
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

  test('SmartActions contains only actions declared and loadable by the current core', () {
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

  test('SmartTargets excludes sentinel ranges and the unsupported LOOT_RECIPIENTS value', () {
    expect(SmartScriptConstants.targetTypes.keys.toSet(), {
      for (var value = 0; value <= 29; value++)
        if (value != 27) value,
      for (var value = 201; value <= 206; value++) value,
    });
  });

  test(
    'Event and cast flags exclude runtime bits and commented-out legacy bits',
    () {
      expect(
        SmartScriptConstants.eventFlagItems.map((item) => item.value).toSet(),
        {0x001, 0x002, 0x004, 0x008, 0x010, 0x020, 0x040, 0x080, 0x100, 0x200},
      );
      expect(
        SmartScriptConstants.smartCastFlagItems
            .map((item) => item.value)
            .toSet(),
        {0x001, 0x002, 0x020, 0x040, 0x080, 0x100, 0x200, 0x400},
      );
    },
  );

  test('Key union parameters reference the exact tables or DBCs used by SmartScriptMgr', () {
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
