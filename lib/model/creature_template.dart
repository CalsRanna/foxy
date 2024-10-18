class BriefCreatureTemplate {
  int entry = 0;
  String name = '';
  String subName = '';
  int minLevel = 0;
  int maxLevel = 0;

  BriefCreatureTemplate();

  BriefCreatureTemplate.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? 0;
    name = json['name'] ?? '';
    subName = json['subname'] ?? '';
    minLevel = json['minlevel'] ?? 0;
    maxLevel = json['maxlevel'] ?? 0;
  }
}

class CreatureTemplate {
  String aiName = '';
  double armorModifier = 1;
  int baseAttackTime = 0;
  double baseVariance = 1;
  double damageModifier = 1;
  int difficultyEntry1 = 0;
  int difficultyEntry2 = 0;
  int difficultyEntry3 = 0;
  int dmgschool = 0;
  int dynamicflags = 0;
  int entry = 0;
  int exp = 0;
  double experienceModifier = 1;
  int faction = 0;
  int family = 0;
  int flagsExtra = 0;
  int gossipMenuId = 0;
  double healthModifier = 1;
  double hoverHeight = 1;
  String iconName = '';
  int killCredit1 = 0;
  int killCredit2 = 0;
  int lootid = 0;
  int maxgold = 0;
  int maxlevel = 1;
  double manaModifier = 1;
  int mechanicImmuneMask = 0;
  int minlevel = 1;
  int mingold = 0;
  int modelid1 = 0;
  int modelid2 = 0;
  int modelid3 = 0;
  int modelid4 = 0;
  int movementId = 0;
  int movementType = 0;
  String name = '';
  int npcflag = 0;
  int petSpellDataId = 0;
  int pickpocketloot = 0;
  int racialLeader = 0;
  int rangeAttackTime = 0;
  double rangeVariance = 1;
  int rank = 0;
  int regenHealth = 1;
  double scale = 1;
  String scriptName = '';
  int skinloot = 0;
  double speedRun = 1.14286;
  double speedWalk = 1;
  int spellSchoolImmuneMask = 0;
  String subname = '';
  int type = 0;
  int typeFlags = 0;
  int unitClass = 0;
  int unitFlags = 0;
  int unitFlags2 = 0;
  int vehicleId = 0;
  int? verifiedBuild;

  CreatureTemplate();

  CreatureTemplate.fromJson(Map<String, dynamic> json) {
    aiName = json['AIName'] ?? '';
    armorModifier = json['ArmorModifier'] ?? 1.0;
    baseAttackTime = json['BaseAttackTime'] ?? 0;
    baseVariance = json['BaseVariance'] ?? 1.0;
    damageModifier = json['DamageModifier'] ?? 1.0;
    difficultyEntry1 = json['difficulty_entry_1'] ?? 0;
    difficultyEntry2 = json['difficulty_entry_2'] ?? 0;
    difficultyEntry3 = json['difficulty_entry_3'] ?? 0;
    dmgschool = json['dmgschool'] ?? 0;
    dynamicflags = json['dynamicflags'] ?? 0;
    entry = json['entry'] ?? 0;
    exp = json['exp'] ?? 0;
    experienceModifier = json['ExperienceModifier'] ?? 1.0;
    faction = json['faction'] ?? 0;
    family = json['family'] ?? 0;
    flagsExtra = json['flags_extra'] ?? 0;
    gossipMenuId = json['gossip_menu_id'] ?? 0;
    healthModifier = json['HealthModifier'] ?? 1.0;
    hoverHeight = json['HoverHeight'] ?? 1.0;
    iconName = json['IconName'] ?? '';
    killCredit1 = json['KillCredit1'] ?? 0;
    killCredit2 = json['KillCredit2'] ?? 0;
    lootid = json['lootid'] ?? 0;
    maxgold = json['maxgold'] ?? 0;
    maxlevel = json['maxlevel'] ?? 1;
    manaModifier = json['ManaModifier'] ?? 1.0;
    mechanicImmuneMask = json['mechanic_immune_mask'] ?? 0;
    minlevel = json['minlevel'] ?? 1;
    mingold = json['mingold'] ?? 0;
    modelid1 = json['modelid1'] ?? 0;
    modelid2 = json['modelid2'] ?? 0;
    modelid3 = json['modelid3'] ?? 0;
    modelid4 = json['modelid4'] ?? 0;
    movementId = json['movementId'] ?? 0;
    movementType = json['MovementType'] ?? 0;
    name = json['name'] ?? '';
    npcflag = json['npcflag'] ?? 0;
    petSpellDataId = json['PetSpellDataId'] ?? 0;
    pickpocketloot = json['pickpocketloot'] ?? 0;
    racialLeader = json['RacialLeader'] ?? 0;
    rangeAttackTime = json['RangeAttackTime'] ?? 0;
    rangeVariance = json['RangeVariance'] ?? 1.0;
    rank = json['rank'] ?? 0;
    regenHealth = json['RegenHealth'] ?? 1;
    scale = json['scale'] ?? 1.0;
    scriptName = json['ScriptName'] ?? '';
    skinloot = json['skinloot'] ?? 0;
    speedRun = json['speed_run'] ?? 1.14286;
    speedWalk = json['speed_walk'] ?? 1.0;
    spellSchoolImmuneMask = json['spell_school_immune_mask'] ?? 0;
    subname = json['subname'] ?? '';
    type = json['type'] ?? 0;
    typeFlags = json['type_flags'] ?? 0;
    unitClass = json['unit_class'] ?? 0;
    unitFlags = json['unit_flags'] ?? 0;
    unitFlags2 = json['unit_flags2'] ?? 0;
    vehicleId = json['VehicleId'] ?? 0;
    verifiedBuild = json['VerifiedBuild'];
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
      'dmgschool': dmgschool,
      'dynamicflags': dynamicflags,
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
      'lootid': lootid,
      'maxgold': maxgold,
      'maxlevel': maxlevel,
      'ManaModifier': manaModifier,
      'mechanic_immune_mask': mechanicImmuneMask,
      'minlevel': minlevel,
      'mingold': mingold,
      'modelid1': modelid1,
      'modelid2': modelid2,
      'modelid3': modelid3,
      'modelid4': modelid4,
      'movementId': movementId,
      'MovementType': movementType,
      'name': name,
      'npcflag': npcflag,
      'PetSpellDataId': petSpellDataId,
      'pickpocketloot': pickpocketloot,
      'RacialLeader': racialLeader,
      'RangeAttackTime': rangeAttackTime,
      'RangeVariance': rangeVariance,
      'rank': rank,
      'RegenHealth': regenHealth,
      'scale': scale,
      'ScriptName': scriptName,
      'skinloot': skinloot,
      'speed_run': speedRun,
      'speed_walk': speedWalk,
      'spell_school_immune_mask': spellSchoolImmuneMask,
      'subname': subname,
      'type': type,
      'type_flags': typeFlags,
      'unit_class': unitClass,
      'unit_flags': unitFlags,
      'unit_flags2': unitFlags2,
      'VehicleId': vehicleId,
      'VerifiedBuild': verifiedBuild
    };
  }
}
