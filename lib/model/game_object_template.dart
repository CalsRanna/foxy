class BriefGameObjectTemplate {
  int entry = 0;
  String name = '';
  String localeName = '';
  int type = 0;
  double size = 0;

  BriefGameObjectTemplate();

  BriefGameObjectTemplate.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? 0;
    name = json['name'] ?? '';
    localeName = json['Name'] ?? '';
    type = json['type'] ?? 0;
    size = json['size'] ?? 0.0;
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;
}

class GameObjectTemplate {
  int entry = 0;
  int type = 0;
  int displayId = 0;
  String name = '';
  String iconName = '';
  String castBarCaption = '';
  String unk1 = '';
  double size = 1.0;
  int data0 = 0;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;
  int data7 = 0;
  int data8 = 0;
  int data9 = 0;
  int data10 = 0;
  int data11 = 0;
  int data12 = 0;
  int data13 = 0;
  int data14 = 0;
  int data15 = 0;
  int data16 = 0;
  int data17 = 0;
  int data18 = 0;
  int data19 = 0;
  int data20 = 0;
  int data21 = 0;
  int data22 = 0;
  int data23 = 0;
  String aiName = '';
  String scriptName = '';
  int verifiedBuild = 0;

  GameObjectTemplate();

  GameObjectTemplate.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? 0;
    type = json['type'] ?? 0;
    displayId = json['displayId'] ?? 0;
    name = json['name'] ?? '';
    iconName = json['IconName'] ?? '';
    castBarCaption = json['castBarCaption'] ?? '';
    unk1 = json['unk1'] ?? '';
    size = json['size'] ?? 1.0;
    data0 = json['Data0'] ?? 0;
    data1 = json['Data1'] ?? 0;
    data2 = json['Data2'] ?? 0;
    data3 = json['Data3'] ?? 0;
    data4 = json['Data4'] ?? 0;
    data5 = json['Data5'] ?? 0;
    data6 = json['Data6'] ?? 0;
    data7 = json['Data7'] ?? 0;
    data8 = json['Data8'] ?? 0;
    data9 = json['Data9'] ?? 0;
    data10 = json['Data10'] ?? 0;
    data11 = json['Data11'] ?? 0;
    data12 = json['Data12'] ?? 0;
    data13 = json['Data13'] ?? 0;
    data14 = json['Data14'] ?? 0;
    data15 = json['Data15'] ?? 0;
    data16 = json['Data16'] ?? 0;
    data17 = json['Data17'] ?? 0;
    data18 = json['Data18'] ?? 0;
    data19 = json['Data19'] ?? 0;
    data20 = json['Data20'] ?? 0;
    data21 = json['Data21'] ?? 0;
    data22 = json['Data22'] ?? 0;
    data23 = json['Data23'] ?? 0;
    aiName = json['AIName'] ?? '';
    scriptName = json['ScriptName'] ?? '';
    verifiedBuild = json['VerifiedBuild'] ?? 0;
  }

  GameObjectTemplate copyWith({int? entry}) {
    return GameObjectTemplate()..entry = entry ?? this.entry;
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'type': type,
      'displayId': displayId,
      'name': name,
      'IconName': iconName,
      'castBarCaption': castBarCaption,
      'unk1': unk1,
      'size': size,
      'Data0': data0,
      'Data1': data1,
      'Data2': data2,
      'Data3': data3,
      'Data4': data4,
      'Data5': data5,
      'Data6': data6,
      'Data7': data7,
      'Data8': data8,
      'Data9': data9,
      'Data10': data10,
      'Data11': data11,
      'Data12': data12,
      'Data13': data13,
      'Data14': data14,
      'Data15': data15,
      'Data16': data16,
      'Data17': data17,
      'Data18': data18,
      'Data19': data19,
      'Data20': data20,
      'Data21': data21,
      'Data22': data22,
      'Data23': data23,
      'AIName': aiName,
      'ScriptName': scriptName,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
