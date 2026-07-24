// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_equip_template_entity.dart';

mixin _CreatureEquipTemplateEntityMixin {
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
    final self = this as CreatureEquipTemplateEntity;
    return CreatureEquipTemplateEntity(
      creatureID: creatureID ?? self.creatureID,
      id: id ?? self.id,
      itemID1: itemID1 ?? self.itemID1,
      itemID2: itemID2 ?? self.itemID2,
      itemID3: itemID3 ?? self.itemID3,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureEquipTemplateEntity;
    return {
      'CreatureID': self.creatureID,
      'ID': self.id,
      'ItemID1': self.itemID1,
      'ItemID2': self.itemID2,
      'ItemID3': self.itemID3,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureEquipTemplateEntity;
    return identical(self, other) ||
        other is CreatureEquipTemplateEntity &&
            self.runtimeType == other.runtimeType &&
            self.creatureID == other.creatureID &&
            self.id == other.id &&
            self.itemID1 == other.itemID1 &&
            self.itemID2 == other.itemID2 &&
            self.itemID3 == other.itemID3 &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as CreatureEquipTemplateEntity;
    return Object.hashAll([
      self.runtimeType,
      self.creatureID,
      self.id,
      self.itemID1,
      self.itemID2,
      self.itemID3,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureEquipTemplateEntity;
    return 'CreatureEquipTemplateEntity('
        'creatureID: ${self.creatureID}, '
        'id: ${self.id}, '
        'itemID1: ${self.itemID1}, '
        'itemID2: ${self.itemID2}, '
        'itemID3: ${self.itemID3}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}
