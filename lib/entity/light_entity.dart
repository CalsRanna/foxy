class LightEntity {
  final int id;
  final int continentId;
  final double gameCoords0;
  final double gameCoords1;
  final double gameCoords2;
  final double gameFalloffStart;
  final double gameFalloffEnd;
  final int lightParamsId0;
  final int lightParamsId1;
  final int lightParamsId2;
  final int lightParamsId3;
  final int lightParamsId4;
  final int lightParamsId5;
  final int lightParamsId6;
  final int lightParamsId7;

  const LightEntity({
    this.id = 0,
    this.continentId = 0,
    this.gameCoords0 = 0.0,
    this.gameCoords1 = 0.0,
    this.gameCoords2 = 0.0,
    this.gameFalloffStart = 0.0,
    this.gameFalloffEnd = 0.0,
    this.lightParamsId0 = 0,
    this.lightParamsId1 = 0,
    this.lightParamsId2 = 0,
    this.lightParamsId3 = 0,
    this.lightParamsId4 = 0,
    this.lightParamsId5 = 0,
    this.lightParamsId6 = 0,
    this.lightParamsId7 = 0,
  });

  factory LightEntity.fromJson(Map<String, dynamic> json) => LightEntity(
    id: json['ID'] ?? 0,
    continentId: json['ContinentID'] ?? 0,
    gameCoords0: (json['GameCoords0'] as num?)?.toDouble() ?? 0.0,
    gameCoords1: (json['GameCoords1'] as num?)?.toDouble() ?? 0.0,
    gameCoords2: (json['GameCoords2'] as num?)?.toDouble() ?? 0.0,
    gameFalloffStart: (json['GameFalloffStart'] as num?)?.toDouble() ?? 0.0,
    gameFalloffEnd: (json['GameFalloffEnd'] as num?)?.toDouble() ?? 0.0,
    lightParamsId0: json['LightParamsID0'] ?? 0,
    lightParamsId1: json['LightParamsID1'] ?? 0,
    lightParamsId2: json['LightParamsID2'] ?? 0,
    lightParamsId3: json['LightParamsID3'] ?? 0,
    lightParamsId4: json['LightParamsID4'] ?? 0,
    lightParamsId5: json['LightParamsID5'] ?? 0,
    lightParamsId6: json['LightParamsID6'] ?? 0,
    lightParamsId7: json['LightParamsID7'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'ID': id,
    'ContinentID': continentId,
    'GameCoords0': gameCoords0,
    'GameCoords1': gameCoords1,
    'GameCoords2': gameCoords2,
    'GameFalloffStart': gameFalloffStart,
    'GameFalloffEnd': gameFalloffEnd,
    'LightParamsID0': lightParamsId0,
    'LightParamsID1': lightParamsId1,
    'LightParamsID2': lightParamsId2,
    'LightParamsID3': lightParamsId3,
    'LightParamsID4': lightParamsId4,
    'LightParamsID5': lightParamsId5,
    'LightParamsID6': lightParamsId6,
    'LightParamsID7': lightParamsId7,
  };
}

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

  factory BriefLightEntity.fromJson(Map<String, dynamic> json) =>
      BriefLightEntity(
        id: json['ID'] ?? 0,
        continentId: json['ContinentID'] ?? 0,
        gameCoords0: (json['GameCoords0'] as num?)?.toDouble() ?? 0.0,
        gameCoords1: (json['GameCoords1'] as num?)?.toDouble() ?? 0.0,
        gameCoords2: (json['GameCoords2'] as num?)?.toDouble() ?? 0.0,
      );
}
