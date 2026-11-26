import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test('SpellCustomAttributes covers every independent bit and excludes composite aliases', () {
    final values = SpellFlags.spellCustomAttributeOptions.map(
      (item) => item.value,
    );
    expect(values.toSet(), hasLength(32));
    expect(
      values.every((value) => value > 0 && value & (value - 1) == 0),
      isTrue,
    );
    expect(values.fold(0, (mask, value) => mask | value), 0xFFFFFFFF);
    expect(values, isNot(contains(0x20000800)));
  });

  test(
    'Related table values come strictly from their corresponding core enums',
    () {
      expect(SpellEnums.spellAreaGenderOptions.keys, orderedEquals([0, 1, 2]));
      expect(SpellEnums.spellLinkedTypeOptions.keys, orderedEquals([0, 1, 2]));
      expect(
        SpellFlags.spellAreaQuestStatusOptions.map((item) => item.value),
        orderedEquals([0x01, 0x02, 0x08, 0x20, 0x40]),
      );
      expect(
        SpellEnums.spellPowerTypeOptions.keys,
        containsAll([127, 0xFFFFFFFE]),
      );
    },
  );
}
