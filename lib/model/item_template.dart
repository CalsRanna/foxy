/// 物品模板（完整字段，对应 AzerothCore item_template 表）
class ItemTemplate {
  // --- 基础标识 ---
  int entry = 0;
  String name = '';
  String description = '';

  // --- 本地化（joined，不在 toJson 中）---
  String localeName = '';
  String localeDescription = '';

  // --- 物品属性 ---
  int quality = 0;
  int className = 0; // DB 列名为 `class`
  int subclass = 0;
  int soundOverrideSubclass = 0;
  int material = 0; // DB 列名为 `Material`
  int displayId = 0; // DB 列名为 `displayid`
  int inventoryType = 0;
  int sheath = 0;

  // --- 经济与绑定 ---
  int bonding = 0;
  int itemset = 0;
  int randomProperty = 0; // DB 列名为 `RandomProperty`
  int randomSuffix = 0; // DB 列名为 `RandomSuffix`
  int maxDurability = 0; // DB 列名为 `MaxDurability`
  int buyPrice = 0; // DB 列名为 `BuyPrice`
  int sellPrice = 0; // DB 列名为 `SellPrice`
  int buyCount = 0; // DB 列名为 `BuyCount`
  int maxcount = 0;
  int stackable = 1;

  // --- 分类与容器 ---
  int totemCategory = 0; // DB 列名为 `TotemCategory`
  int foodType = 0; // DB 列名为 `FoodType`
  int bagFamily = 0; // DB 列名为 `BagFamily`
  int containerSlots = 0; // DB 列名为 `ContainerSlots`
  int itemLimitCategory = 0; // DB 列名为 `ItemLimitCategory`

  // --- 任务与限时 ---
  int startquest = 0;
  int duration = 0;
  int disenchantId = 0; // DB 列名为 `DisenchantID`
  int minMoneyLoot = 0;
  int maxMoneyLoot = 0;

  // --- 标志位 ---
  int flags = 0; // DB 列名为 `Flags`
  int flagsExtra = 0; // DB 列名为 `FlagsExtra`
  int flagsCustom = 0;

  // --- 武器与伤害 ---
  int delay = 0;
  int rangedModRange = 0; // DB 列名为 `RangedModRange`
  double armorDamageModifier = 0.0;
  int dmgType1 = 0; // DB 列名为 `dmg_type1`
  double dmgMin1 = 0; // DB 列名为 `dmg_min1`
  double dmgMax1 = 0; // DB 列名为 `dmg_max1`
  int dmgType2 = 0; // DB 列名为 `dmg_type2`
  double dmgMin2 = 0; // DB 列名为 `dmg_min2`
  double dmgMax2 = 0; // DB 列名为 `dmg_max2`
  int ammoType = 0; // DB 列名为 `ammo_type`
  int armor = 0;
  int block = 0;

  // --- 缩放属性 ---
  int scalingStatDistribution = 0; // DB 列名为 `ScalingStatDistribution`
  int scalingStatValue = 0; // DB 列名为 `ScalingStatValue`

  // --- 统计属性（10 组）---
  int statsCount = 0; // DB 列名为 `StatsCount`
  List<int> statTypes = List.filled(10, 0); // stat_type1..10
  List<int> statValues = List.filled(10, 0); // stat_value1..10

  // --- 抗性 ---
  int holyRes = 0; // DB 列名为 `holy_res`
  int fireRes = 0; // DB 列名为 `fire_res`
  int natureRes = 0; // DB 列名为 `nature_res`
  int shadowRes = 0; // DB 列名为 `shadow_res`
  int frostRes = 0; // DB 列名为 `frost_res`
  int arcaneRes = 0; // DB 列名为 `arcane_res`

  // --- 法术效果（5 组）---
  List<int> spellIds = List.filled(5, 0); // spellid_1..5
  List<int> spellTriggers = List.filled(5, 0); // spelltrigger_1..5
  List<int> spellCharges = List.filled(5, 0); // spellcharges_1..5
  List<double> spellPpmRates = List.filled(5, 0.0); // spellppmRate_1..5
  List<int> spellCooldowns = List.filled(5, 0); // spellcooldown_1..5
  List<int> spellCategories = List.filled(5, 0); // spellcategory_1..5
  List<int> spellCategoryCooldowns = List.filled(
    5,
    0,
  ); // spellcategorycooldown_1..5

