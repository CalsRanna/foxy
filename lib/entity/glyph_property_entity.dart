class GlyphPropertyEntity {
  final int id;
  final int spellId;
  final int glyphSlotFlags;
  final int spellIconId;

  const GlyphPropertyEntity({
    this.id = 0,
    this.spellId = 0,
    this.glyphSlotFlags = 0,
    this.spellIconId = 0,
  });

  factory GlyphPropertyEntity.fromJson(Map<String, dynamic> json) {
    return GlyphPropertyEntity(
      id: json['ID'] ?? 0,
      spellId: json['SpellID'] ?? 0,
      glyphSlotFlags: json['GlyphSlotFlags'] ?? 0,
      spellIconId: json['SpellIconID'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'SpellID': spellId,
      'GlyphSlotFlags': glyphSlotFlags,
      'SpellIconID': spellIconId,
    };
  }
}
