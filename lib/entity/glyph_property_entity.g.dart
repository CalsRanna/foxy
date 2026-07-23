// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glyph_property_entity.dart';

mixin _GlyphPropertyEntityMixin {
  int get id;
  int get spellId;
  int get glyphSlotFlags;
  int get spellIconId;

  static GlyphPropertyEntity fromJson(Map<String, dynamic> json) {
    return GlyphPropertyEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      spellId: (json['SpellID'] as num?)?.toInt() ?? 0,
      glyphSlotFlags: (json['GlyphSlotFlags'] as num?)?.toInt() ?? 0,
      spellIconId: (json['SpellIconID'] as num?)?.toInt() ?? 0,
    );
  }

  GlyphPropertyEntity copyWith({
    int? id,
    int? spellId,
    int? glyphSlotFlags,
    int? spellIconId,
  }) {
    return GlyphPropertyEntity(
      id: id ?? this.id,
      spellId: spellId ?? this.spellId,
      glyphSlotFlags: glyphSlotFlags ?? this.glyphSlotFlags,
      spellIconId: spellIconId ?? this.spellIconId,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GlyphPropertyEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            spellId == other.spellId &&
            glyphSlotFlags == other.glyphSlotFlags &&
            spellIconId == other.spellIconId;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      spellId,
      glyphSlotFlags,
      spellIconId,
    ]);
  }

  @override
  String toString() {
    return 'GlyphPropertyEntity('
        'id: $id, '
        'spellId: $spellId, '
        'glyphSlotFlags: $glyphSlotFlags, '
        'spellIconId: $spellIconId'
        ')';
  }
}
