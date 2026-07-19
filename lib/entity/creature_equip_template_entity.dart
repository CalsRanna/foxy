/// 生物装备模板 — 对应 creature_equip_template 表（复合键: CreatureID + ID）
class CreatureEquipTemplateEntity {
  final int creatureID;
  final int id;
  final int itemID1;
  final int itemID2;
  final int itemID3;
  final int verifiedBuild;

  const CreatureEquipTemplateEntity({
    this.creatureID = 0,
    this.id = 0,
    this.itemID1 = 0,
    this.itemID2 = 0,
    this.itemID3 = 0,
    this.verifiedBuild = 0,
  });

  factory CreatureEquipTemplateEntity.fromJson(Map<String, dynamic> json) {
    return CreatureEquipTemplateEntity(
      creatureID: json['CreatureID'] ?? 0,
      id: json['ID'] ?? 0,
      itemID1: json['ItemID1'] ?? 0,
      itemID2: json['ItemID2'] ?? 0,
      itemID3: json['ItemID3'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  CreatureEquipTemplateEntity copyWith({
    int? creatureID,
    int? id,
    int? itemID1,
    int? itemID2,
    int? itemID3,
    int? verifiedBuild,
  }) {
    return CreatureEquipTemplateEntity(
      creatureID: creatureID ?? this.creatureID,
      id: id ?? this.id,
      itemID1: itemID1 ?? this.itemID1,
      itemID2: itemID2 ?? this.itemID2,
      itemID3: itemID3 ?? this.itemID3,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
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
