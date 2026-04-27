class GlyphProperty {
  int id = 0;
  int spellId = 0;
  int glyphSlotFlags = 0;
  int spellIconId = 0;

  GlyphProperty();

  GlyphProperty.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    spellId = json['SpellID'] ?? 0;
    glyphSlotFlags = json['GlyphSlotFlags'] ?? 0;
    spellIconId = json['SpellIconID'] ?? 0;
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
