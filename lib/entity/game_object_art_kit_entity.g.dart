// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_art_kit_entity.dart';

mixin _GameObjectArtKitEntityMixin {
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
    final self = this as GameObjectArtKitEntity;
    return GameObjectArtKitEntity(
      id: id ?? self.id,
      textureVariation0: textureVariation0 ?? self.textureVariation0,
      textureVariation1: textureVariation1 ?? self.textureVariation1,
      textureVariation2: textureVariation2 ?? self.textureVariation2,
      attachModel0: attachModel0 ?? self.attachModel0,
      attachModel1: attachModel1 ?? self.attachModel1,
      attachModel2: attachModel2 ?? self.attachModel2,
      attachModel3: attachModel3 ?? self.attachModel3,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GameObjectArtKitEntity;
    return {
      'ID': self.id,
      'TextureVariation0': self.textureVariation0,
      'TextureVariation1': self.textureVariation1,
      'TextureVariation2': self.textureVariation2,
      'AttachModel0': self.attachModel0,
      'AttachModel1': self.attachModel1,
      'AttachModel2': self.attachModel2,
      'AttachModel3': self.attachModel3,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as GameObjectArtKitEntity;
    return identical(self, other) ||
        other is GameObjectArtKitEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.textureVariation0 == other.textureVariation0 &&
            self.textureVariation1 == other.textureVariation1 &&
            self.textureVariation2 == other.textureVariation2 &&
            self.attachModel0 == other.attachModel0 &&
            self.attachModel1 == other.attachModel1 &&
            self.attachModel2 == other.attachModel2 &&
            self.attachModel3 == other.attachModel3;
  }

  @override
  int get hashCode {
    final self = this as GameObjectArtKitEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.textureVariation0,
      self.textureVariation1,
      self.textureVariation2,
      self.attachModel0,
      self.attachModel1,
      self.attachModel2,
      self.attachModel3,
    ]);
  }

  @override
  String toString() {
    final self = this as GameObjectArtKitEntity;
    return 'GameObjectArtKitEntity('
        'id: ${self.id}, '
        'textureVariation0: ${self.textureVariation0}, '
        'textureVariation1: ${self.textureVariation1}, '
        'textureVariation2: ${self.textureVariation2}, '
        'attachModel0: ${self.attachModel0}, '
        'attachModel1: ${self.attachModel1}, '
        'attachModel2: ${self.attachModel2}, '
        'attachModel3: ${self.attachModel3}'
        ')';
  }
}
