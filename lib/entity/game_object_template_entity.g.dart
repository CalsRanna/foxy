// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_entity.dart';

mixin _GameObjectTemplateEntityMixin {
  int get entry;
  int get type;
  int get displayId;
  String get name;
  String get iconName;
  String get castBarCaption;
  String get unk1;
  double get size;
  int get data0;
  int get data1;
  int get data2;
  int get data3;
  int get data4;
  int get data5;
  int get data6;
  int get data7;
  int get data8;
  int get data9;
  int get data10;
  int get data11;
  int get data12;
  int get data13;
  int get data14;
  int get data15;
  int get data16;
  int get data17;
  int get data18;
  int get data19;
  int get data20;
  int get data21;
  int get data22;
  int get data23;
  String get aiName;
  String get scriptName;
  int get verifiedBuild;

  static GameObjectTemplateEntity fromJson(Map<String, dynamic> json) {
    return GameObjectTemplateEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
      displayId: (json['displayId'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      iconName: json['IconName']?.toString() ?? '',
      castBarCaption: json['castBarCaption']?.toString() ?? '',
      unk1: json['unk1']?.toString() ?? '',
      size: (json['size'] as num?)?.toDouble() ?? 1.0,
      data0: (json['Data0'] as num?)?.toInt() ?? 0,
      data1: (json['Data1'] as num?)?.toInt() ?? 0,
      data2: (json['Data2'] as num?)?.toInt() ?? 0,
      data3: (json['Data3'] as num?)?.toInt() ?? 0,
      data4: (json['Data4'] as num?)?.toInt() ?? 0,
      data5: (json['Data5'] as num?)?.toInt() ?? 0,
      data6: (json['Data6'] as num?)?.toInt() ?? 0,
      data7: (json['Data7'] as num?)?.toInt() ?? 0,
      data8: (json['Data8'] as num?)?.toInt() ?? 0,
      data9: (json['Data9'] as num?)?.toInt() ?? 0,
      data10: (json['Data10'] as num?)?.toInt() ?? 0,
      data11: (json['Data11'] as num?)?.toInt() ?? 0,
      data12: (json['Data12'] as num?)?.toInt() ?? 0,
      data13: (json['Data13'] as num?)?.toInt() ?? 0,
      data14: (json['Data14'] as num?)?.toInt() ?? 0,
      data15: (json['Data15'] as num?)?.toInt() ?? 0,
      data16: (json['Data16'] as num?)?.toInt() ?? 0,
      data17: (json['Data17'] as num?)?.toInt() ?? 0,
      data18: (json['Data18'] as num?)?.toInt() ?? 0,
      data19: (json['Data19'] as num?)?.toInt() ?? 0,
      data20: (json['Data20'] as num?)?.toInt() ?? 0,
      data21: (json['Data21'] as num?)?.toInt() ?? 0,
      data22: (json['Data22'] as num?)?.toInt() ?? 0,
      data23: (json['Data23'] as num?)?.toInt() ?? 0,
      aiName: json['AIName']?.toString() ?? '',
      scriptName: json['ScriptName']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  GameObjectTemplateEntity copyWith({
    int? entry,
    int? type,
    int? displayId,
    String? name,
    String? iconName,
    String? castBarCaption,
    String? unk1,
    double? size,
    int? data0,
    int? data1,
    int? data2,
    int? data3,
    int? data4,
    int? data5,
    int? data6,
    int? data7,
    int? data8,
    int? data9,
    int? data10,
    int? data11,
    int? data12,
    int? data13,
    int? data14,
    int? data15,
    int? data16,
    int? data17,
    int? data18,
    int? data19,
    int? data20,
    int? data21,
    int? data22,
    int? data23,
    String? aiName,
    String? scriptName,
    int? verifiedBuild,
  }) {
    return GameObjectTemplateEntity(
      entry: entry ?? this.entry,
      type: type ?? this.type,
      displayId: displayId ?? this.displayId,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      castBarCaption: castBarCaption ?? this.castBarCaption,
      unk1: unk1 ?? this.unk1,
      size: size ?? this.size,
      data0: data0 ?? this.data0,
      data1: data1 ?? this.data1,
      data2: data2 ?? this.data2,
      data3: data3 ?? this.data3,
      data4: data4 ?? this.data4,
      data5: data5 ?? this.data5,
      data6: data6 ?? this.data6,
      data7: data7 ?? this.data7,
      data8: data8 ?? this.data8,
      data9: data9 ?? this.data9,
      data10: data10 ?? this.data10,
      data11: data11 ?? this.data11,
      data12: data12 ?? this.data12,
      data13: data13 ?? this.data13,
      data14: data14 ?? this.data14,
      data15: data15 ?? this.data15,
      data16: data16 ?? this.data16,
      data17: data17 ?? this.data17,
      data18: data18 ?? this.data18,
      data19: data19 ?? this.data19,
      data20: data20 ?? this.data20,
      data21: data21 ?? this.data21,
      data22: data22 ?? this.data22,
      data23: data23 ?? this.data23,
      aiName: aiName ?? this.aiName,
      scriptName: scriptName ?? this.scriptName,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectTemplateEntity &&
            runtimeType == other.runtimeType &&
            entry == other.entry &&
            type == other.type &&
            displayId == other.displayId &&
            name == other.name &&
            iconName == other.iconName &&
            castBarCaption == other.castBarCaption &&
            unk1 == other.unk1 &&
            size == other.size &&
            data0 == other.data0 &&
            data1 == other.data1 &&
            data2 == other.data2 &&
            data3 == other.data3 &&
            data4 == other.data4 &&
            data5 == other.data5 &&
            data6 == other.data6 &&
            data7 == other.data7 &&
            data8 == other.data8 &&
            data9 == other.data9 &&
            data10 == other.data10 &&
            data11 == other.data11 &&
            data12 == other.data12 &&
            data13 == other.data13 &&
            data14 == other.data14 &&
            data15 == other.data15 &&
            data16 == other.data16 &&
            data17 == other.data17 &&
            data18 == other.data18 &&
            data19 == other.data19 &&
            data20 == other.data20 &&
            data21 == other.data21 &&
            data22 == other.data22 &&
            data23 == other.data23 &&
            aiName == other.aiName &&
            scriptName == other.scriptName &&
            verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      entry,
      type,
      displayId,
      name,
      iconName,
      castBarCaption,
      unk1,
      size,
      data0,
      data1,
      data2,
      data3,
      data4,
      data5,
      data6,
      data7,
      data8,
      data9,
      data10,
      data11,
      data12,
      data13,
      data14,
      data15,
      data16,
      data17,
      data18,
      data19,
      data20,
      data21,
      data22,
      data23,
      aiName,
      scriptName,
      verifiedBuild,
    ]);
  }

  @override
  String toString() {
    return 'GameObjectTemplateEntity('
        'entry: $entry, '
        'type: $type, '
        'displayId: $displayId, '
        'name: $name, '
        'iconName: $iconName, '
        'castBarCaption: $castBarCaption, '
        'unk1: $unk1, '
        'size: $size, '
        'data0: $data0, '
        'data1: $data1, '
        'data2: $data2, '
        'data3: $data3, '
        'data4: $data4, '
        'data5: $data5, '
        'data6: $data6, '
        'data7: $data7, '
        'data8: $data8, '
        'data9: $data9, '
        'data10: $data10, '
        'data11: $data11, '
        'data12: $data12, '
        'data13: $data13, '
        'data14: $data14, '
        'data15: $data15, '
        'data16: $data16, '
        'data17: $data17, '
        'data18: $data18, '
        'data19: $data19, '
        'data20: $data20, '
        'data21: $data21, '
        'data22: $data22, '
        'data23: $data23, '
        'aiName: $aiName, '
        'scriptName: $scriptName, '
        'verifiedBuild: $verifiedBuild'
        ')';
  }
}
