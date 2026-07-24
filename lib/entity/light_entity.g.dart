// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_entity.dart';

mixin _LightEntityMixin {
  int get id;
  int get continentId;
  double get gameCoords0;
  double get gameCoords1;
  double get gameCoords2;
  double get gameFalloffStart;
  double get gameFalloffEnd;
  int get lightParamsId0;
  int get lightParamsId1;
  int get lightParamsId2;
  int get lightParamsId3;
  int get lightParamsId4;
  int get lightParamsId5;
  int get lightParamsId6;
  int get lightParamsId7;

  static LightEntity fromJson(Map<String, dynamic> json) {
    return LightEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      continentId: (json['ContinentID'] as num?)?.toInt() ?? 0,
      gameCoords0: (json['GameCoords0'] as num?)?.toDouble() ?? 0.0,
      gameCoords1: (json['GameCoords1'] as num?)?.toDouble() ?? 0.0,
      gameCoords2: (json['GameCoords2'] as num?)?.toDouble() ?? 0.0,
      gameFalloffStart: (json['GameFalloffStart'] as num?)?.toDouble() ?? 0.0,
      gameFalloffEnd: (json['GameFalloffEnd'] as num?)?.toDouble() ?? 0.0,
      lightParamsId0: (json['LightParamsID0'] as num?)?.toInt() ?? 0,
      lightParamsId1: (json['LightParamsID1'] as num?)?.toInt() ?? 0,
      lightParamsId2: (json['LightParamsID2'] as num?)?.toInt() ?? 0,
      lightParamsId3: (json['LightParamsID3'] as num?)?.toInt() ?? 0,
      lightParamsId4: (json['LightParamsID4'] as num?)?.toInt() ?? 0,
      lightParamsId5: (json['LightParamsID5'] as num?)?.toInt() ?? 0,
      lightParamsId6: (json['LightParamsID6'] as num?)?.toInt() ?? 0,
      lightParamsId7: (json['LightParamsID7'] as num?)?.toInt() ?? 0,
    );
  }

  LightEntity copyWith({
    int? id,
    int? continentId,
    double? gameCoords0,
    double? gameCoords1,
    double? gameCoords2,
    double? gameFalloffStart,
    double? gameFalloffEnd,
    int? lightParamsId0,
    int? lightParamsId1,
    int? lightParamsId2,
    int? lightParamsId3,
    int? lightParamsId4,
    int? lightParamsId5,
    int? lightParamsId6,
    int? lightParamsId7,
  }) {
    return LightEntity(
      id: id ?? this.id,
      continentId: continentId ?? this.continentId,
      gameCoords0: gameCoords0 ?? this.gameCoords0,
      gameCoords1: gameCoords1 ?? this.gameCoords1,
      gameCoords2: gameCoords2 ?? this.gameCoords2,
      gameFalloffStart: gameFalloffStart ?? this.gameFalloffStart,
      gameFalloffEnd: gameFalloffEnd ?? this.gameFalloffEnd,
      lightParamsId0: lightParamsId0 ?? this.lightParamsId0,
      lightParamsId1: lightParamsId1 ?? this.lightParamsId1,
      lightParamsId2: lightParamsId2 ?? this.lightParamsId2,
      lightParamsId3: lightParamsId3 ?? this.lightParamsId3,
      lightParamsId4: lightParamsId4 ?? this.lightParamsId4,
      lightParamsId5: lightParamsId5 ?? this.lightParamsId5,
      lightParamsId6: lightParamsId6 ?? this.lightParamsId6,
      lightParamsId7: lightParamsId7 ?? this.lightParamsId7,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LightEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            continentId == other.continentId &&
            gameCoords0 == other.gameCoords0 &&
            gameCoords1 == other.gameCoords1 &&
            gameCoords2 == other.gameCoords2 &&
            gameFalloffStart == other.gameFalloffStart &&
            gameFalloffEnd == other.gameFalloffEnd &&
            lightParamsId0 == other.lightParamsId0 &&
            lightParamsId1 == other.lightParamsId1 &&
            lightParamsId2 == other.lightParamsId2 &&
            lightParamsId3 == other.lightParamsId3 &&
            lightParamsId4 == other.lightParamsId4 &&
            lightParamsId5 == other.lightParamsId5 &&
            lightParamsId6 == other.lightParamsId6 &&
            lightParamsId7 == other.lightParamsId7;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      continentId,
      gameCoords0,
      gameCoords1,
      gameCoords2,
      gameFalloffStart,
      gameFalloffEnd,
      lightParamsId0,
      lightParamsId1,
      lightParamsId2,
      lightParamsId3,
      lightParamsId4,
      lightParamsId5,
      lightParamsId6,
      lightParamsId7,
    ]);
  }

  @override
  String toString() {
    return 'LightEntity('
        'id: $id, '
        'continentId: $continentId, '
        'gameCoords0: $gameCoords0, '
        'gameCoords1: $gameCoords1, '
        'gameCoords2: $gameCoords2, '
        'gameFalloffStart: $gameFalloffStart, '
        'gameFalloffEnd: $gameFalloffEnd, '
        'lightParamsId0: $lightParamsId0, '
        'lightParamsId1: $lightParamsId1, '
        'lightParamsId2: $lightParamsId2, '
        'lightParamsId3: $lightParamsId3, '
        'lightParamsId4: $lightParamsId4, '
        'lightParamsId5: $lightParamsId5, '
        'lightParamsId6: $lightParamsId6, '
        'lightParamsId7: $lightParamsId7'
        ')';
  }
}
