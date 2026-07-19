import 'package:foxy/entity/game_object_art_kit_key.dart';

class BriefGameObjectArtKitEntity {
  final int id;
  final String textureVariation0;
  final String attachModel0;

  const BriefGameObjectArtKitEntity({
    this.id = 0,
    this.textureVariation0 = '',
    this.attachModel0 = '',
  });

  factory BriefGameObjectArtKitEntity.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectArtKitEntity(
      id: json['ID'] ?? 0,
      textureVariation0: json['TextureVariation0'] ?? '',
      attachModel0: json['AttachModel0'] ?? '',
    );
  }

  GameObjectArtKitKey get key => GameObjectArtKitKey(id: id);
}
