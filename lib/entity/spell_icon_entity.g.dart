// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_icon_entity.dart';

mixin _SpellIconEntityMixin {
  static SpellIconEntity fromJson(Map<String, dynamic> json) {
    return SpellIconEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      textureFilename: json['TextureFilename']?.toString() ?? '',
    );
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
  bool operator ==(Object other) {
    final self = this as SpellIconEntity;
    return identical(self, other) ||
        other is SpellIconEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.textureFilename == other.textureFilename;
  }

  @override
  int get hashCode {
    final self = this as SpellIconEntity;
    return Object.hashAll([self.runtimeType, self.id, self.textureFilename]);
  }

  @override
  String toString() {
    final self = this as SpellIconEntity;
    return 'SpellIconEntity('
        'id: ${self.id}, '
        'textureFilename: ${self.textureFilename}'
        ')';
  }
}

final class BriefSpellIconEntity {
  final int id;
  final String textureFilename;

  const BriefSpellIconEntity({this.id = 0, this.textureFilename = ''});

  factory BriefSpellIconEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellIconEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      textureFilename: json['TextureFilename']?.toString() ?? '',
    );
  }

  int get key => id;
}
