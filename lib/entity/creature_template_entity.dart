class BriefCreatureTemplateEntity {
  final int entry;
  final String name;
  final String subName;
  final String localeName;
  final String localeSubName;
  final int minLevel;
  final int maxLevel;

  const BriefCreatureTemplateEntity({
    this.entry = 0,
    this.name = '',
    this.subName = '',
    this.localeName = '',
    this.localeSubName = '',
    this.minLevel = 0,
    this.maxLevel = 0,
  });

  factory BriefCreatureTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureTemplateEntity(
      entry: json['entry'] ?? 0,
      name: json['name'] ?? '',
      subName: json['subname'] ?? '',
      localeName: json['Name'] ?? '',
      localeSubName: json['Title'] ?? '',
      minLevel: json['minlevel'] ?? 0,
      maxLevel: json['maxlevel'] ?? 0,
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;
  String get displaySubName =>
      localeSubName.isNotEmpty ? localeSubName : subName;

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'name': name,
      'subname': subName,
      'Name': localeName,
      'Title': localeSubName,
      'minlevel': minLevel,
      'maxlevel': maxLevel,
    };
  }

  BriefCreatureTemplateEntity copyWith({
    int? entry,
    String? name,
    String? subName,
    String? localeName,
    String? localeSubName,
    int? minLevel,
    int? maxLevel,
  }) {
    return BriefCreatureTemplateEntity(
      entry: entry ?? this.entry,
      name: name ?? this.name,
      subName: subName ?? this.subName,
      localeName: localeName ?? this.localeName,
      localeSubName: localeSubName ?? this.localeSubName,
      minLevel: minLevel ?? this.minLevel,
      maxLevel: maxLevel ?? this.maxLevel,
    );
  }
}

class CreatureTemplateEntity {
  final String aiName;
  final double armorModifier;
  final int baseAttackTime;
  final double baseVariance;
  final double damageModifier;
  final int difficultyEntry1;
  final int difficultyEntry2;
  final int difficultyEntry3;
  final int damageSchool;
  final double detectionRange;
  final int dynamicFlags;
  final int entry;
  final int exp;
  final double experienceModifier;
  final int faction;
  final int family;
  final int flagsExtra;
  final int gossipMenuId;
  final double healthModifier;
  final double hoverHeight;
  final String iconName;
  final int killCredit1;
  final int killCredit2;
  final int lootId;
  final int maxGold;
  final int maxLevel;
  final double manaModifier;
  final int minLevel;
  final int minGold;
  final int movementId;
  final int movementType;
  final String name;
  final int npcFlag;
  final int petSpellDataId;
  final int pickpocketLoot;
  final int racialLeader;
  final int rangeAttackTime;
  final double rangeVariance;
  final int rank;
  final int regenHealth;
  final String scriptName;
  final int skinLoot;
  final double speedFlight;
  final double speedRun;
  final double speedSwim;
  final double speedWalk;
  final String subName;
  final int type;
  final int typeFlags;
  final int unitClass;
  final int unitFlags;
  final int unitFlags2;
  final int vehicleId;
  final int verifiedBuild;
  final int creatureImmunitiesId;

  const CreatureTemplateEntity({
    this.aiName = '',
    this.armorModifier = 1,
    this.baseAttackTime = 0,
    this.baseVariance = 1,
    this.damageModifier = 1,
    this.difficultyEntry1 = 0,
    this.difficultyEntry2 = 0,
    this.difficultyEntry3 = 0,
    this.damageSchool = 0,
    this.detectionRange = 20,
    this.dynamicFlags = 0,
    this.entry = 0,
    this.exp = 0,
    this.experienceModifier = 1,
    this.faction = 0,
    this.family = 0,
    this.flagsExtra = 0,
    this.gossipMenuId = 0,
    this.healthModifier = 1,
    this.hoverHeight = 1,
    this.iconName = '',
    this.killCredit1 = 0,
    this.killCredit2 = 0,
    this.lootId = 0,
    this.maxGold = 0,
    this.maxLevel = 1,
    this.manaModifier = 1,
    this.minLevel = 1,
    this.minGold = 0,
    this.movementId = 0,
    this.movementType = 0,
    this.name = '',
    this.npcFlag = 0,
    this.petSpellDataId = 0,
    this.pickpocketLoot = 0,
    this.racialLeader = 0,
    this.rangeAttackTime = 0,
    this.rangeVariance = 1,
    this.rank = 0,
    this.regenHealth = 1,
    this.scriptName = '',
    this.skinLoot = 0,
    this.speedFlight = 1,
    this.speedRun = 1.14286,
    this.speedSwim = 1,
    this.speedWalk = 1,
    this.subName = '',
    this.type = 0,
    this.typeFlags = 0,
    this.unitClass = 0,
    this.unitFlags = 0,
    this.unitFlags2 = 0,
    this.vehicleId = 0,
    this.verifiedBuild = 0,
    this.creatureImmunitiesId = 0,
  });

