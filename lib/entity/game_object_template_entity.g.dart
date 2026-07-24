// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_entity.dart';

mixin _GameObjectTemplateEntityMixin {
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
    final self = this as GameObjectTemplateEntity;
    return GameObjectTemplateEntity(
      entry: entry ?? self.entry,
      type: type ?? self.type,
      displayId: displayId ?? self.displayId,
      name: name ?? self.name,
      iconName: iconName ?? self.iconName,
      castBarCaption: castBarCaption ?? self.castBarCaption,
      unk1: unk1 ?? self.unk1,
      size: size ?? self.size,
      data0: data0 ?? self.data0,
      data1: data1 ?? self.data1,
      data2: data2 ?? self.data2,
      data3: data3 ?? self.data3,
      data4: data4 ?? self.data4,
      data5: data5 ?? self.data5,
      data6: data6 ?? self.data6,
      data7: data7 ?? self.data7,
      data8: data8 ?? self.data8,
      data9: data9 ?? self.data9,
      data10: data10 ?? self.data10,
      data11: data11 ?? self.data11,
      data12: data12 ?? self.data12,
      data13: data13 ?? self.data13,
      data14: data14 ?? self.data14,
      data15: data15 ?? self.data15,
      data16: data16 ?? self.data16,
      data17: data17 ?? self.data17,
      data18: data18 ?? self.data18,
      data19: data19 ?? self.data19,
      data20: data20 ?? self.data20,
      data21: data21 ?? self.data21,
      data22: data22 ?? self.data22,
      data23: data23 ?? self.data23,
      aiName: aiName ?? self.aiName,
      scriptName: scriptName ?? self.scriptName,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GameObjectTemplateEntity;
    return {
      'entry': self.entry,
      'type': self.type,
      'displayId': self.displayId,
      'name': self.name,
      'IconName': self.iconName,
      'castBarCaption': self.castBarCaption,
      'unk1': self.unk1,
      'size': self.size,
      'Data0': self.data0,
      'Data1': self.data1,
      'Data2': self.data2,
      'Data3': self.data3,
      'Data4': self.data4,
      'Data5': self.data5,
      'Data6': self.data6,
      'Data7': self.data7,
      'Data8': self.data8,
      'Data9': self.data9,
      'Data10': self.data10,
      'Data11': self.data11,
      'Data12': self.data12,
      'Data13': self.data13,
      'Data14': self.data14,
      'Data15': self.data15,
      'Data16': self.data16,
      'Data17': self.data17,
      'Data18': self.data18,
      'Data19': self.data19,
      'Data20': self.data20,
      'Data21': self.data21,
      'Data22': self.data22,
      'Data23': self.data23,
      'AIName': self.aiName,
      'ScriptName': self.scriptName,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as GameObjectTemplateEntity;
    return identical(self, other) ||
        other is GameObjectTemplateEntity &&
            self.runtimeType == other.runtimeType &&
            self.entry == other.entry &&
            self.type == other.type &&
            self.displayId == other.displayId &&
            self.name == other.name &&
            self.iconName == other.iconName &&
            self.castBarCaption == other.castBarCaption &&
            self.unk1 == other.unk1 &&
            self.size == other.size &&
            self.data0 == other.data0 &&
            self.data1 == other.data1 &&
            self.data2 == other.data2 &&
            self.data3 == other.data3 &&
            self.data4 == other.data4 &&
            self.data5 == other.data5 &&
            self.data6 == other.data6 &&
            self.data7 == other.data7 &&
            self.data8 == other.data8 &&
            self.data9 == other.data9 &&
            self.data10 == other.data10 &&
            self.data11 == other.data11 &&
            self.data12 == other.data12 &&
            self.data13 == other.data13 &&
            self.data14 == other.data14 &&
            self.data15 == other.data15 &&
            self.data16 == other.data16 &&
            self.data17 == other.data17 &&
            self.data18 == other.data18 &&
            self.data19 == other.data19 &&
            self.data20 == other.data20 &&
            self.data21 == other.data21 &&
            self.data22 == other.data22 &&
            self.data23 == other.data23 &&
            self.aiName == other.aiName &&
            self.scriptName == other.scriptName &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as GameObjectTemplateEntity;
    return Object.hashAll([
      self.runtimeType,
      self.entry,
      self.type,
      self.displayId,
      self.name,
      self.iconName,
      self.castBarCaption,
      self.unk1,
      self.size,
      self.data0,
      self.data1,
      self.data2,
      self.data3,
      self.data4,
      self.data5,
      self.data6,
      self.data7,
      self.data8,
      self.data9,
      self.data10,
      self.data11,
      self.data12,
      self.data13,
      self.data14,
      self.data15,
      self.data16,
      self.data17,
      self.data18,
      self.data19,
      self.data20,
      self.data21,
      self.data22,
      self.data23,
      self.aiName,
      self.scriptName,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as GameObjectTemplateEntity;
    return 'GameObjectTemplateEntity('
        'entry: ${self.entry}, '
        'type: ${self.type}, '
        'displayId: ${self.displayId}, '
        'name: ${self.name}, '
        'iconName: ${self.iconName}, '
        'castBarCaption: ${self.castBarCaption}, '
        'unk1: ${self.unk1}, '
        'size: ${self.size}, '
        'data0: ${self.data0}, '
        'data1: ${self.data1}, '
        'data2: ${self.data2}, '
        'data3: ${self.data3}, '
        'data4: ${self.data4}, '
        'data5: ${self.data5}, '
        'data6: ${self.data6}, '
        'data7: ${self.data7}, '
        'data8: ${self.data8}, '
        'data9: ${self.data9}, '
        'data10: ${self.data10}, '
        'data11: ${self.data11}, '
        'data12: ${self.data12}, '
        'data13: ${self.data13}, '
        'data14: ${self.data14}, '
        'data15: ${self.data15}, '
        'data16: ${self.data16}, '
        'data17: ${self.data17}, '
        'data18: ${self.data18}, '
        'data19: ${self.data19}, '
        'data20: ${self.data20}, '
        'data21: ${self.data21}, '
        'data22: ${self.data22}, '
        'data23: ${self.data23}, '
        'aiName: ${self.aiName}, '
        'scriptName: ${self.scriptName}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class BriefGameObjectTemplateEntity {
  final int entry;
  final int type;
  final String name;
  final double size;
  final String localeName;

  const BriefGameObjectTemplateEntity({
    this.entry = 0,
    this.type = 0,
    this.name = '',
    this.size = 1.0,
    this.localeName = '',
  });

  factory BriefGameObjectTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectTemplateEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      size: (json['size'] as num?)?.toDouble() ?? 1.0,
      localeName: json['localeName']?.toString() ?? '',
    );
  }

  int get key => entry;
}
