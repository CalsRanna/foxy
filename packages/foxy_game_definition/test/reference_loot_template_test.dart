import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test(
    'LootMode flags cover SharedDefines.h and the bits used by core base data',
    () {
      expect(
        CreatureFlags.lootModeFlagOptions.map((flag) => flag.value).toSet(),
        {0x0001, 0x0002, 0x0004, 0x0008, 0x0010, 0x0020, 0x8000},
      );
      expect(LootTemplateConstants.lootTemplateValidLootModeMask, 0x803f);
    },
  );
}
