// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_equip_template_entity.dart';

mixin _CreatureEquipTemplateEntityMixin {
  int get creatureID;
  int get id;
  int get itemID1;
  int get itemID2;
  int get itemID3;
  int get verifiedBuild;

  static CreatureEquipTemplateEntity fromJson(Map<String, dynamic> json) {
    return CreatureEquipTemplateEntity(
      creatureID: (json['CreatureID'] as num?)?.toInt() ?? 0,
      id: (json['ID'] as num?)?.toInt() ?? 0,
      itemID1: (json['ItemID1'] as num?)?.toInt() ?? 0,
      itemID2: (json['ItemID2'] as num?)?.toInt() ?? 0,
      itemID3: (json['ItemID3'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureEquipTemplateEntity &&
            runtimeType == other.runtimeType &&
            creatureID == other.creatureID &&
            id == other.id &&
            itemID1 == other.itemID1 &&
            itemID2 == other.itemID2 &&
            itemID3 == other.itemID3 &&
            verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      creatureID,
      id,
      itemID1,
      itemID2,
      itemID3,
      verifiedBuild,
    ]);
  }

  @override
  String toString() {
    return 'CreatureEquipTemplateEntity('
        'creatureID: $creatureID, '
        'id: $id, '
        'itemID1: $itemID1, '
        'itemID2: $itemID2, '
        'itemID3: $itemID3, '
        'verifiedBuild: $verifiedBuild'
        ')';
  }
}