  // --- 使用限制 ---
  int allowableClass = -1; // DB 列名为 `Allowableclass`，-1 表示所有职业
  int allowableRace = -1; // DB 列名为 `AllowableRace`，-1 表示所有种族
  int itemLevel = 0; // DB 列名为 `ItemLevel`
  int requiredLevel = 0; // DB 列名为 `RequiredLevel`
  int requiredSkill = 0; // DB 列名为 `RequiredSkill`
  int requiredSkillRank = 0; // DB 列名为 `RequiredSkillRank`
  int requiredSpell = 0; // DB 列名为 `requiredspell`
  int requiredHonorRank = 0; // DB 列名为 `requiredhonorrank`
  int requiredCityRank = 0; // DB 列名为 `RequiredCityRank`
  int requiredReputationFaction = 0; // DB 列名为 `RequiredReputationFaction`
  int requiredReputationRank = 0; // DB 列名为 `RequiredReputationRank`
  int requiredDisenchantSkill = 0; // DB 列名为 `RequiredDisenchantSkill`

  // --- 区域与节日 ---
  int mapId = 0; // DB 列名为 `Map`
  int area = 0;
  int holidayId = 0; // DB 列名为 `HolidayId`

  // --- 锁与宝石 ---
  int lockid = 0;
  int gemProperties = 0; // DB 列名为 `GemProperties`
  int socketBonus = 0; // DB 列名为 `socketBonus`
  List<int> socketColors = List.filled(3, 0); // socketColor_1..3
  List<int> socketContents = List.filled(3, 0); // socketContent_1..3

  // --- 图标（joined，不在 toJson 中）---
  String inventoryIcon = '';

  // --- 书页信息 ---
  int pageText = 0; // DB 列名为 `PageText`
  int pageMaterial = 0; // DB 列名为 `PageMaterial`
  int languageId = 0; // DB 列名为 `LanguageID`

  // --- 脚本与验证 ---
  String scriptName = ''; // DB 列名为 `ScriptName`
  int verifiedBuild = 0; // DB 列名为 `VerifiedBuild`

  /// 显示名称（优先显示本地化名称）
  String get displayName => localeName.isNotEmpty ? localeName : name;

  /// 显示描述（优先显示本地化描述）
  String get displayDescription =>
      localeDescription.isNotEmpty ? localeDescription : description;

  ItemTemplate();

