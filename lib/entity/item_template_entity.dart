/// 物品模板简要信息（用于列表显示）
class BriefItemTemplateEntity {
  final int entry;
  final String name;
  final String localeName;
  final int quality;
  final int classId;
  final int subclass;
  final int inventoryType;
  final int itemLevel;
  final int requiredLevel;
  final String inventoryIcon;

  const BriefItemTemplateEntity({
    this.entry = 0,
    this.name = '',
    this.localeName = '',
    this.quality = 0,
    this.classId = 0,
    this.subclass = 0,
    this.inventoryType = 0,
    this.itemLevel = 0,
    this.requiredLevel = 0,
    this.inventoryIcon = '',
  });

  factory BriefItemTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemTemplateEntity(
      entry: json['entry'] ?? 0,
      name: json['name'] ?? '',
      localeName: json['localeName'] ?? json['Name'] ?? '',
      quality: json['Quality'] ?? json['quality'] ?? 0,
      classId: json['class'] ?? json['classId'] ?? 0,
      subclass: json['subclass'] ?? 0,
      inventoryType: json['InventoryType'] ?? json['inventoryType'] ?? 0,
      itemLevel: json['ItemLevel'] ?? json['itemLevel'] ?? 0,
      requiredLevel: json['RequiredLevel'] ?? json['requiredLevel'] ?? 0,
      inventoryIcon: json['InventoryIcon0'] ?? json['inventoryIcon'] ?? '',
    );
  }

  /// 显示名称（优先显示本地化名称）
  String get displayName => localeName.isNotEmpty ? localeName : name;

  BriefItemTemplateEntity copyWith({
    int? entry,
    String? name,
    String? localeName,
    int? quality,
    int? classId,
    int? subclass,
    int? inventoryType,
    int? itemLevel,
    int? requiredLevel,
    String? inventoryIcon,
  }) {
    return BriefItemTemplateEntity(
      entry: entry ?? this.entry,
      name: name ?? this.name,
      localeName: localeName ?? this.localeName,
      quality: quality ?? this.quality,
      classId: classId ?? this.classId,
      subclass: subclass ?? this.subclass,
      inventoryType: inventoryType ?? this.inventoryType,
      itemLevel: itemLevel ?? this.itemLevel,
      requiredLevel: requiredLevel ?? this.requiredLevel,
      inventoryIcon: inventoryIcon ?? this.inventoryIcon,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'name': name,
      'quality': quality,
      'class': classId,
      'subclass': subclass,
      'InventoryType': inventoryType,
      'ItemLevel': itemLevel,
      'RequiredLevel': requiredLevel,
    };
  }
}

/// 物品模板（完整字段，对应 AzerothCore item_template 表）
class ItemTemplateEntity {
  // --- 基础标识 ---
  final int entry;
  final String name;
  final String description;

  // --- 本地化（joined，不在 toJson 中）---
  final String localeName;
  final String localeDescription;

  // --- 物品属性 ---
  final int quality;
  final int className;
  final int subclass;
  final int soundOverrideSubclass;
  final int material;
  final int displayId;
  final int inventoryType;
  final int sheath;

  // --- 经济与绑定 ---
  final int bonding;
  final int itemset;
  final int randomProperty;
  final int randomSuffix;
  final int maxDurability;
  final int buyPrice;
  final int sellPrice;
  final int buyCount;
  final int maxcount;
  final int stackable;

  // --- 分类与容器 ---
  final int totemCategory;
  final int foodType;
  final int bagFamily;
  final int containerSlots;
  final int itemLimitCategory;

  // --- 任务与限时 ---
  final int startquest;
  final int duration;
  final int disenchantId;
  final int minMoneyLoot;
  final int maxMoneyLoot;

  // --- 标志位 ---
  final int flags;
  final int flagsExtra;
  final int flagsCustom;

  // --- 武器与伤害 ---
  final int delay;
  final double rangedModRange;
  final double armorDamageModifier;
  final int dmgType1;
  final double dmgMin1;
  final double dmgMax1;
  final int dmgType2;
  final double dmgMin2;
  final double dmgMax2;
  final int ammoType;
  final int armor;
  final int block;

  // --- 缩放属性 ---
  final int scalingStatDistribution;
  final int scalingStatValue;

  // --- 统计属性（10 组）---
  final int statType1;
  final int statValue1;
  final int statType2;
  final int statValue2;
  final int statType3;
  final int statValue3;
  final int statType4;
  final int statValue4;
  final int statType5;
  final int statValue5;
  final int statType6;
  final int statValue6;
  final int statType7;
  final int statValue7;
  final int statType8;
  final int statValue8;
  final int statType9;
  final int statValue9;
  final int statType10;
  final int statValue10;

  // --- 抗性 ---
  final int holyRes;
  final int fireRes;
  final int natureRes;
  final int shadowRes;
  final int frostRes;
  final int arcaneRes;

  // --- 法术效果（5 组）---
  final int spellId1;
  final int spellTrigger1;
  final int spellCharges1;
  final double spellPpmRate1;
  final int spellCooldown1;
  final int spellCategory1;
  final int spellCategoryCooldown1;
  final int spellId2;
  final int spellTrigger2;
  final int spellCharges2;
  final double spellPpmRate2;
  final int spellCooldown2;
  final int spellCategory2;
  final int spellCategoryCooldown2;
  final int spellId3;
  final int spellTrigger3;
  final int spellCharges3;
  final double spellPpmRate3;
  final int spellCooldown3;
  final int spellCategory3;
  final int spellCategoryCooldown3;
  final int spellId4;
  final int spellTrigger4;
  final int spellCharges4;
  final double spellPpmRate4;
  final int spellCooldown4;
  final int spellCategory4;
  final int spellCategoryCooldown4;
  final int spellId5;
  final int spellTrigger5;
  final int spellCharges5;
  final double spellPpmRate5;
  final int spellCooldown5;
  final int spellCategory5;
  final int spellCategoryCooldown5;

