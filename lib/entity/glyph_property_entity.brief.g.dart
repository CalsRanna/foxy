// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefGlyphPropertyEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      spellId: (json['SpellID'] as num?)?.toInt() ?? 0,
      glyphSlotFlags: (json['GlyphSlotFlags'] as num?)?.toInt() ?? 0,
      spellIconId: (json['SpellIconID'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
