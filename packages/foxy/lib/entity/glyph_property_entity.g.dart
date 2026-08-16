// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glyph_property_entity.dart';

final class BriefGlyphPropertyEntity {
  final int id;
  final int spellId;
  final int glyphSlotFlags;
  final int spellIconId;
  final String spellName;
  final String localeSpellName;
  final String textureFilename;

  const BriefGlyphPropertyEntity({
    this.id = 0,
    this.spellId = 0,
    this.glyphSlotFlags = 0,
    this.spellIconId = 0,
    this.spellName = '',
    this.localeSpellName = '',
    this.textureFilename = '',
  });

  factory BriefGlyphPropertyEntity.fromJson(Map<String, dynamic> json) {
    return BriefGlyphPropertyEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      spellId: json['SpellID'] == true
          ? 1
          : json['SpellID'] == false
          ? 0
          : (json['SpellID'] as num?)?.toInt() ?? 0,
      glyphSlotFlags: json['GlyphSlotFlags'] == true
          ? 1
          : json['GlyphSlotFlags'] == false
          ? 0
          : (json['GlyphSlotFlags'] as num?)?.toInt() ?? 0,
      spellIconId: json['SpellIconID'] == true
          ? 1
          : json['SpellIconID'] == false
          ? 0
          : (json['SpellIconID'] as num?)?.toInt() ?? 0,
      spellName: json['spellName']?.toString() ?? '',
      localeSpellName: json['localeSpellName']?.toString() ?? '',
      textureFilename: json['textureFilename']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    spellId,
    glyphSlotFlags,
    spellIconId,
    spellName,
    localeSpellName,
    textureFilename,
  ]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefGlyphPropertyEntity &&
            id == other.id &&
            spellId == other.spellId &&
            glyphSlotFlags == other.glyphSlotFlags &&
            spellIconId == other.spellIconId &&
            spellName == other.spellName &&
            localeSpellName == other.localeSpellName &&
            textureFilename == other.textureFilename;
  }

  @override
  String toString() {
    return 'BriefGlyphPropertyEntity('
        'id: $id, '
        'spellId: $spellId, '
        'glyphSlotFlags: $glyphSlotFlags, '
        'spellIconId: $spellIconId, '
        'spellName: $spellName, '
        'localeSpellName: $localeSpellName, '
        'textureFilename: $textureFilename'
        ')';
  }
}

mixin _GlyphPropertyEntityMixin {
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
  String toString() {
    final self = this as GlyphPropertyEntity;
    return 'GlyphPropertyEntity('
        'id: ${self.id}, '
        'spellId: ${self.spellId}, '
        'glyphSlotFlags: ${self.glyphSlotFlags}, '
        'spellIconId: ${self.spellIconId}'
        ')';
  }

  static GlyphPropertyEntity fromJson(Map<String, dynamic> json) {
    return GlyphPropertyEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      spellId: json['SpellID'] == true
          ? 1
          : json['SpellID'] == false
          ? 0
          : (json['SpellID'] as num?)?.toInt() ?? 0,
      glyphSlotFlags: json['GlyphSlotFlags'] == true
          ? 1
          : json['GlyphSlotFlags'] == false
          ? 0
          : (json['GlyphSlotFlags'] as num?)?.toInt() ?? 0,
      spellIconId: json['SpellIconID'] == true
          ? 1
          : json['SpellIconID'] == false
          ? 0
          : (json['SpellIconID'] as num?)?.toInt() ?? 0,
    );
  }
}
