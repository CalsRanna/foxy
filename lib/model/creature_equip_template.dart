/// 生物装备模板
class CreatureEquipTemplate {
  int creatureID = 0;
  int id = 0;
  int itemID1 = 0;
  int itemID2 = 0;
  int itemID3 = 0;
  int verifiedBuild = 0;

  // 关联字段（装备1信息）
  String name1 = '';
  String localeName1 = '';
  int quality1 = 0;
  String icon1 = '';

  // 关联字段（装备2信息）
  String name2 = '';
  String localeName2 = '';
  int quality2 = 0;
  String icon2 = '';

  // 关联字段（装备3信息）
  String name3 = '';
  String localeName3 = '';
  int quality3 = 0;
  String icon3 = '';

  /// 显示名称
  String get displayName1 => localeName1.isNotEmpty ? localeName1 : name1;
  String get displayName2 => localeName2.isNotEmpty ? localeName2 : name2;
  String get displayName3 => localeName3.isNotEmpty ? localeName3 : name3;

  CreatureEquipTemplate();

  CreatureEquipTemplate.fromJson(Map<String, dynamic> json) {
    creatureID = json['CreatureID'] ?? json['creatureID'] ?? 0;
    id = json['ID'] ?? json['id'] ?? 0;
    itemID1 = json['ItemID1'] ?? json['itemID1'] ?? 0;
    itemID2 = json['ItemID2'] ?? json['itemID2'] ?? 0;
    itemID3 = json['ItemID3'] ?? json['itemID3'] ?? 0;
    verifiedBuild = json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0;

    // 装备1关联字段
    name1 = json['name_1'] ?? '';
    localeName1 = json['localeName_1'] ?? '';
    quality1 = json['Quality_1'] ?? 0;
    icon1 = json['Icon_1'] ?? '';

    // 装备2关联字段
    name2 = json['name_2'] ?? '';
    localeName2 = json['localeName_2'] ?? '';
    quality2 = json['Quality_2'] ?? 0;
    icon2 = json['Icon_2'] ?? '';

    // 装备3关联字段
    name3 = json['name_3'] ?? '';
    localeName3 = json['localeName_3'] ?? '';
    quality3 = json['Quality_3'] ?? 0;
    icon3 = json['Icon_3'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'CreatureID': creatureID,
      'ID': id,
      'ItemID1': itemID1,
      'ItemID2': itemID2,
      'ItemID3': itemID3,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
