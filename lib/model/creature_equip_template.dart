/// 生物装备模板
class CreatureEquipTemplate {
  final int creatureID;
  final int id;
  final int itemID1;
  final int itemID2;
  final int itemID3;
  final int verifiedBuild;

  // 关联字段（装备1信息）
  final String name1;
  final String localeName1;
  final int quality1;
  final String icon1;

  // 关联字段（装备2信息）
  final String name2;
  final String localeName2;
  final int quality2;
  final String icon2;

  // 关联字段（装备3信息）
  final String name3;
  final String localeName3;
  final int quality3;
  final String icon3;

  /// 显示名称
  String get displayName1 => localeName1.isNotEmpty ? localeName1 : name1;
  String get displayName2 => localeName2.isNotEmpty ? localeName2 : name2;
  String get displayName3 => localeName3.isNotEmpty ? localeName3 : name3;

  const CreatureEquipTemplate({
    this.creatureID = 0,
    this.id = 0,
    this.itemID1 = 0,
    this.itemID2 = 0,
    this.itemID3 = 0,
    this.verifiedBuild = 0,
    this.name1 = '',
    this.localeName1 = '',
    this.quality1 = 0,
    this.icon1 = '',
    this.name2 = '',
    this.localeName2 = '',
    this.quality2 = 0,
    this.icon2 = '',
    this.name3 = '',
    this.localeName3 = '',
    this.quality3 = 0,
    this.icon3 = '',
  });

  factory CreatureEquipTemplate.fromJson(Map<String, dynamic> json) {
    return CreatureEquipTemplate(
      creatureID: json['CreatureID'] ?? json['creatureID'] ?? 0,
      id: json['ID'] ?? json['id'] ?? 0,
      itemID1: json['ItemID1'] ?? json['itemID1'] ?? 0,
      itemID2: json['ItemID2'] ?? json['itemID2'] ?? 0,
      itemID3: json['ItemID3'] ?? json['itemID3'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0,
      name1: json['name_1'] ?? '',
      localeName1: json['localeName_1'] ?? '',
      quality1: json['Quality_1'] ?? 0,
      icon1: json['Icon_1'] ?? '',
      name2: json['name_2'] ?? '',
      localeName2: json['localeName_2'] ?? '',
      quality2: json['Quality_2'] ?? 0,
      icon2: json['Icon_2'] ?? '',
      name3: json['name_3'] ?? '',
      localeName3: json['localeName_3'] ?? '',
      quality3: json['Quality_3'] ?? 0,
      icon3: json['Icon_3'] ?? '',
    );
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
