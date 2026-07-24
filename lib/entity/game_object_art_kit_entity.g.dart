// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_art_kit_entity.dart';

mixin _GameObjectArtKitEntityMixin {
  int get id;
  String get textureVariation0;
  String get textureVariation1;
  String get textureVariation2;
  String get attachModel0;
  String get attachModel1;
  String get attachModel2;
  String get attachModel3;

  static GameObjectArtKitEntity fromJson(Map<String, dynamic> json) {
    return GameObjectArtKitEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      textureVariation0: json['TextureVariation0']?.toString() ?? '',
      textureVariation1: json['TextureVariation1']?.toString() ?? '',
      textureVariation2: json['TextureVariation2']?.toString() ?? '',
      attachModel0: json['AttachModel0']?.toString() ?? '',
      attachModel1: json['AttachModel1']?.toString() ?? '',
      attachModel2: json['AttachModel2']?.toString() ?? '',
      attachModel3: json['AttachModel3']?.toString() ?? '',
    );
  }

  GameObjectArtKitEntity copyWith({
    int? id,
    String? textureVariation0,
    String? textureVariation1,
    String? textureVariation2,
    String? attachModel0,
    String? attachModel1,
    String? attachModel2,
    String? attachModel3,
  }) {
    return GameObjectArtKitEntity(
      id: id ?? this.id,
      textureVariation0: textureVariation0 ?? this.textureVariation0,
      textureVariation1: textureVariation1 ?? this.textureVariation1,
      textureVariation2: textureVariation2 ?? this.textureVariation2,
      attachModel0: attachModel0 ?? this.attachModel0,
      attachModel1: attachModel1 ?? this.attachModel1,
      attachModel2: attachModel2 ?? this.attachModel2,
      attachModel3: attachModel3 ?? this.attachModel3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'TextureVariation0': textureVariation0,
      'TextureVariation1': textureVariation1,
      'TextureVariation2': textureVariation2,
      'AttachModel0': attachModel0,
      'AttachModel1': attachModel1,
      'AttachModel2': attachModel2,
      'AttachModel3': attachModel3,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectArtKitEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            textureVariation0 == other.textureVariation0 &&
            textureVariation1 == other.textureVariation1 &&
            textureVariation2 == other.textureVariation2 &&
            attachModel0 == other.attachModel0 &&
            attachModel1 == other.attachModel1 &&
            attachModel2 == other.attachModel2 &&
            attachModel3 == other.attachModel3;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      textureVariation0,
      textureVariation1,
      textureVariation2,
      attachModel0,
      attachModel1,
      attachModel2,
      attachModel3,
    ]);
  }

  @override
  String toString() {
    return 'GameObjectArtKitEntity('
        'id: $id, '
        'textureVariation0: $textureVariation0, '
        'textureVariation1: $textureVariation1, '
        'textureVariation2: $textureVariation2, '
        'attachModel0: $attachModel0, '
        'attachModel1: $attachModel1, '
        'attachModel2: $attachModel2, '
        'attachModel3: $attachModel3'
        ')';
  }
}
