import 'package:foxy/entity/light_key.dart';

class BriefLightEntity {
  final int id;
  final int continentId;
  final double gameCoords0;
  final double gameCoords1;
  final double gameCoords2;

  const BriefLightEntity({
    this.id = 0,
    this.continentId = 0,
    this.gameCoords0 = 0.0,
    this.gameCoords1 = 0.0,
    this.gameCoords2 = 0.0,
  });

  factory BriefLightEntity.fromJson(Map<String, dynamic> json) {
    return BriefLightEntity(
      id: json['ID'] ?? 0,
      continentId: json['ContinentID'] ?? 0,
      gameCoords0: (json['GameCoords0'] as num?)?.toDouble() ?? 0.0,
      gameCoords1: (json['GameCoords1'] as num?)?.toDouble() ?? 0.0,
      gameCoords2: (json['GameCoords2'] as num?)?.toDouble() ?? 0.0,
    );
  }

  LightKey get key => LightKey(id: id);
}
