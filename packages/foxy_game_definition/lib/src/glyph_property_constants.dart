abstract final class GlyphPropertyConstants {
  /// GlyphProperties.dbc `GlyphSlotFlags` values for client 3.3.5a.
  ///
  /// Verified against client data (item icons INV_Glyph_Major*/INV_Glyph_Minor*,
  /// GlyphSlot.dbc slots 21-26) and AzerothCore's TypeFlags equality check:
  /// 0 = major glyph, 1 = minor glyph. The glyph frame also renders a socket
  /// as major when TypeFlags + 1 == 1 (GLYPHTYPE_MAJOR), minor when == 2.
  static const glyphPropertySlotTypeOptions = <int, String>{
    0: '大型雕文',
    1: '小型雕文',
  };

  static const applyGlyphSpellEffect = 74;
}
