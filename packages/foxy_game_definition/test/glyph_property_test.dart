import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test(
    'GlyphProperties and GlyphSlot use glyph types 0 for major and 1 for minor',
    () {
      // 0 = major, 1 = minor: verified against client GlyphSlot.dbc slots 21-26
      // and wowhead item data (Glyph of Frostbolt/Fireball major → flag 0,
      // Glyph of Levitate/Arcane Intellect minor → flag 1).
      expect(GlyphPropertyConstants.glyphPropertySlotTypeOptions, {
        0: '大型雕文',
        1: '小型雕文',
      });
      expect(
        GlyphPropertyConstants.glyphPropertySlotTypeOptions,
        isNot(contains(2)),
      );
      expect(GlyphPropertyConstants.applyGlyphSpellEffect, 74);
    },
  );
}
