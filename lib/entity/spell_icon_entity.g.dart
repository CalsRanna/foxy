// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_icon_entity.dart';

mixin _SpellIconEntityMixin {
  int get id;
  String get textureFilename;

  static SpellIconEntity fromJson(Map<String, dynamic> json) {
    return SpellIconEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      textureFilename: json['TextureFilename']?.toString() ?? '',
    );
  }

  SpellIconEntity copyWith({int? id, String? textureFilename}) {
    return SpellIconEntity(
      id: id ?? this.id,
      textureFilename: textureFilename ?? this.textureFilename,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'TextureFilename': textureFilename};
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellIconEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            textureFilename == other.textureFilename;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, id, textureFilename]);
  }

  @override
  String toString() {
    return 'SpellIconEntity('
        'id: $id, '
        'textureFilename: $textureFilename'
        ')';
  }
}
