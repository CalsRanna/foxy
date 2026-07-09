class MapInfoEntity {
  final int id;
  final String mapNameLangZhCn;
  final String mapDescription0LangZhCn;
  final int instanceType;
  final int pvp;

  const MapInfoEntity({
    this.id = 0,
    this.mapNameLangZhCn = '',
    this.mapDescription0LangZhCn = '',
    this.instanceType = 0,
    this.pvp = 0,
  });

  factory MapInfoEntity.fromJson(Map<String, dynamic> json) {
    return MapInfoEntity(
      id: json['ID'] ?? 0,
      mapNameLangZhCn: json['MapName_lang_zhCN'] ?? '',
      mapDescription0LangZhCn: json['MapDescription0_lang_zhCN'] ?? '',
      instanceType: json['InstanceType'] ?? 0,
      pvp: json['PVP'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'MapName_lang_zhCN': mapNameLangZhCn,
      'MapDescription0_lang_zhCN': mapDescription0LangZhCn,
      'InstanceType': instanceType,
      'PVP': pvp,
    };
  }

  MapInfoEntity copyWith({
    int? id,
    String? mapNameLangZhCn,
    String? mapDescription0LangZhCn,
    int? instanceType,
    int? pvp,
  }) {
    return MapInfoEntity(
      id: id ?? this.id,
      mapNameLangZhCn: mapNameLangZhCn ?? this.mapNameLangZhCn,
      mapDescription0LangZhCn:
          mapDescription0LangZhCn ?? this.mapDescription0LangZhCn,
      instanceType: instanceType ?? this.instanceType,
      pvp: pvp ?? this.pvp,
    );
  }
}

/// 地图列表/Picker 展示模型
class BriefMapInfoEntity {
  final int id;
  final String mapNameLangZhCn;
  final int instanceType;
  final int pvp;

  const BriefMapInfoEntity({
    this.id = 0,
    this.mapNameLangZhCn = '',
    this.instanceType = 0,
    this.pvp = 0,
  });

  factory BriefMapInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefMapInfoEntity(
      id: json['ID'] ?? 0,
      mapNameLangZhCn: json['MapName_lang_zhCN'] ?? '',
      instanceType: json['InstanceType'] ?? 0,
      pvp: json['PVP'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'MapName_lang_zhCN': mapNameLangZhCn,
      'InstanceType': instanceType,
      'PVP': pvp,
    };
  }

  BriefMapInfoEntity copyWith({
    int? id,
    String? mapNameLangZhCn,
    int? instanceType,
    int? pvp,
  }) {
    return BriefMapInfoEntity(
      id: id ?? this.id,
      mapNameLangZhCn: mapNameLangZhCn ?? this.mapNameLangZhCn,
      instanceType: instanceType ?? this.instanceType,
      pvp: pvp ?? this.pvp,
    );
  }
}
