// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_entity.dart';

mixin _CreatureTemplateEntityMixin {
  static CreatureTemplateEntity fromJson(Map<String, dynamic> json) {
    return CreatureTemplateEntity(
      aiName: json['AIName']?.toString() ?? '',
      armorModifier: (json['ArmorModifier'] as num?)?.toDouble() ?? 1.0,
      baseAttackTime: (json['BaseAttackTime'] as num?)?.toInt() ?? 0,
      baseVariance: (json['BaseVariance'] as num?)?.toDouble() ?? 1.0,
      damageModifier: (json['DamageModifier'] as num?)?.toDouble() ?? 1.0,
      difficultyEntry1: (json['difficulty_entry_1'] as num?)?.toInt() ?? 0,
      difficultyEntry2: (json['difficulty_entry_2'] as num?)?.toInt() ?? 0,
      difficultyEntry3: (json['difficulty_entry_3'] as num?)?.toInt() ?? 0,
      damageSchool: (json['dmgschool'] as num?)?.toInt() ?? 0,
      detectionRange: (json['detection_range'] as num?)?.toDouble() ?? 20.0,
      dynamicFlags: (json['dynamicflags'] as num?)?.toInt() ?? 0,
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      exp: (json['exp'] as num?)?.toInt() ?? 0,
      experienceModifier:
          (json['ExperienceModifier'] as num?)?.toDouble() ?? 1.0,
      faction: (json['faction'] as num?)?.toInt() ?? 0,
      family: (json['family'] as num?)?.toInt() ?? 0,
      flagsExtra: (json['flags_extra'] as num?)?.toInt() ?? 0,
      gossipMenuId: (json['gossip_menu_id'] as num?)?.toInt() ?? 0,
      healthModifier: (json['HealthModifier'] as num?)?.toDouble() ?? 1.0,
      hoverHeight: (json['HoverHeight'] as num?)?.toDouble() ?? 1.0,
      iconName: json['IconName']?.toString() ?? '',
      killCredit1: (json['KillCredit1'] as num?)?.toInt() ?? 0,
      killCredit2: (json['KillCredit2'] as num?)?.toInt() ?? 0,
      lootId: (json['lootid'] as num?)?.toInt() ?? 0,
      maxGold: (json['maxgold'] as num?)?.toInt() ?? 0,
      maxLevel: (json['maxlevel'] as num?)?.toInt() ?? 1,
      manaModifier: (json['ManaModifier'] as num?)?.toDouble() ?? 1.0,
      minLevel: (json['minlevel'] as num?)?.toInt() ?? 1,
      minGold: (json['mingold'] as num?)?.toInt() ?? 0,
      movementId: (json['movementId'] as num?)?.toInt() ?? 0,
      movementType: (json['MovementType'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      npcFlag: (json['npcflag'] as num?)?.toInt() ?? 0,
      petSpellDataId: (json['PetSpellDataId'] as num?)?.toInt() ?? 0,
      pickpocketLoot: (json['pickpocketloot'] as num?)?.toInt() ?? 0,
      racialLeader: (json['RacialLeader'] as num?)?.toInt() ?? 0,
      rangeAttackTime: (json['RangeAttackTime'] as num?)?.toInt() ?? 0,
      rangeVariance: (json['RangeVariance'] as num?)?.toDouble() ?? 1.0,
      rank: (json['rank'] as num?)?.toInt() ?? 0,
      regenHealth: (json['RegenHealth'] as num?)?.toInt() ?? 1,
      scriptName: json['ScriptName']?.toString() ?? '',
      skinLoot: (json['skinloot'] as num?)?.toInt() ?? 0,
      speedFlight: (json['speed_flight'] as num?)?.toDouble() ?? 1.0,
      speedRun: (json['speed_run'] as num?)?.toDouble() ?? 1.14286,
      speedSwim: (json['speed_swim'] as num?)?.toDouble() ?? 1.0,
      speedWalk: (json['speed_walk'] as num?)?.toDouble() ?? 1.0,
      subName: json['subname']?.toString() ?? '',
      type: (json['type'] as num?)?.toInt() ?? 0,
      typeFlags: (json['type_flags'] as num?)?.toInt() ?? 0,
      unitClass: (json['unit_class'] as num?)?.toInt() ?? 1,
      unitFlags: (json['unit_flags'] as num?)?.toInt() ?? 0,
      unitFlags2: (json['unit_flags2'] as num?)?.toInt() ?? 0,
      vehicleId: (json['VehicleId'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
      creatureImmunitiesId:
          (json['CreatureImmunitiesId'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureTemplateEntity copyWith({
    String? aiName,
    double? armorModifier,
    int? baseAttackTime,
    double? baseVariance,
    double? damageModifier,
    int? difficultyEntry1,
    int? difficultyEntry2,
    int? difficultyEntry3,
    int? damageSchool,
    double? detectionRange,
    int? dynamicFlags,
    int? entry,
    int? exp,
    double? experienceModifier,
    int? faction,
    int? family,
    int? flagsExtra,
    int? gossipMenuId,
    double? healthModifier,
    double? hoverHeight,
    String? iconName,
    int? killCredit1,
    int? killCredit2,
    int? lootId,
    int? maxGold,
    int? maxLevel,
    double? manaModifier,
    int? minLevel,
    int? minGold,
    int? movementId,
    int? movementType,
    String? name,
    int? npcFlag,
    int? petSpellDataId,
    int? pickpocketLoot,
    int? racialLeader,
    int? rangeAttackTime,
    double? rangeVariance,
    int? rank,
    int? regenHealth,
    String? scriptName,
    int? skinLoot,
    double? speedFlight,
    double? speedRun,
    double? speedSwim,
    double? speedWalk,
    String? subName,
    int? type,
    int? typeFlags,
    int? unitClass,
    int? unitFlags,
    int? unitFlags2,
    int? vehicleId,
    int? verifiedBuild,
    int? creatureImmunitiesId,
  }) {
    final self = this as CreatureTemplateEntity;
    return CreatureTemplateEntity(
      aiName: aiName ?? self.aiName,
      armorModifier: armorModifier ?? self.armorModifier,
      baseAttackTime: baseAttackTime ?? self.baseAttackTime,
      baseVariance: baseVariance ?? self.baseVariance,
      damageModifier: damageModifier ?? self.damageModifier,
      difficultyEntry1: difficultyEntry1 ?? self.difficultyEntry1,
      difficultyEntry2: difficultyEntry2 ?? self.difficultyEntry2,
      difficultyEntry3: difficultyEntry3 ?? self.difficultyEntry3,
      damageSchool: damageSchool ?? self.damageSchool,
      detectionRange: detectionRange ?? self.detectionRange,
      dynamicFlags: dynamicFlags ?? self.dynamicFlags,
      entry: entry ?? self.entry,
      exp: exp ?? self.exp,
      experienceModifier: experienceModifier ?? self.experienceModifier,
      faction: faction ?? self.faction,
      family: family ?? self.family,
      flagsExtra: flagsExtra ?? self.flagsExtra,
      gossipMenuId: gossipMenuId ?? self.gossipMenuId,
      healthModifier: healthModifier ?? self.healthModifier,
      hoverHeight: hoverHeight ?? self.hoverHeight,
      iconName: iconName ?? self.iconName,
      killCredit1: killCredit1 ?? self.killCredit1,
      killCredit2: killCredit2 ?? self.killCredit2,
      lootId: lootId ?? self.lootId,
      maxGold: maxGold ?? self.maxGold,
      maxLevel: maxLevel ?? self.maxLevel,
      manaModifier: manaModifier ?? self.manaModifier,
      minLevel: minLevel ?? self.minLevel,
      minGold: minGold ?? self.minGold,
      movementId: movementId ?? self.movementId,
      movementType: movementType ?? self.movementType,
      name: name ?? self.name,
      npcFlag: npcFlag ?? self.npcFlag,
      petSpellDataId: petSpellDataId ?? self.petSpellDataId,
      pickpocketLoot: pickpocketLoot ?? self.pickpocketLoot,
      racialLeader: racialLeader ?? self.racialLeader,
      rangeAttackTime: rangeAttackTime ?? self.rangeAttackTime,
      rangeVariance: rangeVariance ?? self.rangeVariance,
      rank: rank ?? self.rank,
      regenHealth: regenHealth ?? self.regenHealth,
      scriptName: scriptName ?? self.scriptName,
      skinLoot: skinLoot ?? self.skinLoot,
      speedFlight: speedFlight ?? self.speedFlight,
      speedRun: speedRun ?? self.speedRun,
      speedSwim: speedSwim ?? self.speedSwim,
      speedWalk: speedWalk ?? self.speedWalk,
      subName: subName ?? self.subName,
      type: type ?? self.type,
      typeFlags: typeFlags ?? self.typeFlags,
      unitClass: unitClass ?? self.unitClass,
      unitFlags: unitFlags ?? self.unitFlags,
      unitFlags2: unitFlags2 ?? self.unitFlags2,
      vehicleId: vehicleId ?? self.vehicleId,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
      creatureImmunitiesId: creatureImmunitiesId ?? self.creatureImmunitiesId,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureTemplateEntity;
    return {
      'AIName': self.aiName,
      'ArmorModifier': self.armorModifier,
      'BaseAttackTime': self.baseAttackTime,
      'BaseVariance': self.baseVariance,
      'DamageModifier': self.damageModifier,
      'difficulty_entry_1': self.difficultyEntry1,
      'difficulty_entry_2': self.difficultyEntry2,
      'difficulty_entry_3': self.difficultyEntry3,
      'dmgschool': self.damageSchool,
      'detection_range': self.detectionRange,
      'dynamicflags': self.dynamicFlags,
      'entry': self.entry,
      'exp': self.exp,
      'ExperienceModifier': self.experienceModifier,
      'faction': self.faction,
      'family': self.family,
      'flags_extra': self.flagsExtra,
      'gossip_menu_id': self.gossipMenuId,
      'HealthModifier': self.healthModifier,
      'HoverHeight': self.hoverHeight,
      'IconName': self.iconName,
      'KillCredit1': self.killCredit1,
      'KillCredit2': self.killCredit2,
      'lootid': self.lootId,
      'maxgold': self.maxGold,
      'maxlevel': self.maxLevel,
      'ManaModifier': self.manaModifier,
      'minlevel': self.minLevel,
      'mingold': self.minGold,
      'movementId': self.movementId,
      'MovementType': self.movementType,
      'name': self.name,
      'npcflag': self.npcFlag,
      'PetSpellDataId': self.petSpellDataId,
      'pickpocketloot': self.pickpocketLoot,
      'RacialLeader': self.racialLeader,
      'RangeAttackTime': self.rangeAttackTime,
      'RangeVariance': self.rangeVariance,
      'rank': self.rank,
      'RegenHealth': self.regenHealth,
      'ScriptName': self.scriptName,
      'skinloot': self.skinLoot,
      'speed_flight': self.speedFlight,
      'speed_run': self.speedRun,
      'speed_swim': self.speedSwim,
      'speed_walk': self.speedWalk,
      'subname': self.subName,
      'type': self.type,
      'type_flags': self.typeFlags,
      'unit_class': self.unitClass,
      'unit_flags': self.unitFlags,
      'unit_flags2': self.unitFlags2,
      'VehicleId': self.vehicleId,
      'VerifiedBuild': self.verifiedBuild,
      'CreatureImmunitiesId': self.creatureImmunitiesId,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureTemplateEntity;
    return identical(self, other) ||
        other is CreatureTemplateEntity &&
            self.runtimeType == other.runtimeType &&
            self.aiName == other.aiName &&
            self.armorModifier == other.armorModifier &&
            self.baseAttackTime == other.baseAttackTime &&
            self.baseVariance == other.baseVariance &&
            self.damageModifier == other.damageModifier &&
            self.difficultyEntry1 == other.difficultyEntry1 &&
            self.difficultyEntry2 == other.difficultyEntry2 &&
            self.difficultyEntry3 == other.difficultyEntry3 &&
            self.damageSchool == other.damageSchool &&
            self.detectionRange == other.detectionRange &&
            self.dynamicFlags == other.dynamicFlags &&
            self.entry == other.entry &&
            self.exp == other.exp &&
            self.experienceModifier == other.experienceModifier &&
            self.faction == other.faction &&
            self.family == other.family &&
            self.flagsExtra == other.flagsExtra &&
            self.gossipMenuId == other.gossipMenuId &&
            self.healthModifier == other.healthModifier &&
            self.hoverHeight == other.hoverHeight &&
            self.iconName == other.iconName &&
            self.killCredit1 == other.killCredit1 &&
            self.killCredit2 == other.killCredit2 &&
            self.lootId == other.lootId &&
            self.maxGold == other.maxGold &&
            self.maxLevel == other.maxLevel &&
            self.manaModifier == other.manaModifier &&
            self.minLevel == other.minLevel &&
            self.minGold == other.minGold &&
            self.movementId == other.movementId &&
            self.movementType == other.movementType &&
            self.name == other.name &&
            self.npcFlag == other.npcFlag &&
            self.petSpellDataId == other.petSpellDataId &&
            self.pickpocketLoot == other.pickpocketLoot &&
            self.racialLeader == other.racialLeader &&
            self.rangeAttackTime == other.rangeAttackTime &&
            self.rangeVariance == other.rangeVariance &&
            self.rank == other.rank &&
            self.regenHealth == other.regenHealth &&
            self.scriptName == other.scriptName &&
            self.skinLoot == other.skinLoot &&
            self.speedFlight == other.speedFlight &&
            self.speedRun == other.speedRun &&
            self.speedSwim == other.speedSwim &&
            self.speedWalk == other.speedWalk &&
            self.subName == other.subName &&
            self.type == other.type &&
            self.typeFlags == other.typeFlags &&
            self.unitClass == other.unitClass &&
            self.unitFlags == other.unitFlags &&
            self.unitFlags2 == other.unitFlags2 &&
            self.vehicleId == other.vehicleId &&
            self.verifiedBuild == other.verifiedBuild &&
            self.creatureImmunitiesId == other.creatureImmunitiesId;
  }

  @override
  int get hashCode {
    final self = this as CreatureTemplateEntity;
    return Object.hashAll([
      self.runtimeType,
      self.aiName,
      self.armorModifier,
      self.baseAttackTime,
      self.baseVariance,
      self.damageModifier,
      self.difficultyEntry1,
      self.difficultyEntry2,
      self.difficultyEntry3,
      self.damageSchool,
      self.detectionRange,
      self.dynamicFlags,
      self.entry,
      self.exp,
      self.experienceModifier,
      self.faction,
      self.family,
      self.flagsExtra,
      self.gossipMenuId,
      self.healthModifier,
      self.hoverHeight,
      self.iconName,
      self.killCredit1,
      self.killCredit2,
      self.lootId,
      self.maxGold,
      self.maxLevel,
      self.manaModifier,
      self.minLevel,
      self.minGold,
      self.movementId,
      self.movementType,
      self.name,
      self.npcFlag,
      self.petSpellDataId,
      self.pickpocketLoot,
      self.racialLeader,
      self.rangeAttackTime,
      self.rangeVariance,
      self.rank,
      self.regenHealth,
      self.scriptName,
      self.skinLoot,
      self.speedFlight,
      self.speedRun,
      self.speedSwim,
      self.speedWalk,
      self.subName,
      self.type,
      self.typeFlags,
      self.unitClass,
      self.unitFlags,
      self.unitFlags2,
      self.vehicleId,
      self.verifiedBuild,
      self.creatureImmunitiesId,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureTemplateEntity;
    return 'CreatureTemplateEntity('
        'aiName: ${self.aiName}, '
        'armorModifier: ${self.armorModifier}, '
        'baseAttackTime: ${self.baseAttackTime}, '
        'baseVariance: ${self.baseVariance}, '
        'damageModifier: ${self.damageModifier}, '
        'difficultyEntry1: ${self.difficultyEntry1}, '
        'difficultyEntry2: ${self.difficultyEntry2}, '
        'difficultyEntry3: ${self.difficultyEntry3}, '
        'damageSchool: ${self.damageSchool}, '
        'detectionRange: ${self.detectionRange}, '
        'dynamicFlags: ${self.dynamicFlags}, '
        'entry: ${self.entry}, '
        'exp: ${self.exp}, '
        'experienceModifier: ${self.experienceModifier}, '
        'faction: ${self.faction}, '
        'family: ${self.family}, '
        'flagsExtra: ${self.flagsExtra}, '
        'gossipMenuId: ${self.gossipMenuId}, '
        'healthModifier: ${self.healthModifier}, '
        'hoverHeight: ${self.hoverHeight}, '
        'iconName: ${self.iconName}, '
        'killCredit1: ${self.killCredit1}, '
        'killCredit2: ${self.killCredit2}, '
        'lootId: ${self.lootId}, '
        'maxGold: ${self.maxGold}, '
        'maxLevel: ${self.maxLevel}, '
        'manaModifier: ${self.manaModifier}, '
        'minLevel: ${self.minLevel}, '
        'minGold: ${self.minGold}, '
        'movementId: ${self.movementId}, '
        'movementType: ${self.movementType}, '
        'name: ${self.name}, '
        'npcFlag: ${self.npcFlag}, '
        'petSpellDataId: ${self.petSpellDataId}, '
        'pickpocketLoot: ${self.pickpocketLoot}, '
        'racialLeader: ${self.racialLeader}, '
        'rangeAttackTime: ${self.rangeAttackTime}, '
        'rangeVariance: ${self.rangeVariance}, '
        'rank: ${self.rank}, '
        'regenHealth: ${self.regenHealth}, '
        'scriptName: ${self.scriptName}, '
        'skinLoot: ${self.skinLoot}, '
        'speedFlight: ${self.speedFlight}, '
        'speedRun: ${self.speedRun}, '
        'speedSwim: ${self.speedSwim}, '
        'speedWalk: ${self.speedWalk}, '
        'subName: ${self.subName}, '
        'type: ${self.type}, '
        'typeFlags: ${self.typeFlags}, '
        'unitClass: ${self.unitClass}, '
        'unitFlags: ${self.unitFlags}, '
        'unitFlags2: ${self.unitFlags2}, '
        'vehicleId: ${self.vehicleId}, '
        'verifiedBuild: ${self.verifiedBuild}, '
        'creatureImmunitiesId: ${self.creatureImmunitiesId}'
        ')';
  }
}

final class BriefCreatureTemplateEntity {
  final int entry;
  final int maxLevel;
  final int minLevel;
  final String name;
  final String subName;
  final String localeName;
  final String localeSubName;

  const BriefCreatureTemplateEntity({
    this.entry = 0,
    this.maxLevel = 1,
    this.minLevel = 1,
    this.name = '',
    this.subName = '',
    this.localeName = '',
    this.localeSubName = '',
  });

  factory BriefCreatureTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureTemplateEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      maxLevel: (json['maxlevel'] as num?)?.toInt() ?? 1,
      minLevel: (json['minlevel'] as num?)?.toInt() ?? 1,
      name: json['name']?.toString() ?? '',
      subName: json['subname']?.toString() ?? '',
      localeName: json['localeName']?.toString() ?? '',
      localeSubName: json['localeSubName']?.toString() ?? '',
    );
  }

  int get key => entry;
}
