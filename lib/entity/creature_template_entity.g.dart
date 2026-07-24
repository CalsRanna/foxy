// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_entity.dart';

mixin _CreatureTemplateEntityMixin {
  String get aiName;
  double get armorModifier;
  int get baseAttackTime;
  double get baseVariance;
  double get damageModifier;
  int get difficultyEntry1;
  int get difficultyEntry2;
  int get difficultyEntry3;
  int get damageSchool;
  double get detectionRange;
  int get dynamicFlags;
  int get entry;
  int get exp;
  double get experienceModifier;
  int get faction;
  int get family;
  int get flagsExtra;
  int get gossipMenuId;
  double get healthModifier;
  double get hoverHeight;
  String get iconName;
  int get killCredit1;
  int get killCredit2;
  int get lootId;
  int get maxGold;
  int get maxLevel;
  double get manaModifier;
  int get minLevel;
  int get minGold;
  int get movementId;
  int get movementType;
  String get name;
  int get npcFlag;
  int get petSpellDataId;
  int get pickpocketLoot;
  int get racialLeader;
  int get rangeAttackTime;
  double get rangeVariance;
  int get rank;
  int get regenHealth;
  String get scriptName;
  int get skinLoot;
  double get speedFlight;
  double get speedRun;
  double get speedSwim;
  double get speedWalk;
  String get subName;
  int get type;
  int get typeFlags;
  int get unitClass;
  int get unitFlags;
  int get unitFlags2;
  int get vehicleId;
  int get verifiedBuild;
  int get creatureImmunitiesId;

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
    return CreatureTemplateEntity(
      aiName: aiName ?? this.aiName,
      armorModifier: armorModifier ?? this.armorModifier,
      baseAttackTime: baseAttackTime ?? this.baseAttackTime,
      baseVariance: baseVariance ?? this.baseVariance,
      damageModifier: damageModifier ?? this.damageModifier,
      difficultyEntry1: difficultyEntry1 ?? this.difficultyEntry1,
      difficultyEntry2: difficultyEntry2 ?? this.difficultyEntry2,
      difficultyEntry3: difficultyEntry3 ?? this.difficultyEntry3,
      damageSchool: damageSchool ?? this.damageSchool,
      detectionRange: detectionRange ?? this.detectionRange,
      dynamicFlags: dynamicFlags ?? this.dynamicFlags,
      entry: entry ?? this.entry,
      exp: exp ?? this.exp,
      experienceModifier: experienceModifier ?? this.experienceModifier,
      faction: faction ?? this.faction,
      family: family ?? this.family,
      flagsExtra: flagsExtra ?? this.flagsExtra,
      gossipMenuId: gossipMenuId ?? this.gossipMenuId,
      healthModifier: healthModifier ?? this.healthModifier,
      hoverHeight: hoverHeight ?? this.hoverHeight,
      iconName: iconName ?? this.iconName,
      killCredit1: killCredit1 ?? this.killCredit1,
      killCredit2: killCredit2 ?? this.killCredit2,
      lootId: lootId ?? this.lootId,
      maxGold: maxGold ?? this.maxGold,
      maxLevel: maxLevel ?? this.maxLevel,
      manaModifier: manaModifier ?? this.manaModifier,
      minLevel: minLevel ?? this.minLevel,
      minGold: minGold ?? this.minGold,
      movementId: movementId ?? this.movementId,
      movementType: movementType ?? this.movementType,
      name: name ?? this.name,
      npcFlag: npcFlag ?? this.npcFlag,
      petSpellDataId: petSpellDataId ?? this.petSpellDataId,
      pickpocketLoot: pickpocketLoot ?? this.pickpocketLoot,
      racialLeader: racialLeader ?? this.racialLeader,
      rangeAttackTime: rangeAttackTime ?? this.rangeAttackTime,
      rangeVariance: rangeVariance ?? this.rangeVariance,
      rank: rank ?? this.rank,
      regenHealth: regenHealth ?? this.regenHealth,
      scriptName: scriptName ?? this.scriptName,
      skinLoot: skinLoot ?? this.skinLoot,
      speedFlight: speedFlight ?? this.speedFlight,
      speedRun: speedRun ?? this.speedRun,
      speedSwim: speedSwim ?? this.speedSwim,
      speedWalk: speedWalk ?? this.speedWalk,
      subName: subName ?? this.subName,
      type: type ?? this.type,
      typeFlags: typeFlags ?? this.typeFlags,
      unitClass: unitClass ?? this.unitClass,
      unitFlags: unitFlags ?? this.unitFlags,
      unitFlags2: unitFlags2 ?? this.unitFlags2,
      vehicleId: vehicleId ?? this.vehicleId,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
      creatureImmunitiesId: creatureImmunitiesId ?? this.creatureImmunitiesId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AIName': aiName,
      'ArmorModifier': armorModifier,
      'BaseAttackTime': baseAttackTime,
      'BaseVariance': baseVariance,
      'DamageModifier': damageModifier,
      'difficulty_entry_1': difficultyEntry1,
      'difficulty_entry_2': difficultyEntry2,
      'difficulty_entry_3': difficultyEntry3,
      'dmgschool': damageSchool,
      'detection_range': detectionRange,
      'dynamicflags': dynamicFlags,
      'entry': entry,
      'exp': exp,
      'ExperienceModifier': experienceModifier,
      'faction': faction,
      'family': family,
      'flags_extra': flagsExtra,
      'gossip_menu_id': gossipMenuId,
      'HealthModifier': healthModifier,
      'HoverHeight': hoverHeight,
      'IconName': iconName,
      'KillCredit1': killCredit1,
      'KillCredit2': killCredit2,
      'lootid': lootId,
      'maxgold': maxGold,
      'maxlevel': maxLevel,
      'ManaModifier': manaModifier,
      'minlevel': minLevel,
      'mingold': minGold,
      'movementId': movementId,
      'MovementType': movementType,
      'name': name,
      'npcflag': npcFlag,
      'PetSpellDataId': petSpellDataId,
      'pickpocketloot': pickpocketLoot,
      'RacialLeader': racialLeader,
      'RangeAttackTime': rangeAttackTime,
      'RangeVariance': rangeVariance,
      'rank': rank,
      'RegenHealth': regenHealth,
      'ScriptName': scriptName,
      'skinloot': skinLoot,
      'speed_flight': speedFlight,
      'speed_run': speedRun,
      'speed_swim': speedSwim,
      'speed_walk': speedWalk,
      'subname': subName,
      'type': type,
      'type_flags': typeFlags,
      'unit_class': unitClass,
      'unit_flags': unitFlags,
      'unit_flags2': unitFlags2,
      'VehicleId': vehicleId,
      'VerifiedBuild': verifiedBuild,
      'CreatureImmunitiesId': creatureImmunitiesId,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureTemplateEntity &&
            runtimeType == other.runtimeType &&
            aiName == other.aiName &&
            armorModifier == other.armorModifier &&
            baseAttackTime == other.baseAttackTime &&
            baseVariance == other.baseVariance &&
            damageModifier == other.damageModifier &&
            difficultyEntry1 == other.difficultyEntry1 &&
            difficultyEntry2 == other.difficultyEntry2 &&
            difficultyEntry3 == other.difficultyEntry3 &&
            damageSchool == other.damageSchool &&
            detectionRange == other.detectionRange &&
            dynamicFlags == other.dynamicFlags &&
            entry == other.entry &&
            exp == other.exp &&
            experienceModifier == other.experienceModifier &&
            faction == other.faction &&
            family == other.family &&
            flagsExtra == other.flagsExtra &&
            gossipMenuId == other.gossipMenuId &&
            healthModifier == other.healthModifier &&
            hoverHeight == other.hoverHeight &&
            iconName == other.iconName &&
            killCredit1 == other.killCredit1 &&
            killCredit2 == other.killCredit2 &&
            lootId == other.lootId &&
            maxGold == other.maxGold &&
            maxLevel == other.maxLevel &&
            manaModifier == other.manaModifier &&
            minLevel == other.minLevel &&
            minGold == other.minGold &&
            movementId == other.movementId &&
            movementType == other.movementType &&
            name == other.name &&
            npcFlag == other.npcFlag &&
            petSpellDataId == other.petSpellDataId &&
            pickpocketLoot == other.pickpocketLoot &&
            racialLeader == other.racialLeader &&
            rangeAttackTime == other.rangeAttackTime &&
            rangeVariance == other.rangeVariance &&
            rank == other.rank &&
            regenHealth == other.regenHealth &&
            scriptName == other.scriptName &&
            skinLoot == other.skinLoot &&
            speedFlight == other.speedFlight &&
            speedRun == other.speedRun &&
            speedSwim == other.speedSwim &&
            speedWalk == other.speedWalk &&
            subName == other.subName &&
            type == other.type &&
            typeFlags == other.typeFlags &&
            unitClass == other.unitClass &&
            unitFlags == other.unitFlags &&
            unitFlags2 == other.unitFlags2 &&
            vehicleId == other.vehicleId &&
            verifiedBuild == other.verifiedBuild &&
            creatureImmunitiesId == other.creatureImmunitiesId;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      aiName,
      armorModifier,
      baseAttackTime,
      baseVariance,
      damageModifier,
      difficultyEntry1,
      difficultyEntry2,
      difficultyEntry3,
      damageSchool,
      detectionRange,
      dynamicFlags,
      entry,
      exp,
      experienceModifier,
      faction,
      family,
      flagsExtra,
      gossipMenuId,
      healthModifier,
      hoverHeight,
      iconName,
      killCredit1,
      killCredit2,
      lootId,
      maxGold,
      maxLevel,
      manaModifier,
      minLevel,
      minGold,
      movementId,
      movementType,
      name,
      npcFlag,
      petSpellDataId,
      pickpocketLoot,
      racialLeader,
      rangeAttackTime,
      rangeVariance,
      rank,
      regenHealth,
      scriptName,
      skinLoot,
      speedFlight,
      speedRun,
      speedSwim,
      speedWalk,
      subName,
      type,
      typeFlags,
      unitClass,
      unitFlags,
      unitFlags2,
      vehicleId,
      verifiedBuild,
      creatureImmunitiesId,
    ]);
  }

  @override
  String toString() {
    return 'CreatureTemplateEntity('
        'aiName: $aiName, '
        'armorModifier: $armorModifier, '
        'baseAttackTime: $baseAttackTime, '
        'baseVariance: $baseVariance, '
        'damageModifier: $damageModifier, '
        'difficultyEntry1: $difficultyEntry1, '
        'difficultyEntry2: $difficultyEntry2, '
        'difficultyEntry3: $difficultyEntry3, '
        'damageSchool: $damageSchool, '
        'detectionRange: $detectionRange, '
        'dynamicFlags: $dynamicFlags, '
        'entry: $entry, '
        'exp: $exp, '
        'experienceModifier: $experienceModifier, '
        'faction: $faction, '
        'family: $family, '
        'flagsExtra: $flagsExtra, '
        'gossipMenuId: $gossipMenuId, '
        'healthModifier: $healthModifier, '
        'hoverHeight: $hoverHeight, '
        'iconName: $iconName, '
        'killCredit1: $killCredit1, '
        'killCredit2: $killCredit2, '
        'lootId: $lootId, '
        'maxGold: $maxGold, '
        'maxLevel: $maxLevel, '
        'manaModifier: $manaModifier, '
        'minLevel: $minLevel, '
        'minGold: $minGold, '
        'movementId: $movementId, '
        'movementType: $movementType, '
        'name: $name, '
        'npcFlag: $npcFlag, '
        'petSpellDataId: $petSpellDataId, '
        'pickpocketLoot: $pickpocketLoot, '
        'racialLeader: $racialLeader, '
        'rangeAttackTime: $rangeAttackTime, '
        'rangeVariance: $rangeVariance, '
        'rank: $rank, '
        'regenHealth: $regenHealth, '
        'scriptName: $scriptName, '
        'skinLoot: $skinLoot, '
        'speedFlight: $speedFlight, '
        'speedRun: $speedRun, '
        'speedSwim: $speedSwim, '
        'speedWalk: $speedWalk, '
        'subName: $subName, '
        'type: $type, '
        'typeFlags: $typeFlags, '
        'unitClass: $unitClass, '
        'unitFlags: $unitFlags, '
        'unitFlags2: $unitFlags2, '
        'vehicleId: $vehicleId, '
        'verifiedBuild: $verifiedBuild, '
        'creatureImmunitiesId: $creatureImmunitiesId'
        ')';
  }
}