  factory CreatureTemplateEntity.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateEntity(
      aiName: json['AIName'] ?? '',
      armorModifier: json['ArmorModifier'] ?? 1.0,
      baseAttackTime: json['BaseAttackTime'] ?? 0,
      baseVariance: json['BaseVariance'] ?? 1.0,
      damageModifier: json['DamageModifier'] ?? 1.0,
      difficultyEntry1: json['difficulty_entry_1'] ?? 0,
      difficultyEntry2: json['difficulty_entry_2'] ?? 0,
      difficultyEntry3: json['difficulty_entry_3'] ?? 0,
      damageSchool: json['dmgschool'] ?? 0,
      detectionRange: json['detection_range'] ?? 20.0,
      dynamicFlags: json['dynamicflags'] ?? 0,
      entry: json['entry'] ?? 0,
      exp: json['exp'] ?? 0,
      experienceModifier: json['ExperienceModifier'] ?? 1.0,
      faction: json['faction'] ?? 0,
      family: json['family'] ?? 0,
      flagsExtra: json['flags_extra'] ?? 0,
      gossipMenuId: json['gossip_menu_id'] ?? 0,
      healthModifier: json['HealthModifier'] ?? 1.0,
      hoverHeight: json['HoverHeight'] ?? 1.0,
      iconName: json['IconName'] ?? '',
      killCredit1: json['KillCredit1'] ?? 0,
      killCredit2: json['KillCredit2'] ?? 0,
      lootId: json['lootid'] ?? 0,
      maxGold: json['maxgold'] ?? 0,
      maxLevel: json['maxlevel'] ?? 1,
      manaModifier: json['ManaModifier'] ?? 1.0,
      minLevel: json['minlevel'] ?? 1,
      minGold: json['mingold'] ?? 0,
      movementId: json['movementId'] ?? 0,
      movementType: json['MovementType'] ?? 0,
      name: json['name'] ?? '',
      npcFlag: json['npcflag'] ?? 0,
      petSpellDataId: json['PetSpellDataId'] ?? 0,
      pickpocketLoot: json['pickpocketloot'] ?? 0,
      racialLeader: json['RacialLeader'] ?? 0,
      rangeAttackTime: json['RangeAttackTime'] ?? 0,
      rangeVariance: json['RangeVariance'] ?? 1.0,
      rank: json['rank'] ?? 0,
      regenHealth: json['RegenHealth'] ?? 1,
      scriptName: json['ScriptName'] ?? '',
      skinLoot: json['skinloot'] ?? 0,
      speedFlight: json['speed_flight'] ?? 1.0,
      speedRun: json['speed_run'] ?? 1.14286,
      speedSwim: json['speed_swim'] ?? 1.0,
      speedWalk: json['speed_walk'] ?? 1.0,
      subName: json['subname'] ?? '',
      type: json['type'] ?? 0,
      typeFlags: json['type_flags'] ?? 0,
      unitClass: json['unit_class'] ?? 0,
      unitFlags: json['unit_flags'] ?? 0,
      unitFlags2: json['unit_flags2'] ?? 0,
      vehicleId: json['VehicleId'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? 0,
      creatureImmunitiesId: json['CreatureImmunitiesId'] ?? 0,
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
}
