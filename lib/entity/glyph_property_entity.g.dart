// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glyph_property_entity.dart';

mixin _GlyphPropertyEntityMixin {
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
    final self = this as GlyphPropertyEntity;
    return GlyphPropertyEntity(
      id: id ?? self.id,
      spellId: spellId ?? self.spellId,
      glyphSlotFlags: glyphSlotFlags ?? self.glyphSlotFlags,
      spellIconId: spellIconId ?? self.spellIconId,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GlyphPropertyEntity;
    return {
      'ID': self.id,
      'SpellID': self.spellId,
      'GlyphSlotFlags': self.glyphSlotFlags,
      'SpellIconID': self.spellIconId,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as GlyphPropertyEntity;
    return identical(self, other) ||
        other is GlyphPropertyEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.spellId == other.spellId &&
            self.glyphSlotFlags == other.glyphSlotFlags &&
            self.spellIconId == other.spellIconId;
  }

  @override
  int get hashCode {
    final self = this as GlyphPropertyEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.spellId,
      self.glyphSlotFlags,
      self.spellIconId,
    ]);
  }

  @override
  String toString() {
    final self = this as GlyphPropertyEntity;
    return 'GlyphPropertyEntity('
        'id: ${self.id}, '
        'spellId: ${self.spellId}, '
        'glyphSlotFlags: ${self.glyphSlotFlags}, '
        'spellIconId: ${self.spellIconId}'
        ')';
  }
}

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