  // --- 使用限制 ---
  final int allowableClass;
  final int allowableRace;
  final int itemLevel;
  final int requiredLevel;
  final int requiredSkill;
  final int requiredSkillRank;
  final int requiredSpell;
  final int requiredHonorRank;
  final int requiredCityRank;
  final int requiredReputationFaction;
  final int requiredReputationRank;
  final int requiredDisenchantSkill;

  // --- 区域与节日 ---
  final int mapId;
  final int area;
  final int holidayId;

  // --- 锁与宝石 ---
  final int lockid;
  final int gemProperties;
  final int socketBonus;
  final int socketColor1;
  final int socketContent1;
  final int socketColor2;
  final int socketContent2;
  final int socketColor3;
  final int socketContent3;

  // --- 图标（joined，不在 toJson 中）---
  final String inventoryIcon;

  // --- 书页信息 ---
  final int pageText;
  final int pageMaterial;
  final int languageId;

  // --- 脚本与验证 ---
  final String scriptName;
  final int verifiedBuild;

  const ItemTemplateEntity({
    // --- 基础标识 ---
    this.entry = 0,
    this.name = '',
    this.description = '',
    // --- 本地化（joined）---
    this.localeName = '',
    this.localeDescription = '',
    // --- 物品属性 ---
    this.quality = 0,
    this.className = 0,
    this.subclass = 0,
    this.soundOverrideSubclass = -1,
    this.material = 0,
    this.displayId = 0,
    this.inventoryType = 0,
    this.sheath = 0,
    // --- 经济与绑定 ---
    this.bonding = 0,
    this.itemset = 0,
    this.randomProperty = 0,
    this.randomSuffix = 0,
    this.maxDurability = 0,
    this.buyPrice = 0,
    this.sellPrice = 0,
    this.buyCount = 1,
    this.maxcount = 0,
    this.stackable = 1,
    // --- 分类与容器 ---
    this.totemCategory = 0,
    this.foodType = 0,
    this.bagFamily = 0,
    this.containerSlots = 0,
    this.itemLimitCategory = 0,
    // --- 任务与限时 ---
    this.startquest = 0,
    this.duration = 0,
    this.disenchantId = 0,
    this.minMoneyLoot = 0,
    this.maxMoneyLoot = 0,
    // --- 标志位 ---
    this.flags = 0,
    this.flagsExtra = 0,
    this.flagsCustom = 0,
    // --- 武器与伤害 ---
    this.delay = 1000,
    this.rangedModRange = 0.0,
    this.armorDamageModifier = 0.0,
    this.dmgType1 = 0,
    this.dmgMin1 = 0,
    this.dmgMax1 = 0,
    this.dmgType2 = 0,
    this.dmgMin2 = 0,
    this.dmgMax2 = 0,
    this.ammoType = 0,
    this.armor = 0,
    this.block = 0,
    // --- 缩放属性 ---
    this.scalingStatDistribution = 0,
    this.scalingStatValue = 0,
    // --- 统计属性（10 组）---
    this.statType1 = 0,
    this.statValue1 = 0,
    this.statType2 = 0,
    this.statValue2 = 0,
    this.statType3 = 0,
    this.statValue3 = 0,
    this.statType4 = 0,
    this.statValue4 = 0,
    this.statType5 = 0,
    this.statValue5 = 0,
    this.statType6 = 0,
    this.statValue6 = 0,
    this.statType7 = 0,
    this.statValue7 = 0,
    this.statType8 = 0,
    this.statValue8 = 0,
    this.statType9 = 0,
    this.statValue9 = 0,
    this.statType10 = 0,
    this.statValue10 = 0,
    // --- 抗性 ---
    this.holyRes = 0,
    this.fireRes = 0,
    this.natureRes = 0,
    this.shadowRes = 0,
    this.frostRes = 0,
    this.arcaneRes = 0,
    // --- 法术效果（5 组）---
    this.spellId1 = 0,
    this.spellTrigger1 = 0,
    this.spellCharges1 = 0,
    this.spellPpmRate1 = 0,
    this.spellCooldown1 = -1,
    this.spellCategory1 = 0,
    this.spellCategoryCooldown1 = -1,
    this.spellId2 = 0,
    this.spellTrigger2 = 0,
    this.spellCharges2 = 0,
    this.spellPpmRate2 = 0,
    this.spellCooldown2 = -1,
    this.spellCategory2 = 0,
    this.spellCategoryCooldown2 = -1,
    this.spellId3 = 0,
    this.spellTrigger3 = 0,
    this.spellCharges3 = 0,
    this.spellPpmRate3 = 0,
    this.spellCooldown3 = -1,
    this.spellCategory3 = 0,
    this.spellCategoryCooldown3 = -1,
    this.spellId4 = 0,
    this.spellTrigger4 = 0,
    this.spellCharges4 = 0,
    this.spellPpmRate4 = 0,
    this.spellCooldown4 = -1,
    this.spellCategory4 = 0,
    this.spellCategoryCooldown4 = -1,
    this.spellId5 = 0,
    this.spellTrigger5 = 0,
    this.spellCharges5 = 0,
    this.spellPpmRate5 = 0,
    this.spellCooldown5 = -1,
    this.spellCategory5 = 0,
    this.spellCategoryCooldown5 = -1,
    // --- 使用限制 ---
    this.allowableClass = -1,
    this.allowableRace = -1,
    this.itemLevel = 0,
    this.requiredLevel = 0,
    this.requiredSkill = 0,
    this.requiredSkillRank = 0,
    this.requiredSpell = 0,
    this.requiredHonorRank = 0,
    this.requiredCityRank = 0,
    this.requiredReputationFaction = 0,
    this.requiredReputationRank = 0,
    this.requiredDisenchantSkill = -1,
    // --- 区域与节日 ---
    this.mapId = 0,
    this.area = 0,
    this.holidayId = 0,
    // --- 锁与宝石 ---
    this.lockid = 0,
    this.gemProperties = 0,
    this.socketBonus = 0,
    this.socketColor1 = 0,
    this.socketContent1 = 0,
    this.socketColor2 = 0,
    this.socketContent2 = 0,
    this.socketColor3 = 0,
    this.socketContent3 = 0,
    // --- 图标（joined）---
    this.inventoryIcon = '',
    // --- 书页信息 ---
    this.pageText = 0,
    this.pageMaterial = 0,
    this.languageId = 0,
    // --- 脚本与验证 ---
    this.scriptName = '',
    this.verifiedBuild = 0,
  });

