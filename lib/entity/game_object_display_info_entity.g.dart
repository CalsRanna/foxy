// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_display_info_entity.dart';

mixin _GameObjectDisplayInfoEntityMixin {
  static GameObjectDisplayInfoEntity fromJson(Map<String, dynamic> json) {
    return GameObjectDisplayInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      modelName: json['ModelName']?.toString() ?? '',
      sound0: (json['Sound0'] as num?)?.toInt() ?? 0,
      sound1: (json['Sound1'] as num?)?.toInt() ?? 0,
      sound2: (json['Sound2'] as num?)?.toInt() ?? 0,
      sound3: (json['Sound3'] as num?)?.toInt() ?? 0,
      sound4: (json['Sound4'] as num?)?.toInt() ?? 0,
      sound5: (json['Sound5'] as num?)?.toInt() ?? 0,
      sound6: (json['Sound6'] as num?)?.toInt() ?? 0,
      sound7: (json['Sound7'] as num?)?.toInt() ?? 0,
      sound8: (json['Sound8'] as num?)?.toInt() ?? 0,
      sound9: (json['Sound9'] as num?)?.toInt() ?? 0,
      geoBoxMin0: (json['GeoBoxMin0'] as num?)?.toDouble() ?? 0.0,
      geoBoxMin1: (json['GeoBoxMin1'] as num?)?.toDouble() ?? 0.0,
      geoBoxMin2: (json['GeoBoxMin2'] as num?)?.toDouble() ?? 0.0,
      geoBoxMax0: (json['GeoBoxMax0'] as num?)?.toDouble() ?? 0.0,
      geoBoxMax1: (json['GeoBoxMax1'] as num?)?.toDouble() ?? 0.0,
      geoBoxMax2: (json['GeoBoxMax2'] as num?)?.toDouble() ?? 0.0,
      objectEffectPackageId:
          (json['ObjectEffectPackageID'] as num?)?.toInt() ?? 0,
    );
  }

  GameObjectDisplayInfoEntity copyWith({
    int? id,
    String? modelName,
    int? sound0,
    int? sound1,
    int? sound2,
    int? sound3,
    int? sound4,
    int? sound5,
    int? sound6,
    int? sound7,
    int? sound8,
    int? sound9,
    double? geoBoxMin0,
    double? geoBoxMin1,
    double? geoBoxMin2,
    double? geoBoxMax0,
    double? geoBoxMax1,
    double? geoBoxMax2,
    int? objectEffectPackageId,
  }) {
    final self = this as GameObjectDisplayInfoEntity;
    return GameObjectDisplayInfoEntity(
      id: id ?? self.id,
      modelName: modelName ?? self.modelName,
      sound0: sound0 ?? self.sound0,
      sound1: sound1 ?? self.sound1,
      sound2: sound2 ?? self.sound2,
      sound3: sound3 ?? self.sound3,
      sound4: sound4 ?? self.sound4,
      sound5: sound5 ?? self.sound5,
      sound6: sound6 ?? self.sound6,
      sound7: sound7 ?? self.sound7,
      sound8: sound8 ?? self.sound8,
      sound9: sound9 ?? self.sound9,
      geoBoxMin0: geoBoxMin0 ?? self.geoBoxMin0,
      geoBoxMin1: geoBoxMin1 ?? self.geoBoxMin1,
      geoBoxMin2: geoBoxMin2 ?? self.geoBoxMin2,
      geoBoxMax0: geoBoxMax0 ?? self.geoBoxMax0,
      geoBoxMax1: geoBoxMax1 ?? self.geoBoxMax1,
      geoBoxMax2: geoBoxMax2 ?? self.geoBoxMax2,
      objectEffectPackageId:
          objectEffectPackageId ?? self.objectEffectPackageId,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GameObjectDisplayInfoEntity;
    return {
      'ID': self.id,
      'ModelName': self.modelName,
      'Sound0': self.sound0,
      'Sound1': self.sound1,
      'Sound2': self.sound2,
      'Sound3': self.sound3,
      'Sound4': self.sound4,
      'Sound5': self.sound5,
      'Sound6': self.sound6,
      'Sound7': self.sound7,
      'Sound8': self.sound8,
      'Sound9': self.sound9,
      'GeoBoxMin0': self.geoBoxMin0,
      'GeoBoxMin1': self.geoBoxMin1,
      'GeoBoxMin2': self.geoBoxMin2,
      'GeoBoxMax0': self.geoBoxMax0,
      'GeoBoxMax1': self.geoBoxMax1,
      'GeoBoxMax2': self.geoBoxMax2,
      'ObjectEffectPackageID': self.objectEffectPackageId,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as GameObjectDisplayInfoEntity;
    return identical(self, other) ||
        other is GameObjectDisplayInfoEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.modelName == other.modelName &&
            self.sound0 == other.sound0 &&
            self.sound1 == other.sound1 &&
            self.sound2 == other.sound2 &&
            self.sound3 == other.sound3 &&
            self.sound4 == other.sound4 &&
            self.sound5 == other.sound5 &&
            self.sound6 == other.sound6 &&
            self.sound7 == other.sound7 &&
            self.sound8 == other.sound8 &&
            self.sound9 == other.sound9 &&
            self.geoBoxMin0 == other.geoBoxMin0 &&
            self.geoBoxMin1 == other.geoBoxMin1 &&
            self.geoBoxMin2 == other.geoBoxMin2 &&
            self.geoBoxMax0 == other.geoBoxMax0 &&
            self.geoBoxMax1 == other.geoBoxMax1 &&
            self.geoBoxMax2 == other.geoBoxMax2 &&
            self.objectEffectPackageId == other.objectEffectPackageId;
  }

  @override
  int get hashCode {
    final self = this as GameObjectDisplayInfoEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.modelName,
      self.sound0,
      self.sound1,
      self.sound2,
      self.sound3,
      self.sound4,
      self.sound5,
      self.sound6,
      self.sound7,
      self.sound8,
      self.sound9,
      self.geoBoxMin0,
      self.geoBoxMin1,
      self.geoBoxMin2,
      self.geoBoxMax0,
      self.geoBoxMax1,
      self.geoBoxMax2,
      self.objectEffectPackageId,
    ]);
  }

  @override
  String toString() {
    final self = this as GameObjectDisplayInfoEntity;
    return 'GameObjectDisplayInfoEntity('
        'id: ${self.id}, '
        'modelName: ${self.modelName}, '
        'sound0: ${self.sound0}, '
        'sound1: ${self.sound1}, '
        'sound2: ${self.sound2}, '
        'sound3: ${self.sound3}, '
        'sound4: ${self.sound4}, '
        'sound5: ${self.sound5}, '
        'sound6: ${self.sound6}, '
        'sound7: ${self.sound7}, '
        'sound8: ${self.sound8}, '
        'sound9: ${self.sound9}, '
        'geoBoxMin0: ${self.geoBoxMin0}, '
        'geoBoxMin1: ${self.geoBoxMin1}, '
        'geoBoxMin2: ${self.geoBoxMin2}, '
        'geoBoxMax0: ${self.geoBoxMax0}, '
        'geoBoxMax1: ${self.geoBoxMax1}, '
        'geoBoxMax2: ${self.geoBoxMax2}, '
        'objectEffectPackageId: ${self.objectEffectPackageId}'
        ')';
  }
}

final class BriefGameObjectDisplayInfoEntity {
  final int id;
  final String modelName;

  const BriefGameObjectDisplayInfoEntity({this.id = 0, this.modelName = ''});

  factory BriefGameObjectDisplayInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectDisplayInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      modelName: json['ModelName']?.toString() ?? '',
    );
  }

  int get key => id;
}
