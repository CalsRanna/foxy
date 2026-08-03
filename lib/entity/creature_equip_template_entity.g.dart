// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_equip_template_entity.dart';

final class BriefCreatureEquipTemplateEntity {
  final int creatureID;
  final int id;
  final int itemID1;
  final int itemID2;
  final int itemID3;
  final int verifiedBuild;
  final String name1;
  final String localeName1;
  final int quality1;
  final String icon1;
  final String name2;
  final String localeName2;
  final int quality2;
  final String icon2;
  final String name3;
  final String localeName3;
  final int quality3;
  final String icon3;

  const BriefCreatureEquipTemplateEntity({
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

  factory BriefCreatureEquipTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureEquipTemplateEntity(
      creatureID: json['CreatureID'] == true
          ? 1
          : json['CreatureID'] == false
          ? 0
          : (json['CreatureID'] as num?)?.toInt() ?? 0,
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      itemID1: json['ItemID1'] == true
          ? 1
          : json['ItemID1'] == false
          ? 0
          : (json['ItemID1'] as num?)?.toInt() ?? 0,
      itemID2: json['ItemID2'] == true
          ? 1
          : json['ItemID2'] == false
          ? 0
          : (json['ItemID2'] as num?)?.toInt() ?? 0,
      itemID3: json['ItemID3'] == true
          ? 1
          : json['ItemID3'] == false
          ? 0
          : (json['ItemID3'] as num?)?.toInt() ?? 0,
      verifiedBuild: json['VerifiedBuild'] == true
          ? 1
          : json['VerifiedBuild'] == false
          ? 0
          : (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
      name1: json['name1']?.toString() ?? '',
      localeName1: json['localeName1']?.toString() ?? '',
      quality1: json['quality1'] == true
          ? 1
          : json['quality1'] == false
          ? 0
          : (json['quality1'] as num?)?.toInt() ?? 0,
      icon1: json['icon1']?.toString() ?? '',
      name2: json['name2']?.toString() ?? '',
      localeName2: json['localeName2']?.toString() ?? '',
      quality2: json['quality2'] == true
          ? 1
          : json['quality2'] == false
          ? 0
          : (json['quality2'] as num?)?.toInt() ?? 0,
      icon2: json['icon2']?.toString() ?? '',
      name3: json['name3']?.toString() ?? '',
      localeName3: json['localeName3']?.toString() ?? '',
      quality3: json['quality3'] == true
          ? 1
          : json['quality3'] == false
          ? 0
          : (json['quality3'] as num?)?.toInt() ?? 0,
      icon3: json['icon3']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([
    creatureID,
    id,
    itemID1,
    itemID2,
    itemID3,
    verifiedBuild,
    name1,
    localeName1,
    quality1,
    icon1,
    name2,
    localeName2,
    quality2,
    icon2,
    name3,
    localeName3,
    quality3,
    icon3,
  ]);

  CreatureEquipTemplateKey get key {
    return CreatureEquipTemplateKey(creatureID: creatureID, id: id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefCreatureEquipTemplateEntity &&
            creatureID == other.creatureID &&
            id == other.id &&
            itemID1 == other.itemID1 &&
            itemID2 == other.itemID2 &&
            itemID3 == other.itemID3 &&
            verifiedBuild == other.verifiedBuild &&
            name1 == other.name1 &&
            localeName1 == other.localeName1 &&
            quality1 == other.quality1 &&
            icon1 == other.icon1 &&
            name2 == other.name2 &&
            localeName2 == other.localeName2 &&
            quality2 == other.quality2 &&
            icon2 == other.icon2 &&
            name3 == other.name3 &&
            localeName3 == other.localeName3 &&
            quality3 == other.quality3 &&
            icon3 == other.icon3;
  }

  @override
  String toString() {
    return 'BriefCreatureEquipTemplateEntity('
        'creatureID: $creatureID, '
        'id: $id, '
        'itemID1: $itemID1, '
        'itemID2: $itemID2, '
        'itemID3: $itemID3, '
        'verifiedBuild: $verifiedBuild, '
        'name1: $name1, '
        'localeName1: $localeName1, '
        'quality1: $quality1, '
        'icon1: $icon1, '
        'name2: $name2, '
        'localeName2: $localeName2, '
        'quality2: $quality2, '
        'icon2: $icon2, '
        'name3: $name3, '
        'localeName3: $localeName3, '
        'quality3: $quality3, '
        'icon3: $icon3'
        ')';
  }
}

final class CreatureEquipTemplateKey {
  final int creatureID;
  final int id;

  const CreatureEquipTemplateKey({required this.creatureID, required this.id});

  factory CreatureEquipTemplateKey.fromEntity(
    CreatureEquipTemplateEntity entity,
  ) {
    return CreatureEquipTemplateKey(
      creatureID: entity.creatureID,
      id: entity.id,
    );
  }

  @override
  int get hashCode => Object.hashAll([creatureID, id]);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureEquipTemplateKey &&
            creatureID == other.creatureID &&
            id == other.id;
  }

  @override
  String toString() {
    return 'CreatureEquipTemplateKey('
        'creatureID: $creatureID, '
        'id: $id'
        ')';
  }
}

mixin _CreatureEquipTemplateEntityMixin {
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

  static CreatureEquipTemplateEntity fromJson(Map<String, dynamic> json) {
    return CreatureEquipTemplateEntity(
      creatureID: json['CreatureID'] == true
          ? 1
          : json['CreatureID'] == false
          ? 0
          : (json['CreatureID'] as num?)?.toInt() ?? 0,
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      itemID1: json['ItemID1'] == true
          ? 1
          : json['ItemID1'] == false
          ? 0
          : (json['ItemID1'] as num?)?.toInt() ?? 0,
      itemID2: json['ItemID2'] == true
          ? 1
          : json['ItemID2'] == false
          ? 0
          : (json['ItemID2'] as num?)?.toInt() ?? 0,
      itemID3: json['ItemID3'] == true
          ? 1
          : json['ItemID3'] == false
          ? 0
          : (json['ItemID3'] as num?)?.toInt() ?? 0,
      verifiedBuild: json['VerifiedBuild'] == true
          ? 1
          : json['VerifiedBuild'] == false
          ? 0
          : (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }
}