  factory ItemTemplateEntity.fromJson(Map<String, dynamic> json) {
    return ItemTemplateEntity(
      // --- 基础标识 ---
      entry: json['entry'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      // --- 本地化（joined）---
      localeName: json['localeName'] ?? json['Name'] ?? '',
      localeDescription: json['localeDescription'] ?? json['Description'] ?? '',
      // --- 物品属性 ---
      quality: json['Quality'] ?? json['quality'] ?? 0,
      className: json['class'] ?? json['className'] ?? 0,
      subclass: json['subclass'] ?? 0,
      soundOverrideSubclass:
          json['SoundOverrideSubclass'] ?? json['soundOverrideSubclass'] ?? -1,
      material: json['Material'] ?? json['material'] ?? 0,
      displayId: json['displayid'] ?? json['displayId'] ?? 0,
      inventoryType: json['InventoryType'] ?? json['inventoryType'] ?? 0,
      sheath: json['sheath'] ?? 0,
      // --- 经济与绑定 ---
      bonding: json['bonding'] ?? 0,
      itemset: json['itemset'] ?? 0,
      randomProperty: json['RandomProperty'] ?? json['randomProperty'] ?? 0,
      randomSuffix: json['RandomSuffix'] ?? json['randomSuffix'] ?? 0,
      maxDurability: json['MaxDurability'] ?? json['maxDurability'] ?? 0,
      buyPrice: json['BuyPrice'] ?? json['buyPrice'] ?? 0,
      sellPrice: json['SellPrice'] ?? json['sellPrice'] ?? 0,
      buyCount: json['BuyCount'] ?? json['buyCount'] ?? 1,
      maxcount: json['maxcount'] ?? 0,
      stackable: json['stackable'] ?? 1,
      // --- 分类与容器 ---
      totemCategory: json['TotemCategory'] ?? json['totemCategory'] ?? 0,
      foodType: json['FoodType'] ?? json['foodType'] ?? 0,
      bagFamily: json['BagFamily'] ?? json['bagFamily'] ?? 0,
      containerSlots: json['ContainerSlots'] ?? json['containerSlots'] ?? 0,
      itemLimitCategory:
          json['ItemLimitCategory'] ?? json['itemLimitCategory'] ?? 0,
      // --- 任务与限时 ---
      startquest: json['startquest'] ?? 0,
      duration: json['duration'] ?? 0,
      disenchantId: json['DisenchantID'] ?? json['disenchantId'] ?? 0,
      minMoneyLoot: json['minMoneyLoot'] ?? 0,
      maxMoneyLoot: json['maxMoneyLoot'] ?? 0,
      // --- 标志位 ---
      flags: json['Flags'] ?? json['flags'] ?? 0,
      flagsExtra: json['FlagsExtra'] ?? json['flagsExtra'] ?? 0,
      flagsCustom: json['flagsCustom'] ?? 0,
      // --- 武器与伤害 ---
      delay: json['delay'] ?? 1000,
      rangedModRange:
          ((json['RangedModRange'] ?? json['rangedModRange'] ?? 0) as num)
              .toDouble(),
      armorDamageModifier:
          ((json['ArmorDamageModifier'] ?? json['armorDamageModifier'] ?? 0)
                  as num)
              .toDouble(),
      dmgType1: json['dmg_type1'] ?? json['dmgType1'] ?? 0,
      dmgMin1: ((json['dmg_min1'] ?? json['dmgMin1'] ?? 0) as num).toDouble(),
      dmgMax1: ((json['dmg_max1'] ?? json['dmgMax1'] ?? 0) as num).toDouble(),
      dmgType2: json['dmg_type2'] ?? json['dmgType2'] ?? 0,
      dmgMin2: ((json['dmg_min2'] ?? json['dmgMin2'] ?? 0) as num).toDouble(),
      dmgMax2: ((json['dmg_max2'] ?? json['dmgMax2'] ?? 0) as num).toDouble(),
      ammoType: json['ammo_type'] ?? json['ammoType'] ?? 0,
      armor: json['armor'] ?? 0,
      block: json['block'] ?? 0,
      // --- 缩放属性 ---
      scalingStatDistribution:
          json['ScalingStatDistribution'] ??
          json['scalingStatDistribution'] ??
          0,
      scalingStatValue:
          json['ScalingStatValue'] ?? json['scalingStatValue'] ?? 0,
      // --- 统计属性（10 组）---
      statType1: json['stat_type1'] ?? json['statType1'] ?? 0,
      statValue1: json['stat_value1'] ?? json['statValue1'] ?? 0,
      statType2: json['stat_type2'] ?? json['statType2'] ?? 0,
      statValue2: json['stat_value2'] ?? json['statValue2'] ?? 0,
      statType3: json['stat_type3'] ?? json['statType3'] ?? 0,
      statValue3: json['stat_value3'] ?? json['statValue3'] ?? 0,
      statType4: json['stat_type4'] ?? json['statType4'] ?? 0,
      statValue4: json['stat_value4'] ?? json['statValue4'] ?? 0,
      statType5: json['stat_type5'] ?? json['statType5'] ?? 0,
      statValue5: json['stat_value5'] ?? json['statValue5'] ?? 0,
      statType6: json['stat_type6'] ?? json['statType6'] ?? 0,
      statValue6: json['stat_value6'] ?? json['statValue6'] ?? 0,
      statType7: json['stat_type7'] ?? json['statType7'] ?? 0,
      statValue7: json['stat_value7'] ?? json['statValue7'] ?? 0,
      statType8: json['stat_type8'] ?? json['statType8'] ?? 0,
      statValue8: json['stat_value8'] ?? json['statValue8'] ?? 0,
      statType9: json['stat_type9'] ?? json['statType9'] ?? 0,
      statValue9: json['stat_value9'] ?? json['statValue9'] ?? 0,
      statType10: json['stat_type10'] ?? json['statType10'] ?? 0,
      statValue10: json['stat_value10'] ?? json['statValue10'] ?? 0,
      // --- 抗性 ---
      holyRes: json['holy_res'] ?? json['holyRes'] ?? 0,
      fireRes: json['fire_res'] ?? json['fireRes'] ?? 0,
      natureRes: json['nature_res'] ?? json['natureRes'] ?? 0,
      shadowRes: json['shadow_res'] ?? json['shadowRes'] ?? 0,
      frostRes: json['frost_res'] ?? json['frostRes'] ?? 0,
      arcaneRes: json['arcane_res'] ?? json['arcaneRes'] ?? 0,
      // --- 法术效果（5 组）---
      spellId1: json['spellid_1'] ?? json['spellId1'] ?? 0,
      spellTrigger1: json['spelltrigger_1'] ?? json['spellTrigger1'] ?? 0,
      spellCharges1: json['spellcharges_1'] ?? json['spellCharges1'] ?? 0,
      spellPpmRate1:
          ((json['spellppmRate_1'] ?? json['spellPpmRate1'] ?? 0) as num)
              .toDouble(),
      spellCooldown1: json['spellcooldown_1'] ?? json['spellCooldown1'] ?? -1,
      spellCategory1: json['spellcategory_1'] ?? json['spellCategory1'] ?? 0,
      spellCategoryCooldown1:
          json['spellcategorycooldown_1'] ??
          json['spellCategoryCooldown1'] ??
          -1,
      spellId2: json['spellid_2'] ?? json['spellId2'] ?? 0,
      spellTrigger2: json['spelltrigger_2'] ?? json['spellTrigger2'] ?? 0,
      spellCharges2: json['spellcharges_2'] ?? json['spellCharges2'] ?? 0,
      spellPpmRate2:
          ((json['spellppmRate_2'] ?? json['spellPpmRate2'] ?? 0) as num)
              .toDouble(),
      spellCooldown2: json['spellcooldown_2'] ?? json['spellCooldown2'] ?? -1,
      spellCategory2: json['spellcategory_2'] ?? json['spellCategory2'] ?? 0,
      spellCategoryCooldown2:
          json['spellcategorycooldown_2'] ??
          json['spellCategoryCooldown2'] ??
          -1,
      spellId3: json['spellid_3'] ?? json['spellId3'] ?? 0,
      spellTrigger3: json['spelltrigger_3'] ?? json['spellTrigger3'] ?? 0,
      spellCharges3: json['spellcharges_3'] ?? json['spellCharges3'] ?? 0,
      spellPpmRate3:
          ((json['spellppmRate_3'] ?? json['spellPpmRate3'] ?? 0) as num)
              .toDouble(),
      spellCooldown3: json['spellcooldown_3'] ?? json['spellCooldown3'] ?? -1,
      spellCategory3: json['spellcategory_3'] ?? json['spellCategory3'] ?? 0,
      spellCategoryCooldown3:
          json['spellcategorycooldown_3'] ??
          json['spellCategoryCooldown3'] ??
          -1,
      spellId4: json['spellid_4'] ?? json['spellId4'] ?? 0,
      spellTrigger4: json['spelltrigger_4'] ?? json['spellTrigger4'] ?? 0,
      spellCharges4: json['spellcharges_4'] ?? json['spellCharges4'] ?? 0,
      spellPpmRate4:
          ((json['spellppmRate_4'] ?? json['spellPpmRate4'] ?? 0) as num)
              .toDouble(),
      spellCooldown4: json['spellcooldown_4'] ?? json['spellCooldown4'] ?? -1,
      spellCategory4: json['spellcategory_4'] ?? json['spellCategory4'] ?? 0,
      spellCategoryCooldown4:
          json['spellcategorycooldown_4'] ??
          json['spellCategoryCooldown4'] ??
          -1,
      spellId5: json['spellid_5'] ?? json['spellId5'] ?? 0,
      spellTrigger5: json['spelltrigger_5'] ?? json['spellTrigger5'] ?? 0,
      spellCharges5: json['spellcharges_5'] ?? json['spellCharges5'] ?? 0,
      spellPpmRate5:
          ((json['spellppmRate_5'] ?? json['spellPpmRate5'] ?? 0) as num)
              .toDouble(),
      spellCooldown5: json['spellcooldown_5'] ?? json['spellCooldown5'] ?? -1,
      spellCategory5: json['spellcategory_5'] ?? json['spellCategory5'] ?? 0,
      spellCategoryCooldown5:
          json['spellcategorycooldown_5'] ??
          json['spellCategoryCooldown5'] ??
          -1,
      // --- 使用限制 ---
      allowableClass: json['AllowableClass'] ?? -1,
      allowableRace: json['AllowableRace'] ?? json['allowableRace'] ?? -1,
      itemLevel: json['ItemLevel'] ?? json['itemLevel'] ?? 0,
      requiredLevel: json['RequiredLevel'] ?? json['requiredLevel'] ?? 0,
      requiredSkill: json['RequiredSkill'] ?? json['requiredSkill'] ?? 0,
      requiredSkillRank:
          json['RequiredSkillRank'] ?? json['requiredSkillRank'] ?? 0,
      requiredSpell: json['requiredspell'] ?? json['requiredSpell'] ?? 0,
      requiredHonorRank:
          json['requiredhonorrank'] ?? json['requiredHonorRank'] ?? 0,
      requiredCityRank:
          json['RequiredCityRank'] ?? json['requiredCityRank'] ?? 0,
      requiredReputationFaction:
          json['RequiredReputationFaction'] ??
          json['requiredReputationFaction'] ??
          0,
      requiredReputationRank:
          json['RequiredReputationRank'] ?? json['requiredReputationRank'] ?? 0,
      requiredDisenchantSkill:
          json['RequiredDisenchantSkill'] ??
          json['requiredDisenchantSkill'] ??
          -1,
      // --- 区域与节日 ---
      mapId: json['Map'] ?? json['mapId'] ?? 0,
      area: json['area'] ?? 0,
      holidayId: json['HolidayId'] ?? json['holidayId'] ?? 0,
      // --- 锁与宝石 ---
      lockid: json['lockid'] ?? 0,
      gemProperties: json['GemProperties'] ?? json['gemProperties'] ?? 0,
      socketBonus: json['socketBonus'] ?? 0,
      socketColor1: json['socketColor_1'] ?? json['socketColor1'] ?? 0,
      socketContent1: json['socketContent_1'] ?? json['socketContent1'] ?? 0,
      socketColor2: json['socketColor_2'] ?? json['socketColor2'] ?? 0,
      socketContent2: json['socketContent_2'] ?? json['socketContent2'] ?? 0,
      socketColor3: json['socketColor_3'] ?? json['socketColor3'] ?? 0,
      socketContent3: json['socketContent_3'] ?? json['socketContent3'] ?? 0,
      // --- 图标（joined）---
      inventoryIcon: json['InventoryIcon0'] ?? json['inventoryIcon'] ?? '',
      // --- 书页信息 ---
      pageText: json['PageText'] ?? json['pageText'] ?? 0,
      pageMaterial: json['PageMaterial'] ?? json['pageMaterial'] ?? 0,
      languageId: json['LanguageID'] ?? json['languageId'] ?? 0,
      // --- 脚本与验证 ---
      scriptName: json['ScriptName'] ?? json['scriptName'] ?? '',
      verifiedBuild: json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0,
    );
  }

  /// 显示描述（优先显示本地化描述）
  String get displayDescription =>
      localeDescription.isNotEmpty ? localeDescription : description;

  /// 显示名称（优先显示本地化名称）
  String get displayName => localeName.isNotEmpty ? localeName : name;

  /// AzerothCore derives StatsCount from non-zero stat values at load time.
  int get statsCount =>
      (statValue1 != 0 ? 1 : 0) +
      (statValue2 != 0 ? 1 : 0) +
      (statValue3 != 0 ? 1 : 0) +
      (statValue4 != 0 ? 1 : 0) +
      (statValue5 != 0 ? 1 : 0) +
      (statValue6 != 0 ? 1 : 0) +
      (statValue7 != 0 ? 1 : 0) +
      (statValue8 != 0 ? 1 : 0) +
      (statValue9 != 0 ? 1 : 0) +
      (statValue10 != 0 ? 1 : 0);

  ItemTemplateEntity copyWith({
    int? entry,
    String? name,
    String? description,
    String? localeName,
    String? localeDescription,
    int? quality,
    int? className,
    int? subclass,
    int? soundOverrideSubclass,
    int? material,
    int? displayId,
    int? inventoryType,
    int? sheath,
    int? bonding,
    int? itemset,
    int? randomProperty,
    int? randomSuffix,
    int? maxDurability,
    int? buyPrice,
    int? sellPrice,
    int? buyCount,
    int? maxcount,
    int? stackable,
    int? totemCategory,
    int? foodType,
    int? bagFamily,
    int? containerSlots,
    int? itemLimitCategory,
    int? startquest,
    int? duration,
    int? disenchantId,
    int? minMoneyLoot,
    int? maxMoneyLoot,
    int? flags,
    int? flagsExtra,
    int? flagsCustom,
    int? delay,
    double? rangedModRange,
    double? armorDamageModifier,
    int? dmgType1,
    double? dmgMin1,
    double? dmgMax1,
    int? dmgType2,
    double? dmgMin2,
    double? dmgMax2,
    int? ammoType,
    int? armor,
    int? block,
    int? scalingStatDistribution,
    int? scalingStatValue,
    int? statType1,
    int? statValue1,
    int? statType2,
    int? statValue2,
    int? statType3,
    int? statValue3,
    int? statType4,
    int? statValue4,
    int? statType5,
    int? statValue5,
    int? statType6,
    int? statValue6,
    int? statType7,
    int? statValue7,
    int? statType8,
    int? statValue8,
    int? statType9,
    int? statValue9,
    int? statType10,
    int? statValue10,
    int? holyRes,
    int? fireRes,
    int? natureRes,
    int? shadowRes,
    int? frostRes,
    int? arcaneRes,
    int? spellId1,
    int? spellTrigger1,
    int? spellCharges1,
    double? spellPpmRate1,
    int? spellCooldown1,
    int? spellCategory1,
    int? spellCategoryCooldown1,
    int? spellId2,
    int? spellTrigger2,
    int? spellCharges2,
    double? spellPpmRate2,
    int? spellCooldown2,
    int? spellCategory2,
    int? spellCategoryCooldown2,
    int? spellId3,
    int? spellTrigger3,
    int? spellCharges3,
    double? spellPpmRate3,
    int? spellCooldown3,
    int? spellCategory3,
    int? spellCategoryCooldown3,
    int? spellId4,
    int? spellTrigger4,
    int? spellCharges4,
    double? spellPpmRate4,
    int? spellCooldown4,
    int? spellCategory4,
    int? spellCategoryCooldown4,
    int? spellId5,
    int? spellTrigger5,
    int? spellCharges5,
    double? spellPpmRate5,
    int? spellCooldown5,
    int? spellCategory5,
    int? spellCategoryCooldown5,
    int? allowableClass,
    int? allowableRace,
    int? itemLevel,
    int? requiredLevel,
    int? requiredSkill,
    int? requiredSkillRank,
    int? requiredSpell,
    int? requiredHonorRank,
    int? requiredCityRank,
    int? requiredReputationFaction,
    int? requiredReputationRank,
    int? requiredDisenchantSkill,
    int? mapId,
    int? area,
    int? holidayId,
    int? lockid,
    int? gemProperties,
    int? socketBonus,
    int? socketColor1,
    int? socketContent1,
    int? socketColor2,
    int? socketContent2,
    int? socketColor3,
    int? socketContent3,
    String? inventoryIcon,
    int? pageText,
    int? pageMaterial,
    int? languageId,
    String? scriptName,
    int? verifiedBuild,
  }) {
    return ItemTemplateEntity(
      entry: entry ?? this.entry,
      name: name ?? this.name,
      description: description ?? this.description,
      localeName: localeName ?? this.localeName,
      localeDescription: localeDescription ?? this.localeDescription,
      quality: quality ?? this.quality,
      className: className ?? this.className,
      subclass: subclass ?? this.subclass,
      soundOverrideSubclass:
          soundOverrideSubclass ?? this.soundOverrideSubclass,
      material: material ?? this.material,
      displayId: displayId ?? this.displayId,
      inventoryType: inventoryType ?? this.inventoryType,
      sheath: sheath ?? this.sheath,
      bonding: bonding ?? this.bonding,
      itemset: itemset ?? this.itemset,
      randomProperty: randomProperty ?? this.randomProperty,
      randomSuffix: randomSuffix ?? this.randomSuffix,
      maxDurability: maxDurability ?? this.maxDurability,
      buyPrice: buyPrice ?? this.buyPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      buyCount: buyCount ?? this.buyCount,
      maxcount: maxcount ?? this.maxcount,
      stackable: stackable ?? this.stackable,
      totemCategory: totemCategory ?? this.totemCategory,
      foodType: foodType ?? this.foodType,
      bagFamily: bagFamily ?? this.bagFamily,
      containerSlots: containerSlots ?? this.containerSlots,
      itemLimitCategory: itemLimitCategory ?? this.itemLimitCategory,
      startquest: startquest ?? this.startquest,
      duration: duration ?? this.duration,
      disenchantId: disenchantId ?? this.disenchantId,
      minMoneyLoot: minMoneyLoot ?? this.minMoneyLoot,
      maxMoneyLoot: maxMoneyLoot ?? this.maxMoneyLoot,
      flags: flags ?? this.flags,
      flagsExtra: flagsExtra ?? this.flagsExtra,
      flagsCustom: flagsCustom ?? this.flagsCustom,
      delay: delay ?? this.delay,
      rangedModRange: rangedModRange ?? this.rangedModRange,
      armorDamageModifier: armorDamageModifier ?? this.armorDamageModifier,
      dmgType1: dmgType1 ?? this.dmgType1,
      dmgMin1: dmgMin1 ?? this.dmgMin1,
      dmgMax1: dmgMax1 ?? this.dmgMax1,
      dmgType2: dmgType2 ?? this.dmgType2,
      dmgMin2: dmgMin2 ?? this.dmgMin2,
      dmgMax2: dmgMax2 ?? this.dmgMax2,
      ammoType: ammoType ?? this.ammoType,
      armor: armor ?? this.armor,
      block: block ?? this.block,
      scalingStatDistribution:
          scalingStatDistribution ?? this.scalingStatDistribution,
      scalingStatValue: scalingStatValue ?? this.scalingStatValue,
      statType1: statType1 ?? this.statType1,
      statValue1: statValue1 ?? this.statValue1,
      statType2: statType2 ?? this.statType2,
      statValue2: statValue2 ?? this.statValue2,
      statType3: statType3 ?? this.statType3,
      statValue3: statValue3 ?? this.statValue3,
      statType4: statType4 ?? this.statType4,
      statValue4: statValue4 ?? this.statValue4,
      statType5: statType5 ?? this.statType5,
      statValue5: statValue5 ?? this.statValue5,
      statType6: statType6 ?? this.statType6,
      statValue6: statValue6 ?? this.statValue6,
      statType7: statType7 ?? this.statType7,
      statValue7: statValue7 ?? this.statValue7,
      statType8: statType8 ?? this.statType8,
      statValue8: statValue8 ?? this.statValue8,
      statType9: statType9 ?? this.statType9,
      statValue9: statValue9 ?? this.statValue9,
      statType10: statType10 ?? this.statType10,
      statValue10: statValue10 ?? this.statValue10,
      holyRes: holyRes ?? this.holyRes,
      fireRes: fireRes ?? this.fireRes,
      natureRes: natureRes ?? this.natureRes,
      shadowRes: shadowRes ?? this.shadowRes,
      frostRes: frostRes ?? this.frostRes,
      arcaneRes: arcaneRes ?? this.arcaneRes,
      spellId1: spellId1 ?? this.spellId1,
      spellTrigger1: spellTrigger1 ?? this.spellTrigger1,
      spellCharges1: spellCharges1 ?? this.spellCharges1,
      spellPpmRate1: spellPpmRate1 ?? this.spellPpmRate1,
      spellCooldown1: spellCooldown1 ?? this.spellCooldown1,
      spellCategory1: spellCategory1 ?? this.spellCategory1,
      spellCategoryCooldown1:
          spellCategoryCooldown1 ?? this.spellCategoryCooldown1,
      spellId2: spellId2 ?? this.spellId2,
      spellTrigger2: spellTrigger2 ?? this.spellTrigger2,
      spellCharges2: spellCharges2 ?? this.spellCharges2,
      spellPpmRate2: spellPpmRate2 ?? this.spellPpmRate2,
      spellCooldown2: spellCooldown2 ?? this.spellCooldown2,
      spellCategory2: spellCategory2 ?? this.spellCategory2,
      spellCategoryCooldown2:
          spellCategoryCooldown2 ?? this.spellCategoryCooldown2,
      spellId3: spellId3 ?? this.spellId3,
      spellTrigger3: spellTrigger3 ?? this.spellTrigger3,
      spellCharges3: spellCharges3 ?? this.spellCharges3,
      spellPpmRate3: spellPpmRate3 ?? this.spellPpmRate3,
      spellCooldown3: spellCooldown3 ?? this.spellCooldown3,
      spellCategory3: spellCategory3 ?? this.spellCategory3,
      spellCategoryCooldown3:
          spellCategoryCooldown3 ?? this.spellCategoryCooldown3,
      spellId4: spellId4 ?? this.spellId4,
      spellTrigger4: spellTrigger4 ?? this.spellTrigger4,
      spellCharges4: spellCharges4 ?? this.spellCharges4,
      spellPpmRate4: spellPpmRate4 ?? this.spellPpmRate4,
      spellCooldown4: spellCooldown4 ?? this.spellCooldown4,
      spellCategory4: spellCategory4 ?? this.spellCategory4,
      spellCategoryCooldown4:
          spellCategoryCooldown4 ?? this.spellCategoryCooldown4,
      spellId5: spellId5 ?? this.spellId5,
      spellTrigger5: spellTrigger5 ?? this.spellTrigger5,
      spellCharges5: spellCharges5 ?? this.spellCharges5,
      spellPpmRate5: spellPpmRate5 ?? this.spellPpmRate5,
      spellCooldown5: spellCooldown5 ?? this.spellCooldown5,
      spellCategory5: spellCategory5 ?? this.spellCategory5,
      spellCategoryCooldown5:
          spellCategoryCooldown5 ?? this.spellCategoryCooldown5,
      allowableClass: allowableClass ?? this.allowableClass,
      allowableRace: allowableRace ?? this.allowableRace,
      itemLevel: itemLevel ?? this.itemLevel,
      requiredLevel: requiredLevel ?? this.requiredLevel,
      requiredSkill: requiredSkill ?? this.requiredSkill,
      requiredSkillRank: requiredSkillRank ?? this.requiredSkillRank,
      requiredSpell: requiredSpell ?? this.requiredSpell,
      requiredHonorRank: requiredHonorRank ?? this.requiredHonorRank,
      requiredCityRank: requiredCityRank ?? this.requiredCityRank,
      requiredReputationFaction:
          requiredReputationFaction ?? this.requiredReputationFaction,
      requiredReputationRank:
          requiredReputationRank ?? this.requiredReputationRank,
      requiredDisenchantSkill:
          requiredDisenchantSkill ?? this.requiredDisenchantSkill,
      mapId: mapId ?? this.mapId,
      area: area ?? this.area,
      holidayId: holidayId ?? this.holidayId,
      lockid: lockid ?? this.lockid,
      gemProperties: gemProperties ?? this.gemProperties,
      socketBonus: socketBonus ?? this.socketBonus,
      socketColor1: socketColor1 ?? this.socketColor1,
      socketContent1: socketContent1 ?? this.socketContent1,
      socketColor2: socketColor2 ?? this.socketColor2,
      socketContent2: socketContent2 ?? this.socketContent2,
      socketColor3: socketColor3 ?? this.socketColor3,
      socketContent3: socketContent3 ?? this.socketContent3,
      inventoryIcon: inventoryIcon ?? this.inventoryIcon,
      pageText: pageText ?? this.pageText,
      pageMaterial: pageMaterial ?? this.pageMaterial,
      languageId: languageId ?? this.languageId,
      scriptName: scriptName ?? this.scriptName,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      // --- 基础标识 ---
      'entry': entry,
      'name': name,
      'description': description,

      // --- 物品属性 ---
      'Quality': quality,
      'class': className,
      'subclass': subclass,
      'SoundOverrideSubclass': soundOverrideSubclass,
      'Material': material,
      'displayid': displayId,
      'InventoryType': inventoryType,
      'sheath': sheath,

      // --- 经济与绑定 ---
      'bonding': bonding,
      'itemset': itemset,
      'RandomProperty': randomProperty,
      'RandomSuffix': randomSuffix,
      'MaxDurability': maxDurability,
      'BuyPrice': buyPrice,
      'SellPrice': sellPrice,
      'BuyCount': buyCount,
      'maxcount': maxcount,
      'stackable': stackable,

      // --- 分类与容器 ---
      'TotemCategory': totemCategory,
      'FoodType': foodType,
      'BagFamily': bagFamily,
      'ContainerSlots': containerSlots,
      'ItemLimitCategory': itemLimitCategory,

      // --- 任务与限时 ---
      'startquest': startquest,
      'duration': duration,
      'DisenchantID': disenchantId,
      'minMoneyLoot': minMoneyLoot,
      'maxMoneyLoot': maxMoneyLoot,

      // --- 标志位 ---
      'Flags': flags,
      'FlagsExtra': flagsExtra,
      'flagsCustom': flagsCustom,

      // --- 武器与伤害 ---
      'delay': delay,
      'RangedModRange': rangedModRange,
      'ArmorDamageModifier': armorDamageModifier,
      'dmg_type1': dmgType1,
      'dmg_min1': dmgMin1,
      'dmg_max1': dmgMax1,
      'dmg_type2': dmgType2,
      'dmg_min2': dmgMin2,
      'dmg_max2': dmgMax2,
      'ammo_type': ammoType,
      'armor': armor,
      'block': block,

      // --- 缩放属性 ---
      'ScalingStatDistribution': scalingStatDistribution,
      'ScalingStatValue': scalingStatValue,

      // --- 统计属性 ---
      'stat_type1': statType1,
      'stat_value1': statValue1,
      'stat_type2': statType2,
      'stat_value2': statValue2,
      'stat_type3': statType3,
      'stat_value3': statValue3,
      'stat_type4': statType4,
      'stat_value4': statValue4,
      'stat_type5': statType5,
      'stat_value5': statValue5,
      'stat_type6': statType6,
      'stat_value6': statValue6,
      'stat_type7': statType7,
      'stat_value7': statValue7,
      'stat_type8': statType8,
      'stat_value8': statValue8,
      'stat_type9': statType9,
      'stat_value9': statValue9,
      'stat_type10': statType10,
      'stat_value10': statValue10,
    };

    // --- 抗性 ---
    result['holy_res'] = holyRes;
    result['fire_res'] = fireRes;
    result['nature_res'] = natureRes;
    result['shadow_res'] = shadowRes;
    result['frost_res'] = frostRes;
    result['arcane_res'] = arcaneRes;

    // --- 法术效果（5 组）---
    result['spellid_1'] = spellId1;
    result['spelltrigger_1'] = spellTrigger1;
    result['spellcharges_1'] = spellCharges1;
    result['spellppmRate_1'] = spellPpmRate1;
    result['spellcooldown_1'] = spellCooldown1;
    result['spellcategory_1'] = spellCategory1;
    result['spellcategorycooldown_1'] = spellCategoryCooldown1;
    result['spellid_2'] = spellId2;
    result['spelltrigger_2'] = spellTrigger2;
    result['spellcharges_2'] = spellCharges2;
    result['spellppmRate_2'] = spellPpmRate2;
    result['spellcooldown_2'] = spellCooldown2;
    result['spellcategory_2'] = spellCategory2;
    result['spellcategorycooldown_2'] = spellCategoryCooldown2;
    result['spellid_3'] = spellId3;
    result['spelltrigger_3'] = spellTrigger3;
    result['spellcharges_3'] = spellCharges3;
    result['spellppmRate_3'] = spellPpmRate3;
    result['spellcooldown_3'] = spellCooldown3;
    result['spellcategory_3'] = spellCategory3;
    result['spellcategorycooldown_3'] = spellCategoryCooldown3;
    result['spellid_4'] = spellId4;
    result['spelltrigger_4'] = spellTrigger4;
    result['spellcharges_4'] = spellCharges4;
    result['spellppmRate_4'] = spellPpmRate4;
    result['spellcooldown_4'] = spellCooldown4;
    result['spellcategory_4'] = spellCategory4;
    result['spellcategorycooldown_4'] = spellCategoryCooldown4;
    result['spellid_5'] = spellId5;
    result['spelltrigger_5'] = spellTrigger5;
    result['spellcharges_5'] = spellCharges5;
    result['spellppmRate_5'] = spellPpmRate5;
    result['spellcooldown_5'] = spellCooldown5;
    result['spellcategory_5'] = spellCategory5;
    result['spellcategorycooldown_5'] = spellCategoryCooldown5;

    // --- 使用限制 ---
    result['AllowableClass'] = allowableClass;
    result['AllowableRace'] = allowableRace;
    result['ItemLevel'] = itemLevel;
    result['RequiredLevel'] = requiredLevel;
    result['RequiredSkill'] = requiredSkill;
    result['RequiredSkillRank'] = requiredSkillRank;
    result['requiredspell'] = requiredSpell;
    result['requiredhonorrank'] = requiredHonorRank;
    result['RequiredCityRank'] = requiredCityRank;
    result['RequiredReputationFaction'] = requiredReputationFaction;
    result['RequiredReputationRank'] = requiredReputationRank;
    result['RequiredDisenchantSkill'] = requiredDisenchantSkill;

    // --- 区域与节日 ---
    result['Map'] = mapId;
    result['area'] = area;
    result['HolidayId'] = holidayId;

    // --- 锁与宝石 ---
    result['lockid'] = lockid;
    result['GemProperties'] = gemProperties;
    result['socketBonus'] = socketBonus;
    result['socketColor_1'] = socketColor1;
    result['socketContent_1'] = socketContent1;
    result['socketColor_2'] = socketColor2;
    result['socketContent_2'] = socketContent2;
    result['socketColor_3'] = socketColor3;
    result['socketContent_3'] = socketContent3;

    // --- 书页信息 ---
    result['PageText'] = pageText;
    result['PageMaterial'] = pageMaterial;
    result['LanguageID'] = languageId;

    // --- 脚本与验证 ---
    result['ScriptName'] = scriptName;
    result['VerifiedBuild'] = verifiedBuild;

    return result;
  }
}
