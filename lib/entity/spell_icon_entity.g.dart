// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_icon_entity.dart';

final class BriefSpellIconEntity {
  final int id;
  final String textureFilename;

  const BriefSpellIconEntity({this.id = 0, this.textureFilename = ''});

  factory BriefSpellIconEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellIconEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      textureFilename: json['TextureFilename']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([id, textureFilename]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefSpellIconEntity &&
            id == other.id &&
            textureFilename == other.textureFilename;
  }

  @override
  String toString() {
    return 'BriefSpellIconEntity('
        'id: $id, '
        'textureFilename: $textureFilename'
        ')';
  }
}

mixin _SpellIconEntityMixin {
  @override
  int get hashCode {
    final self = this as SpellIconEntity;
    return Object.hashAll([self.runtimeType, self.id, self.textureFilename]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellIconEntity;
    return identical(self, other) ||
        other is SpellIconEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.textureFilename == other.textureFilename;
  }

  SpellIconEntity copyWith({int? id, String? textureFilename}) {
    final self = this as SpellIconEntity;
    return SpellIconEntity(
      id: id ?? self.id,
      textureFilename: textureFilename ?? self.textureFilename,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SpellIconEntity;
    return {'ID': self.id, 'TextureFilename': self.textureFilename};
  }

  @override
  String toString() {
    final self = this as SpellIconEntity;
    return 'SpellIconEntity('
        'id: ${self.id}, '
        'textureFilename: ${self.textureFilename}'
        ')';
  }

  static SpellIconEntity fromJson(Map<String, dynamic> json) {
    return SpellIconEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      textureFilename: json['TextureFilename']?.toString() ?? '',
    );
  }
}
