class BriefGameObjectTemplateEntity {
  final int entry;
  final String name;
  final String localeName;
  final int type;
  final double size;

  const BriefGameObjectTemplateEntity({
    this.entry = 0,
    this.name = '',
    this.localeName = '',
    this.type = 0,
    this.size = 0,
  });

  factory BriefGameObjectTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectTemplateEntity(
      entry: json['entry'] ?? 0,
      name: json['name'] ?? '',
      localeName: json['Name'] ?? '',
      type: json['type'] ?? 0,
      size: json['size'] ?? 0.0,
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'name': name,
      'Name': localeName,
      'type': type,
      'size': size,
    };
  }
}

class GameObjectTemplate {
  final int entry;
  final int type;
  final int displayId;
  final String name;
  final String iconName;
  final String castBarCaption;
  final String unk1;
  final double size;
  final int data0;
  final int data1;
  final int data2;
  final int data3;
  final int data4;
  final int data5;
  final int data6;
  final int data7;
  final int data8;
  final int data9;
  final int data10;
  final int data11;
  final int data12;
  final int data13;
  final int data14;
  final int data15;
  final int data16;
  final int data17;
  final int data18;
  final int data19;
  final int data20;
  final int data21;
  final int data22;
  final int data23;
  final String aiName;
  final String scriptName;
  final int verifiedBuild;

  const GameObjectTemplate({
    this.entry = 0,
    this.type = 0,
    this.displayId = 0,
    this.name = '',
    this.iconName = '',
    this.castBarCaption = '',
    this.unk1 = '',
    this.size = 1.0,
    this.data0 = 0,
    this.data1 = 0,
    this.data2 = 0,
    this.data3 = 0,
    this.data4 = 0,
    this.data5 = 0,
    this.data6 = 0,
    this.data7 = 0,
    this.data8 = 0,
    this.data9 = 0,
    this.data10 = 0,
    this.data11 = 0,
    this.data12 = 0,
    this.data13 = 0,
    this.data14 = 0,
    this.data15 = 0,
    this.data16 = 0,
    this.data17 = 0,
    this.data18 = 0,
    this.data19 = 0,
    this.data20 = 0,
    this.data21 = 0,
    this.data22 = 0,
    this.data23 = 0,
    this.aiName = '',
    this.scriptName = '',
    this.verifiedBuild = 0,
  });

  factory GameObjectTemplate.fromJson(Map<String, dynamic> json) {
    return GameObjectTemplate(
      entry: json['entry'] ?? 0,
      type: json['type'] ?? 0,
      displayId: json['displayId'] ?? 0,
      name: json['name'] ?? '',
      iconName: json['IconName'] ?? '',
      castBarCaption: json['castBarCaption'] ?? '',
      unk1: json['unk1'] ?? '',
      size: json['size'] ?? 1.0,
      data0: json['Data0'] ?? 0,
      data1: json['Data1'] ?? 0,
      data2: json['Data2'] ?? 0,
      data3: json['Data3'] ?? 0,
      data4: json['Data4'] ?? 0,
      data5: json['Data5'] ?? 0,
      data6: json['Data6'] ?? 0,
      data7: json['Data7'] ?? 0,
      data8: json['Data8'] ?? 0,
      data9: json['Data9'] ?? 0,
      data10: json['Data10'] ?? 0,
      data11: json['Data11'] ?? 0,
      data12: json['Data12'] ?? 0,
      data13: json['Data13'] ?? 0,
      data14: json['Data14'] ?? 0,
      data15: json['Data15'] ?? 0,
      data16: json['Data16'] ?? 0,
      data17: json['Data17'] ?? 0,
      data18: json['Data18'] ?? 0,
      data19: json['Data19'] ?? 0,
      data20: json['Data20'] ?? 0,
      data21: json['Data21'] ?? 0,
      data22: json['Data22'] ?? 0,
      data23: json['Data23'] ?? 0,
      aiName: json['AIName'] ?? '',
      scriptName: json['ScriptName'] ?? '',
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
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
