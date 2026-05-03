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
  final int rangedModRange;
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
  final int statsCount;
  final List<int> statTypes;
  final List<int> statValues;

  // --- 抗性 ---
  final int holyRes;
  final int fireRes;
  final int natureRes;
  final int shadowRes;
  final int frostRes;
  final int arcaneRes;

  // --- 法术效果（5 组）---
  final List<int> spellIds;
  final List<int> spellTriggers;
  final List<int> spellCharges;
  final List<double> spellPpmRates;
  final List<int> spellCooldowns;
  final List<int> spellCategories;
  final List<int> spellCategoryCooldowns;

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
  final List<int> socketColors;
  final List<int> socketContents;

  // --- 图标（joined，不在 toJson 中）---
  final String inventoryIcon;

  // --- 书页信息 ---
  final int pageText;
  final int pageMaterial;
  final int languageId;

  // --- 脚本与验证 ---
  final String scriptName;
  final int verifiedBuild;

  /// 显示名称（优先显示本地化名称）
  String get displayName => localeName.isNotEmpty ? localeName : name;

  /// 显示描述（优先显示本地化描述）
  String get displayDescription =>
      localeDescription.isNotEmpty ? localeDescription : description;

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
    this.soundOverrideSubclass = 0,
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
    this.buyCount = 0,
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
    this.delay = 0,
    this.rangedModRange = 0,
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
    this.statsCount = 0,
    this.statTypes = const [],
    this.statValues = const [],
    // --- 抗性 ---
    this.holyRes = 0,
    this.fireRes = 0,
    this.natureRes = 0,
    this.shadowRes = 0,
    this.frostRes = 0,
    this.arcaneRes = 0,
    // --- 法术效果（5 组）---
    this.spellIds = const [],
    this.spellTriggers = const [],
    this.spellCharges = const [],
    this.spellPpmRates = const [],
    this.spellCooldowns = const [],
    this.spellCategories = const [],
    this.spellCategoryCooldowns = const [],
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
    this.requiredDisenchantSkill = 0,
    // --- 区域与节日 ---
    this.mapId = 0,
    this.area = 0,
    this.holidayId = 0,
    // --- 锁与宝石 ---
    this.lockid = 0,
    this.gemProperties = 0,
    this.socketBonus = 0,
    this.socketColors = const [],
    this.socketContents = const [],
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
          json['SoundOverrideSubclass'] ?? json['soundOverrideSubclass'] ?? 0,
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
      buyCount: json['BuyCount'] ?? json['buyCount'] ?? 0,
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
      delay: json['delay'] ?? 0,
      rangedModRange:
          json['RangedModRange'] ?? json['rangedModRange'] ?? 0,
      armorDamageModifier:
          (json['ArmorDamageModifier'] ?? json['armorDamageModifier'] ?? 0.0)
              as double,
      dmgType1: json['dmg_type1'] ?? json['dmgType1'] ?? 0,
      dmgMin1: (json['dmg_min1'] ?? json['dmgMin1'] ?? 0.0),
      dmgMax1: (json['dmg_max1'] ?? json['dmgMax1'] ?? 0.0),
      dmgType2: json['dmg_type2'] ?? json['dmgType2'] ?? 0,
      dmgMin2: (json['dmg_min2'] ?? json['dmgMin2'] ?? 0.0),
      dmgMax2: (json['dmg_max2'] ?? json['dmgMax2'] ?? 0.0),
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
      statsCount: json['StatsCount'] ?? json['statsCount'] ?? 0,
      statTypes: [for (var i = 1; i <= 10; i++) json['stat_type$i'] ?? 0],
      statValues: [for (var i = 1; i <= 10; i++) json['stat_value$i'] ?? 0],
      // --- 抗性 ---
      holyRes: json['holy_res'] ?? json['holyRes'] ?? 0,
      fireRes: json['fire_res'] ?? json['fireRes'] ?? 0,
      natureRes: json['nature_res'] ?? json['natureRes'] ?? 0,
      shadowRes: json['shadow_res'] ?? json['shadowRes'] ?? 0,
      frostRes: json['frost_res'] ?? json['frostRes'] ?? 0,
      arcaneRes: json['arcane_res'] ?? json['arcaneRes'] ?? 0,
      // --- 法术效果（5 组）---
      spellIds: [for (var i = 1; i <= 5; i++) json['spellid_$i'] ?? 0],
      spellTriggers: [
        for (var i = 1; i <= 5; i++) json['spelltrigger_$i'] ?? 0,
      ],
      spellCharges: [for (var i = 1; i <= 5; i++) json['spellcharges_$i'] ?? 0],
      spellPpmRates: [
        for (var i = 1; i <= 5; i++) (json['spellppmRate_$i'] ?? 0.0) as double,
      ],
      spellCooldowns: [
        for (var i = 1; i <= 5; i++) json['spellcooldown_$i'] ?? 0,
      ],
      spellCategories: [
        for (var i = 1; i <= 5; i++) json['spellcategory_$i'] ?? 0,
      ],
      spellCategoryCooldowns: [
        for (var i = 1; i <= 5; i++) json['spellcategorycooldown_$i'] ?? 0,
      ],
      // --- 使用限制 ---
      allowableClass:
          json['Allowableclass'] ??
          json['AllowableClass'] ??
          json['allowableClass'] ??
          -1,
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
          0,
      // --- 区域与节日 ---
      mapId: json['Map'] ?? json['mapId'] ?? 0,
      area: json['area'] ?? 0,
      holidayId: json['HolidayId'] ?? json['holidayId'] ?? 0,
      // --- 锁与宝石 ---
      lockid: json['lockid'] ?? 0,
      gemProperties: json['GemProperties'] ?? json['gemProperties'] ?? 0,
      socketBonus: json['socketBonus'] ?? 0,
      socketColors: [for (var i = 1; i <= 3; i++) json['socketColor_$i'] ?? 0],
      socketContents: [
        for (var i = 1; i <= 3; i++) json['socketContent_$i'] ?? 0,
      ],
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
      'StatsCount': statsCount,
    };
    for (var i = 0; i < 10; i++) {
      result['stat_type${i + 1}'] = statTypes[i];
      result['stat_value${i + 1}'] = statValues[i];
    }

    // --- 抗性 ---
    result['holy_res'] = holyRes;
    result['fire_res'] = fireRes;
    result['nature_res'] = natureRes;
    result['shadow_res'] = shadowRes;
    result['frost_res'] = frostRes;
    result['arcane_res'] = arcaneRes;

    // --- 法术效果（5 组）---
    for (var i = 0; i < 5; i++) {
      result['spellid_${i + 1}'] = spellIds[i];
      result['spelltrigger_${i + 1}'] = spellTriggers[i];
      result['spellcharges_${i + 1}'] = spellCharges[i];
      result['spellppmRate_${i + 1}'] = spellPpmRates[i];
      result['spellcooldown_${i + 1}'] = spellCooldowns[i];
      result['spellcategory_${i + 1}'] = spellCategories[i];
      result['spellcategorycooldown_${i + 1}'] = spellCategoryCooldowns[i];
    }

    // --- 使用限制 ---
    result['Allowableclass'] = allowableClass;
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
    for (var i = 0; i < 3; i++) {
      result['socketColor_${i + 1}'] = socketColors[i];
      result['socketContent_${i + 1}'] = socketContents[i];
    }

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

  /// 显示名称（优先显示本地化名称）
  String get displayName => localeName.isNotEmpty ? localeName : name;

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
