import 'package:foxy/entity/glyph_property_key.dart';

class BriefGlyphPropertyEntity {
  final int id;
  final int spellId;
  final int glyphSlotFlags;
  final int spellIconId;

  const BriefGlyphPropertyEntity({
    this.id = 0,
    this.spellId = 0,
    this.glyphSlotFlags = 0,
    this.spellIconId = 0,
  });

  factory BriefGlyphPropertyEntity.fromJson(Map<String, dynamic> json) {
    return BriefGlyphPropertyEntity(
      id: json['ID'] ?? 0,
      spellId: json['SpellID'] ?? 0,
      glyphSlotFlags: json['GlyphSlotFlags'] ?? 0,
      spellIconId: json['SpellIconID'] ?? 0,
    );
  }

  GlyphPropertyKey get key => GlyphPropertyKey(id: id);
}
