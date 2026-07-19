class GameObjectDisplayInfoEntity {
  final int id;
  final String modelName;
  final int sound0;
  final int sound1;
  final int sound2;
  final int sound3;
  final int sound4;
  final int sound5;
  final int sound6;
  final int sound7;
  final int sound8;
  final int sound9;
  final double geoBoxMin0;
  final double geoBoxMin1;
  final double geoBoxMin2;
  final double geoBoxMax0;
  final double geoBoxMax1;
  final double geoBoxMax2;
  final int objectEffectPackageId;

  const GameObjectDisplayInfoEntity({
    this.id = 0,
    this.modelName = '',
    this.sound0 = 0,
    this.sound1 = 0,
    this.sound2 = 0,
    this.sound3 = 0,
    this.sound4 = 0,
    this.sound5 = 0,
    this.sound6 = 0,
    this.sound7 = 0,
    this.sound8 = 0,
    this.sound9 = 0,
    this.geoBoxMin0 = 0,
    this.geoBoxMin1 = 0,
    this.geoBoxMin2 = 0,
    this.geoBoxMax0 = 0,
    this.geoBoxMax1 = 0,
    this.geoBoxMax2 = 0,
    this.objectEffectPackageId = 0,
  });

  factory GameObjectDisplayInfoEntity.fromJson(Map<String, dynamic> json) {
    double d(String key) => (json[key] ?? 0).toDouble();
    return GameObjectDisplayInfoEntity(
      id: json['ID'] ?? 0,
      modelName: json['ModelName'] ?? '',
      sound0: json['Sound0'] ?? 0,
      sound1: json['Sound1'] ?? 0,
      sound2: json['Sound2'] ?? 0,
      sound3: json['Sound3'] ?? 0,
      sound4: json['Sound4'] ?? 0,
      sound5: json['Sound5'] ?? 0,
      sound6: json['Sound6'] ?? 0,
      sound7: json['Sound7'] ?? 0,
      sound8: json['Sound8'] ?? 0,
      sound9: json['Sound9'] ?? 0,
      geoBoxMin0: d('GeoBoxMin0'),
      geoBoxMin1: d('GeoBoxMin1'),
      geoBoxMin2: d('GeoBoxMin2'),
      geoBoxMax0: d('GeoBoxMax0'),
      geoBoxMax1: d('GeoBoxMax1'),
      geoBoxMax2: d('GeoBoxMax2'),
      objectEffectPackageId: json['ObjectEffectPackageID'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'ModelName': modelName,
    'Sound0': sound0,
    'Sound1': sound1,
    'Sound2': sound2,
    'Sound3': sound3,
    'Sound4': sound4,
    'Sound5': sound5,
    'Sound6': sound6,
    'Sound7': sound7,
    'Sound8': sound8,
    'Sound9': sound9,
    'GeoBoxMin0': geoBoxMin0,
    'GeoBoxMin1': geoBoxMin1,
    'GeoBoxMin2': geoBoxMin2,
    'GeoBoxMax0': geoBoxMax0,
    'GeoBoxMax1': geoBoxMax1,
    'GeoBoxMax2': geoBoxMax2,
    'ObjectEffectPackageID': objectEffectPackageId,
  };
}
