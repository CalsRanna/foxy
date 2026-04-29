class MapInfo {
  int id = 0;
  String mapNameLangZhCn = '';
  String mapDescription0LangZhCn = '';
  int instanceType = 0;
  int pvp = 0;

  MapInfo();

  factory MapInfo.fromJson(Map<String, dynamic> json) {
    return MapInfo()
      ..id = json['ID'] ?? 0
      ..mapNameLangZhCn = json['MapName_lang_zhCN'] ?? ''
      ..mapDescription0LangZhCn = json['MapDescription0_lang_zhCN'] ?? ''
      ..instanceType = json['InstanceType'] ?? 0
      ..pvp = json['PVP'] ?? 0;
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
