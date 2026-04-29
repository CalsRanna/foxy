class MapInfo {
  final int id;
  final String mapNameLangZhCn;
  final String mapDescription0LangZhCn;
  final int instanceType;
  final int pvp;

  const MapInfo({
    this.id = 0,
    this.mapNameLangZhCn = '',
    this.mapDescription0LangZhCn = '',
    this.instanceType = 0,
    this.pvp = 0,
  });

  factory MapInfo.fromJson(Map<String, dynamic> json) {
    return MapInfo(
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
}