  ItemTemplate.fromJson(Map<String, dynamic> json) {
    // --- 基础标识 ---
    entry = json['entry'] ?? 0;
    name = json['name'] ?? '';
    description = json['description'] ?? '';

    // --- 本地化（joined）---
    localeName = json['localeName'] ?? json['Name'] ?? '';
    localeDescription = json['localeDescription'] ?? json['Description'] ?? '';

    // --- 物品属性 ---
    quality = json['Quality'] ?? json['quality'] ?? 0;
    className = json['class'] ?? json['className'] ?? 0;
    subclass = json['subclass'] ?? 0;
    soundOverrideSubclass =
        json['SoundOverrideSubclass'] ?? json['soundOverrideSubclass'] ?? 0;
    material = json['Material'] ?? json['material'] ?? 0;
    displayId = json['displayid'] ?? json['displayId'] ?? 0;
    inventoryType = json['InventoryType'] ?? json['inventoryType'] ?? 0;
    sheath = json['sheath'] ?? 0;

    // --- 经济与绑定 ---
    bonding = json['bonding'] ?? 0;
    itemset = json['itemset'] ?? 0;
    randomProperty = json['RandomProperty'] ?? json['randomProperty'] ?? 0;
    randomSuffix = json['RandomSuffix'] ?? json['randomSuffix'] ?? 0;
    maxDurability = json['MaxDurability'] ?? json['maxDurability'] ?? 0;
    buyPrice = json['BuyPrice'] ?? json['buyPrice'] ?? 0;
    sellPrice = json['SellPrice'] ?? json['sellPrice'] ?? 0;
    buyCount = json['BuyCount'] ?? json['buyCount'] ?? 0;
    maxcount = json['maxcount'] ?? 0;
    stackable = json['stackable'] ?? 1;

    // --- 分类与容器 ---
    totemCategory = json['TotemCategory'] ?? json['totemCategory'] ?? 0;
    foodType = json['FoodType'] ?? json['foodType'] ?? 0;
    bagFamily = json['BagFamily'] ?? json['bagFamily'] ?? 0;
    containerSlots = json['ContainerSlots'] ?? json['containerSlots'] ?? 0;
    itemLimitCategory =
        json['ItemLimitCategory'] ?? json['itemLimitCategory'] ?? 0;

    // --- 任务与限时 ---
    startquest = json['startquest'] ?? 0;
    duration = json['duration'] ?? 0;
    disenchantId = json['DisenchantID'] ?? json['disenchantId'] ?? 0;
    minMoneyLoot = json['minMoneyLoot'] ?? 0;
    maxMoneyLoot = json['maxMoneyLoot'] ?? 0;

    // --- 标志位 ---
    flags = json['Flags'] ?? json['flags'] ?? 0;
    flagsExtra = json['FlagsExtra'] ?? json['flagsExtra'] ?? 0;
    flagsCustom = json['flagsCustom'] ?? 0;

    // --- 武器与伤害 ---
    delay = json['delay'] ?? 0;
    rangedModRange = json['RangedModRange'] ?? json['rangedModRange'] ?? 0;
    armorDamageModifier =
        (json['ArmorDamageModifier'] ?? json['armorDamageModifier'] ?? 0.0)
            as double;
    dmgType1 = json['dmg_type1'] ?? json['dmgType1'] ?? 0;
    dmgMin1 = (json['dmg_min1'] ?? json['dmgMin1'] ?? 0).toDouble();
    dmgMax1 = (json['dmg_max1'] ?? json['dmgMax1'] ?? 0).toDouble();
    dmgType2 = json['dmg_type2'] ?? json['dmgType2'] ?? 0;
    dmgMin2 = (json['dmg_min2'] ?? json['dmgMin2'] ?? 0).toDouble();
    dmgMax2 = (json['dmg_max2'] ?? json['dmgMax2'] ?? 0).toDouble();
    ammoType = json['ammo_type'] ?? json['ammoType'] ?? 0;
    armor = json['armor'] ?? 0;
    block = json['block'] ?? 0;

    // --- 缩放属性 ---
    scalingStatDistribution =
        json['ScalingStatDistribution'] ?? json['scalingStatDistribution'] ?? 0;
    scalingStatValue =
        json['ScalingStatValue'] ?? json['scalingStatValue'] ?? 0;

    // --- 统计属性 ---
    statsCount = json['StatsCount'] ?? json['statsCount'] ?? 0;
    for (var i = 0; i < 10; i++) {
      statTypes[i] = json['stat_type${i + 1}'] ?? 0;
      statValues[i] = json['stat_value${i + 1}'] ?? 0;
    }

    // --- 抗性 ---
    holyRes = json['holy_res'] ?? json['holyRes'] ?? 0;
    fireRes = json['fire_res'] ?? json['fireRes'] ?? 0;
    natureRes = json['nature_res'] ?? json['natureRes'] ?? 0;
    shadowRes = json['shadow_res'] ?? json['shadowRes'] ?? 0;
    frostRes = json['frost_res'] ?? json['frostRes'] ?? 0;
    arcaneRes = json['arcane_res'] ?? json['arcaneRes'] ?? 0;

    // --- 法术效果（5 组）---
    for (var i = 0; i < 5; i++) {
      spellIds[i] = json['spellid_${i + 1}'] ?? 0;
      spellTriggers[i] = json['spelltrigger_${i + 1}'] ?? 0;
      spellCharges[i] = json['spellcharges_${i + 1}'] ?? 0;
      spellPpmRates[i] = (json['spellppmRate_${i + 1}'] ?? 0.0) as double;
      spellCooldowns[i] = json['spellcooldown_${i + 1}'] ?? 0;
      spellCategories[i] = json['spellcategory_${i + 1}'] ?? 0;
      spellCategoryCooldowns[i] = json['spellcategorycooldown_${i + 1}'] ?? 0;
    }

    // --- 使用限制 ---
    allowableClass =
        json['Allowableclass'] ??
        json['AllowableClass'] ??
        json['allowableClass'] ??
        -1;
    allowableRace = json['AllowableRace'] ?? json['allowableRace'] ?? -1;
    itemLevel = json['ItemLevel'] ?? json['itemLevel'] ?? 0;
    requiredLevel = json['RequiredLevel'] ?? json['requiredLevel'] ?? 0;
    requiredSkill = json['RequiredSkill'] ?? json['requiredSkill'] ?? 0;
    requiredSkillRank =
        json['RequiredSkillRank'] ?? json['requiredSkillRank'] ?? 0;
    requiredSpell = json['requiredspell'] ?? json['requiredSpell'] ?? 0;
    requiredHonorRank =
        json['requiredhonorrank'] ?? json['requiredHonorRank'] ?? 0;
    requiredCityRank =
        json['RequiredCityRank'] ?? json['requiredCityRank'] ?? 0;
    requiredReputationFaction =
        json['RequiredReputationFaction'] ??
        json['requiredReputationFaction'] ??
        0;
    requiredReputationRank =
        json['RequiredReputationRank'] ?? json['requiredReputationRank'] ?? 0;
    requiredDisenchantSkill =
        json['RequiredDisenchantSkill'] ?? json['requiredDisenchantSkill'] ?? 0;

    // --- 区域与节日 ---
    mapId = json['Map'] ?? json['mapId'] ?? 0;
    area = json['area'] ?? 0;
    holidayId = json['HolidayId'] ?? json['holidayId'] ?? 0;

    // --- 锁与宝石 ---
    lockid = json['lockid'] ?? 0;
    gemProperties = json['GemProperties'] ?? json['gemProperties'] ?? 0;
    socketBonus = json['socketBonus'] ?? 0;
    for (var i = 0; i < 3; i++) {
      socketColors[i] = json['socketColor_${i + 1}'] ?? 0;
      socketContents[i] = json['socketContent_${i + 1}'] ?? 0;
    }

    // --- 图标（joined）---
    inventoryIcon = json['InventoryIcon_1'] ?? json['inventoryIcon'] ?? '';

    // --- 书页信息 ---
    pageText = json['PageText'] ?? json['pageText'] ?? 0;
    pageMaterial = json['PageMaterial'] ?? json['pageMaterial'] ?? 0;
    languageId = json['LanguageID'] ?? json['languageId'] ?? 0;

    // --- 脚本与验证 ---
    scriptName = json['ScriptName'] ?? json['scriptName'] ?? '';
    verifiedBuild = json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0;
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
    // 注意：localeName、localeDescription、inventoryIcon 是 joined 字段，不在 toJson 中
  }
}

/// 物品模板简要信息（用于列表显示）
class BriefItemTemplate {
  int entry = 0;
  String name = '';
  String localeName = '';
  int quality = 0;
  int classId = 0;
  int subclass = 0;
  int inventoryType = 0;
  int itemLevel = 0;
  int requiredLevel = 0;

  BriefItemTemplate();

  /// 显示名称（优先显示本地化名称）
  String get displayName => localeName.isNotEmpty ? localeName : name;

  BriefItemTemplate.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? 0;
    name = json['name'] ?? '';
    localeName = json['localeName'] ?? json['Name'] ?? '';
    quality = json['Quality'] ?? json['quality'] ?? 0;
    classId = json['class'] ?? json['classId'] ?? 0;
    subclass = json['subclass'] ?? 0;
    inventoryType = json['InventoryType'] ?? json['inventoryType'] ?? 0;
    itemLevel = json['ItemLevel'] ?? json['itemLevel'] ?? 0;
    requiredLevel = json['RequiredLevel'] ?? json['requiredLevel'] ?? 0;
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
