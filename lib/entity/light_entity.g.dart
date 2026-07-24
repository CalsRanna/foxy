// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_entity.dart';

mixin _LightEntityMixin {
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
    final self = this as LightEntity;
    return LightEntity(
      id: id ?? self.id,
      continentId: continentId ?? self.continentId,
      gameCoords0: gameCoords0 ?? self.gameCoords0,
      gameCoords1: gameCoords1 ?? self.gameCoords1,
      gameCoords2: gameCoords2 ?? self.gameCoords2,
      gameFalloffStart: gameFalloffStart ?? self.gameFalloffStart,
      gameFalloffEnd: gameFalloffEnd ?? self.gameFalloffEnd,
      lightParamsId0: lightParamsId0 ?? self.lightParamsId0,
      lightParamsId1: lightParamsId1 ?? self.lightParamsId1,
      lightParamsId2: lightParamsId2 ?? self.lightParamsId2,
      lightParamsId3: lightParamsId3 ?? self.lightParamsId3,
      lightParamsId4: lightParamsId4 ?? self.lightParamsId4,
      lightParamsId5: lightParamsId5 ?? self.lightParamsId5,
      lightParamsId6: lightParamsId6 ?? self.lightParamsId6,
      lightParamsId7: lightParamsId7 ?? self.lightParamsId7,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as LightEntity;
    return {
      'ID': self.id,
      'ContinentID': self.continentId,
      'GameCoords0': self.gameCoords0,
      'GameCoords1': self.gameCoords1,
      'GameCoords2': self.gameCoords2,
      'GameFalloffStart': self.gameFalloffStart,
      'GameFalloffEnd': self.gameFalloffEnd,
      'LightParamsID0': self.lightParamsId0,
      'LightParamsID1': self.lightParamsId1,
      'LightParamsID2': self.lightParamsId2,
      'LightParamsID3': self.lightParamsId3,
      'LightParamsID4': self.lightParamsId4,
      'LightParamsID5': self.lightParamsId5,
      'LightParamsID6': self.lightParamsId6,
      'LightParamsID7': self.lightParamsId7,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as LightEntity;
    return identical(self, other) ||
        other is LightEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.continentId == other.continentId &&
            self.gameCoords0 == other.gameCoords0 &&
            self.gameCoords1 == other.gameCoords1 &&
            self.gameCoords2 == other.gameCoords2 &&
            self.gameFalloffStart == other.gameFalloffStart &&
            self.gameFalloffEnd == other.gameFalloffEnd &&
            self.lightParamsId0 == other.lightParamsId0 &&
            self.lightParamsId1 == other.lightParamsId1 &&
            self.lightParamsId2 == other.lightParamsId2 &&
            self.lightParamsId3 == other.lightParamsId3 &&
            self.lightParamsId4 == other.lightParamsId4 &&
            self.lightParamsId5 == other.lightParamsId5 &&
            self.lightParamsId6 == other.lightParamsId6 &&
            self.lightParamsId7 == other.lightParamsId7;
  }

  @override
  int get hashCode {
    final self = this as LightEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.continentId,
      self.gameCoords0,
      self.gameCoords1,
      self.gameCoords2,
      self.gameFalloffStart,
      self.gameFalloffEnd,
      self.lightParamsId0,
      self.lightParamsId1,
      self.lightParamsId2,
      self.lightParamsId3,
      self.lightParamsId4,
      self.lightParamsId5,
      self.lightParamsId6,
      self.lightParamsId7,
    ]);
  }

  @override
  String toString() {
    final self = this as LightEntity;
    return 'LightEntity('
        'id: ${self.id}, '
        'continentId: ${self.continentId}, '
        'gameCoords0: ${self.gameCoords0}, '
        'gameCoords1: ${self.gameCoords1}, '
        'gameCoords2: ${self.gameCoords2}, '
        'gameFalloffStart: ${self.gameFalloffStart}, '
        'gameFalloffEnd: ${self.gameFalloffEnd}, '
        'lightParamsId0: ${self.lightParamsId0}, '
        'lightParamsId1: ${self.lightParamsId1}, '
        'lightParamsId2: ${self.lightParamsId2}, '
        'lightParamsId3: ${self.lightParamsId3}, '
        'lightParamsId4: ${self.lightParamsId4}, '
        'lightParamsId5: ${self.lightParamsId5}, '
        'lightParamsId6: ${self.lightParamsId6}, '
        'lightParamsId7: ${self.lightParamsId7}'
        ')';
  }
}
