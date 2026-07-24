// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_template_entity.dart';

mixin _ItemTemplateEntityMixin {
  static ItemTemplateEntity fromJson(Map<String, dynamic> json) {
    return ItemTemplateEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      quality: (json['Quality'] as num?)?.toInt() ?? 0,
      className: (json['class'] as num?)?.toInt() ?? 0,
      subclass: (json['subclass'] as num?)?.toInt() ?? 0,
      soundOverrideSubclass:
          (json['SoundOverrideSubclass'] as num?)?.toInt() ?? -1,
      material: (json['Material'] as num?)?.toInt() ?? 0,
      displayId: (json['displayid'] as num?)?.toInt() ?? 0,
      inventoryType: (json['InventoryType'] as num?)?.toInt() ?? 0,
      sheath: (json['sheath'] as num?)?.toInt() ?? 0,
      bonding: (json['bonding'] as num?)?.toInt() ?? 0,
      itemset: (json['itemset'] as num?)?.toInt() ?? 0,
      randomProperty: (json['RandomProperty'] as num?)?.toInt() ?? 0,
      randomSuffix: (json['RandomSuffix'] as num?)?.toInt() ?? 0,
      maxDurability: (json['MaxDurability'] as num?)?.toInt() ?? 0,
      buyPrice: (json['BuyPrice'] as num?)?.toInt() ?? 0,
      sellPrice: (json['SellPrice'] as num?)?.toInt() ?? 0,
      buyCount: (json['BuyCount'] as num?)?.toInt() ?? 1,
      maxcount: (json['maxcount'] as num?)?.toInt() ?? 0,
      stackable: (json['stackable'] as num?)?.toInt() ?? 1,
      totemCategory: (json['TotemCategory'] as num?)?.toInt() ?? 0,
      foodType: (json['FoodType'] as num?)?.toInt() ?? 0,
      bagFamily: (json['BagFamily'] as num?)?.toInt() ?? 0,
      containerSlots: (json['ContainerSlots'] as num?)?.toInt() ?? 0,
      itemLimitCategory: (json['ItemLimitCategory'] as num?)?.toInt() ?? 0,
      startquest: (json['startquest'] as num?)?.toInt() ?? 0,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      disenchantId: (json['DisenchantID'] as num?)?.toInt() ?? 0,
      minMoneyLoot: (json['minMoneyLoot'] as num?)?.toInt() ?? 0,
      maxMoneyLoot: (json['maxMoneyLoot'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      flagsExtra: (json['FlagsExtra'] as num?)?.toInt() ?? 0,
      flagsCustom: (json['flagsCustom'] as num?)?.toInt() ?? 0,
      delay: (json['delay'] as num?)?.toInt() ?? 1000,
      rangedModRange: (json['RangedModRange'] as num?)?.toDouble() ?? 0.0,
      armorDamageModifier:
          (json['ArmorDamageModifier'] as num?)?.toDouble() ?? 0.0,
      dmgType1: (json['dmg_type1'] as num?)?.toInt() ?? 0,
      dmgMin1: (json['dmg_min1'] as num?)?.toDouble() ?? 0.0,
      dmgMax1: (json['dmg_max1'] as num?)?.toDouble() ?? 0.0,
      dmgType2: (json['dmg_type2'] as num?)?.toInt() ?? 0,
      dmgMin2: (json['dmg_min2'] as num?)?.toDouble() ?? 0.0,
      dmgMax2: (json['dmg_max2'] as num?)?.toDouble() ?? 0.0,
      ammoType: (json['ammo_type'] as num?)?.toInt() ?? 0,
      armor: (json['armor'] as num?)?.toInt() ?? 0,
      block: (json['block'] as num?)?.toInt() ?? 0,
      scalingStatDistribution:
          (json['ScalingStatDistribution'] as num?)?.toInt() ?? 0,
      scalingStatValue: (json['ScalingStatValue'] as num?)?.toInt() ?? 0,
      statType1: (json['stat_type1'] as num?)?.toInt() ?? 0,
      statValue1: (json['stat_value1'] as num?)?.toInt() ?? 0,
      statType2: (json['stat_type2'] as num?)?.toInt() ?? 0,
      statValue2: (json['stat_value2'] as num?)?.toInt() ?? 0,
      statType3: (json['stat_type3'] as num?)?.toInt() ?? 0,
      statValue3: (json['stat_value3'] as num?)?.toInt() ?? 0,
      statType4: (json['stat_type4'] as num?)?.toInt() ?? 0,
      statValue4: (json['stat_value4'] as num?)?.toInt() ?? 0,
      statType5: (json['stat_type5'] as num?)?.toInt() ?? 0,
      statValue5: (json['stat_value5'] as num?)?.toInt() ?? 0,
      statType6: (json['stat_type6'] as num?)?.toInt() ?? 0,
      statValue6: (json['stat_value6'] as num?)?.toInt() ?? 0,
      statType7: (json['stat_type7'] as num?)?.toInt() ?? 0,
      statValue7: (json['stat_value7'] as num?)?.toInt() ?? 0,
      statType8: (json['stat_type8'] as num?)?.toInt() ?? 0,
      statValue8: (json['stat_value8'] as num?)?.toInt() ?? 0,
      statType9: (json['stat_type9'] as num?)?.toInt() ?? 0,
      statValue9: (json['stat_value9'] as num?)?.toInt() ?? 0,
      statType10: (json['stat_type10'] as num?)?.toInt() ?? 0,
      statValue10: (json['stat_value10'] as num?)?.toInt() ?? 0,
      holyRes: (json['holy_res'] as num?)?.toInt() ?? 0,
      fireRes: (json['fire_res'] as num?)?.toInt() ?? 0,
      natureRes: (json['nature_res'] as num?)?.toInt() ?? 0,
      shadowRes: (json['shadow_res'] as num?)?.toInt() ?? 0,
      frostRes: (json['frost_res'] as num?)?.toInt() ?? 0,
      arcaneRes: (json['arcane_res'] as num?)?.toInt() ?? 0,
      spellId1: (json['spellid_1'] as num?)?.toInt() ?? 0,
      spellTrigger1: (json['spelltrigger_1'] as num?)?.toInt() ?? 0,
      spellCharges1: (json['spellcharges_1'] as num?)?.toInt() ?? 0,
      spellPpmRate1: (json['spellppmRate_1'] as num?)?.toDouble() ?? 0.0,
      spellCooldown1: (json['spellcooldown_1'] as num?)?.toInt() ?? -1,
      spellCategory1: (json['spellcategory_1'] as num?)?.toInt() ?? 0,
      spellCategoryCooldown1:
          (json['spellcategorycooldown_1'] as num?)?.toInt() ?? -1,
      spellId2: (json['spellid_2'] as num?)?.toInt() ?? 0,
      spellTrigger2: (json['spelltrigger_2'] as num?)?.toInt() ?? 0,
      spellCharges2: (json['spellcharges_2'] as num?)?.toInt() ?? 0,
      spellPpmRate2: (json['spellppmRate_2'] as num?)?.toDouble() ?? 0.0,
      spellCooldown2: (json['spellcooldown_2'] as num?)?.toInt() ?? -1,
      spellCategory2: (json['spellcategory_2'] as num?)?.toInt() ?? 0,
      spellCategoryCooldown2:
          (json['spellcategorycooldown_2'] as num?)?.toInt() ?? -1,
      spellId3: (json['spellid_3'] as num?)?.toInt() ?? 0,
      spellTrigger3: (json['spelltrigger_3'] as num?)?.toInt() ?? 0,
      spellCharges3: (json['spellcharges_3'] as num?)?.toInt() ?? 0,
      spellPpmRate3: (json['spellppmRate_3'] as num?)?.toDouble() ?? 0.0,
      spellCooldown3: (json['spellcooldown_3'] as num?)?.toInt() ?? -1,
      spellCategory3: (json['spellcategory_3'] as num?)?.toInt() ?? 0,
      spellCategoryCooldown3:
          (json['spellcategorycooldown_3'] as num?)?.toInt() ?? -1,
      spellId4: (json['spellid_4'] as num?)?.toInt() ?? 0,
      spellTrigger4: (json['spelltrigger_4'] as num?)?.toInt() ?? 0,
      spellCharges4: (json['spellcharges_4'] as num?)?.toInt() ?? 0,
      spellPpmRate4: (json['spellppmRate_4'] as num?)?.toDouble() ?? 0.0,
      spellCooldown4: (json['spellcooldown_4'] as num?)?.toInt() ?? -1,
      spellCategory4: (json['spellcategory_4'] as num?)?.toInt() ?? 0,
      spellCategoryCooldown4:
          (json['spellcategorycooldown_4'] as num?)?.toInt() ?? -1,
      spellId5: (json['spellid_5'] as num?)?.toInt() ?? 0,
      spellTrigger5: (json['spelltrigger_5'] as num?)?.toInt() ?? 0,
      spellCharges5: (json['spellcharges_5'] as num?)?.toInt() ?? 0,
      spellPpmRate5: (json['spellppmRate_5'] as num?)?.toDouble() ?? 0.0,
      spellCooldown5: (json['spellcooldown_5'] as num?)?.toInt() ?? -1,
      spellCategory5: (json['spellcategory_5'] as num?)?.toInt() ?? 0,
      spellCategoryCooldown5:
          (json['spellcategorycooldown_5'] as num?)?.toInt() ?? -1,
      allowableClass: (json['AllowableClass'] as num?)?.toInt() ?? -1,
      allowableRace: (json['AllowableRace'] as num?)?.toInt() ?? -1,
      itemLevel: (json['ItemLevel'] as num?)?.toInt() ?? 0,
      requiredLevel: (json['RequiredLevel'] as num?)?.toInt() ?? 0,
      requiredSkill: (json['RequiredSkill'] as num?)?.toInt() ?? 0,
      requiredSkillRank: (json['RequiredSkillRank'] as num?)?.toInt() ?? 0,
      requiredSpell: (json['requiredspell'] as num?)?.toInt() ?? 0,
      requiredHonorRank: (json['requiredhonorrank'] as num?)?.toInt() ?? 0,
      requiredCityRank: (json['RequiredCityRank'] as num?)?.toInt() ?? 0,
      requiredReputationFaction:
          (json['RequiredReputationFaction'] as num?)?.toInt() ?? 0,
      requiredReputationRank:
          (json['RequiredReputationRank'] as num?)?.toInt() ?? 0,
      requiredDisenchantSkill:
          (json['RequiredDisenchantSkill'] as num?)?.toInt() ?? -1,
      mapId: (json['Map'] as num?)?.toInt() ?? 0,
      area: (json['area'] as num?)?.toInt() ?? 0,
      holidayId: (json['HolidayId'] as num?)?.toInt() ?? 0,
      lockid: (json['lockid'] as num?)?.toInt() ?? 0,
      gemProperties: (json['GemProperties'] as num?)?.toInt() ?? 0,
      socketBonus: (json['socketBonus'] as num?)?.toInt() ?? 0,
      socketColor1: (json['socketColor_1'] as num?)?.toInt() ?? 0,
      socketContent1: (json['socketContent_1'] as num?)?.toInt() ?? 0,
      socketColor2: (json['socketColor_2'] as num?)?.toInt() ?? 0,
      socketContent2: (json['socketContent_2'] as num?)?.toInt() ?? 0,
      socketColor3: (json['socketColor_3'] as num?)?.toInt() ?? 0,
      socketContent3: (json['socketContent_3'] as num?)?.toInt() ?? 0,
      pageText: (json['PageText'] as num?)?.toInt() ?? 0,
      pageMaterial: (json['PageMaterial'] as num?)?.toInt() ?? 0,
      languageId: (json['LanguageID'] as num?)?.toInt() ?? 0,
      scriptName: json['ScriptName']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  ItemTemplateEntity copyWith({
    int? entry,
    String? name,
    String? description,
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
    int? pageText,
    int? pageMaterial,
    int? languageId,
    String? scriptName,
    int? verifiedBuild,
  }) {
    final self = this as ItemTemplateEntity;
    return ItemTemplateEntity(
      entry: entry ?? self.entry,
      name: name ?? self.name,
      description: description ?? self.description,
      quality: quality ?? self.quality,
      className: className ?? self.className,
      subclass: subclass ?? self.subclass,
      soundOverrideSubclass:
          soundOverrideSubclass ?? self.soundOverrideSubclass,
      material: material ?? self.material,
      displayId: displayId ?? self.displayId,
      inventoryType: inventoryType ?? self.inventoryType,
      sheath: sheath ?? self.sheath,
      bonding: bonding ?? self.bonding,
      itemset: itemset ?? self.itemset,
      randomProperty: randomProperty ?? self.randomProperty,
      randomSuffix: randomSuffix ?? self.randomSuffix,
      maxDurability: maxDurability ?? self.maxDurability,
      buyPrice: buyPrice ?? self.buyPrice,
      sellPrice: sellPrice ?? self.sellPrice,
      buyCount: buyCount ?? self.buyCount,
      maxcount: maxcount ?? self.maxcount,
      stackable: stackable ?? self.stackable,
      totemCategory: totemCategory ?? self.totemCategory,
      foodType: foodType ?? self.foodType,
      bagFamily: bagFamily ?? self.bagFamily,
      containerSlots: containerSlots ?? self.containerSlots,
      itemLimitCategory: itemLimitCategory ?? self.itemLimitCategory,
      startquest: startquest ?? self.startquest,
      duration: duration ?? self.duration,
      disenchantId: disenchantId ?? self.disenchantId,
      minMoneyLoot: minMoneyLoot ?? self.minMoneyLoot,
      maxMoneyLoot: maxMoneyLoot ?? self.maxMoneyLoot,
      flags: flags ?? self.flags,
      flagsExtra: flagsExtra ?? self.flagsExtra,
      flagsCustom: flagsCustom ?? self.flagsCustom,
      delay: delay ?? self.delay,
      rangedModRange: rangedModRange ?? self.rangedModRange,
      armorDamageModifier: armorDamageModifier ?? self.armorDamageModifier,
      dmgType1: dmgType1 ?? self.dmgType1,
      dmgMin1: dmgMin1 ?? self.dmgMin1,
      dmgMax1: dmgMax1 ?? self.dmgMax1,
      dmgType2: dmgType2 ?? self.dmgType2,
      dmgMin2: dmgMin2 ?? self.dmgMin2,
      dmgMax2: dmgMax2 ?? self.dmgMax2,
      ammoType: ammoType ?? self.ammoType,
      armor: armor ?? self.armor,
      block: block ?? self.block,
      scalingStatDistribution:
          scalingStatDistribution ?? self.scalingStatDistribution,
      scalingStatValue: scalingStatValue ?? self.scalingStatValue,
      statType1: statType1 ?? self.statType1,
      statValue1: statValue1 ?? self.statValue1,
      statType2: statType2 ?? self.statType2,
      statValue2: statValue2 ?? self.statValue2,
      statType3: statType3 ?? self.statType3,
      statValue3: statValue3 ?? self.statValue3,
      statType4: statType4 ?? self.statType4,
      statValue4: statValue4 ?? self.statValue4,
      statType5: statType5 ?? self.statType5,
      statValue5: statValue5 ?? self.statValue5,
      statType6: statType6 ?? self.statType6,
      statValue6: statValue6 ?? self.statValue6,
      statType7: statType7 ?? self.statType7,
      statValue7: statValue7 ?? self.statValue7,
      statType8: statType8 ?? self.statType8,
      statValue8: statValue8 ?? self.statValue8,
      statType9: statType9 ?? self.statType9,
      statValue9: statValue9 ?? self.statValue9,
      statType10: statType10 ?? self.statType10,
      statValue10: statValue10 ?? self.statValue10,
      holyRes: holyRes ?? self.holyRes,
      fireRes: fireRes ?? self.fireRes,
      natureRes: natureRes ?? self.natureRes,
      shadowRes: shadowRes ?? self.shadowRes,
      frostRes: frostRes ?? self.frostRes,
      arcaneRes: arcaneRes ?? self.arcaneRes,
      spellId1: spellId1 ?? self.spellId1,
      spellTrigger1: spellTrigger1 ?? self.spellTrigger1,
      spellCharges1: spellCharges1 ?? self.spellCharges1,
      spellPpmRate1: spellPpmRate1 ?? self.spellPpmRate1,
      spellCooldown1: spellCooldown1 ?? self.spellCooldown1,
      spellCategory1: spellCategory1 ?? self.spellCategory1,
      spellCategoryCooldown1:
          spellCategoryCooldown1 ?? self.spellCategoryCooldown1,
      spellId2: spellId2 ?? self.spellId2,
      spellTrigger2: spellTrigger2 ?? self.spellTrigger2,
      spellCharges2: spellCharges2 ?? self.spellCharges2,
      spellPpmRate2: spellPpmRate2 ?? self.spellPpmRate2,
      spellCooldown2: spellCooldown2 ?? self.spellCooldown2,
      spellCategory2: spellCategory2 ?? self.spellCategory2,
      spellCategoryCooldown2:
          spellCategoryCooldown2 ?? self.spellCategoryCooldown2,
      spellId3: spellId3 ?? self.spellId3,
      spellTrigger3: spellTrigger3 ?? self.spellTrigger3,
      spellCharges3: spellCharges3 ?? self.spellCharges3,
      spellPpmRate3: spellPpmRate3 ?? self.spellPpmRate3,
      spellCooldown3: spellCooldown3 ?? self.spellCooldown3,
      spellCategory3: spellCategory3 ?? self.spellCategory3,
      spellCategoryCooldown3:
          spellCategoryCooldown3 ?? self.spellCategoryCooldown3,
      spellId4: spellId4 ?? self.spellId4,
      spellTrigger4: spellTrigger4 ?? self.spellTrigger4,
      spellCharges4: spellCharges4 ?? self.spellCharges4,
      spellPpmRate4: spellPpmRate4 ?? self.spellPpmRate4,
      spellCooldown4: spellCooldown4 ?? self.spellCooldown4,
      spellCategory4: spellCategory4 ?? self.spellCategory4,
      spellCategoryCooldown4:
          spellCategoryCooldown4 ?? self.spellCategoryCooldown4,
      spellId5: spellId5 ?? self.spellId5,
      spellTrigger5: spellTrigger5 ?? self.spellTrigger5,
      spellCharges5: spellCharges5 ?? self.spellCharges5,
      spellPpmRate5: spellPpmRate5 ?? self.spellPpmRate5,
      spellCooldown5: spellCooldown5 ?? self.spellCooldown5,
      spellCategory5: spellCategory5 ?? self.spellCategory5,
      spellCategoryCooldown5:
          spellCategoryCooldown5 ?? self.spellCategoryCooldown5,
      allowableClass: allowableClass ?? self.allowableClass,
      allowableRace: allowableRace ?? self.allowableRace,
      itemLevel: itemLevel ?? self.itemLevel,
      requiredLevel: requiredLevel ?? self.requiredLevel,
      requiredSkill: requiredSkill ?? self.requiredSkill,
      requiredSkillRank: requiredSkillRank ?? self.requiredSkillRank,
      requiredSpell: requiredSpell ?? self.requiredSpell,
      requiredHonorRank: requiredHonorRank ?? self.requiredHonorRank,
      requiredCityRank: requiredCityRank ?? self.requiredCityRank,
      requiredReputationFaction:
          requiredReputationFaction ?? self.requiredReputationFaction,
      requiredReputationRank:
          requiredReputationRank ?? self.requiredReputationRank,
      requiredDisenchantSkill:
          requiredDisenchantSkill ?? self.requiredDisenchantSkill,
      mapId: mapId ?? self.mapId,
      area: area ?? self.area,
      holidayId: holidayId ?? self.holidayId,
      lockid: lockid ?? self.lockid,
      gemProperties: gemProperties ?? self.gemProperties,
      socketBonus: socketBonus ?? self.socketBonus,
      socketColor1: socketColor1 ?? self.socketColor1,
      socketContent1: socketContent1 ?? self.socketContent1,
      socketColor2: socketColor2 ?? self.socketColor2,
      socketContent2: socketContent2 ?? self.socketContent2,
      socketColor3: socketColor3 ?? self.socketColor3,
      socketContent3: socketContent3 ?? self.socketContent3,
      pageText: pageText ?? self.pageText,
      pageMaterial: pageMaterial ?? self.pageMaterial,
      languageId: languageId ?? self.languageId,
      scriptName: scriptName ?? self.scriptName,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ItemTemplateEntity;
    return {
      'entry': self.entry,
      'name': self.name,
      'description': self.description,
      'Quality': self.quality,
      'class': self.className,
      'subclass': self.subclass,
      'SoundOverrideSubclass': self.soundOverrideSubclass,
      'Material': self.material,
      'displayid': self.displayId,
      'InventoryType': self.inventoryType,
      'sheath': self.sheath,
      'bonding': self.bonding,
      'itemset': self.itemset,
      'RandomProperty': self.randomProperty,
      'RandomSuffix': self.randomSuffix,
      'MaxDurability': self.maxDurability,
      'BuyPrice': self.buyPrice,
      'SellPrice': self.sellPrice,
      'BuyCount': self.buyCount,
      'maxcount': self.maxcount,
      'stackable': self.stackable,
      'TotemCategory': self.totemCategory,
      'FoodType': self.foodType,
      'BagFamily': self.bagFamily,
      'ContainerSlots': self.containerSlots,
      'ItemLimitCategory': self.itemLimitCategory,
      'startquest': self.startquest,
      'duration': self.duration,
      'DisenchantID': self.disenchantId,
      'minMoneyLoot': self.minMoneyLoot,
      'maxMoneyLoot': self.maxMoneyLoot,
      'Flags': self.flags,
      'FlagsExtra': self.flagsExtra,
      'flagsCustom': self.flagsCustom,
      'delay': self.delay,
      'RangedModRange': self.rangedModRange,
      'ArmorDamageModifier': self.armorDamageModifier,
      'dmg_type1': self.dmgType1,
      'dmg_min1': self.dmgMin1,
      'dmg_max1': self.dmgMax1,
      'dmg_type2': self.dmgType2,
      'dmg_min2': self.dmgMin2,
      'dmg_max2': self.dmgMax2,
      'ammo_type': self.ammoType,
      'armor': self.armor,
      'block': self.block,
      'ScalingStatDistribution': self.scalingStatDistribution,
      'ScalingStatValue': self.scalingStatValue,
      'stat_type1': self.statType1,
      'stat_value1': self.statValue1,
      'stat_type2': self.statType2,
      'stat_value2': self.statValue2,
      'stat_type3': self.statType3,
      'stat_value3': self.statValue3,
      'stat_type4': self.statType4,
      'stat_value4': self.statValue4,
      'stat_type5': self.statType5,
      'stat_value5': self.statValue5,
      'stat_type6': self.statType6,
      'stat_value6': self.statValue6,
      'stat_type7': self.statType7,
      'stat_value7': self.statValue7,
      'stat_type8': self.statType8,
      'stat_value8': self.statValue8,
      'stat_type9': self.statType9,
      'stat_value9': self.statValue9,
      'stat_type10': self.statType10,
      'stat_value10': self.statValue10,
      'holy_res': self.holyRes,
      'fire_res': self.fireRes,
      'nature_res': self.natureRes,
      'shadow_res': self.shadowRes,
      'frost_res': self.frostRes,
      'arcane_res': self.arcaneRes,
      'spellid_1': self.spellId1,
      'spelltrigger_1': self.spellTrigger1,
      'spellcharges_1': self.spellCharges1,
      'spellppmRate_1': self.spellPpmRate1,
      'spellcooldown_1': self.spellCooldown1,
      'spellcategory_1': self.spellCategory1,
      'spellcategorycooldown_1': self.spellCategoryCooldown1,
      'spellid_2': self.spellId2,
      'spelltrigger_2': self.spellTrigger2,
      'spellcharges_2': self.spellCharges2,
      'spellppmRate_2': self.spellPpmRate2,
      'spellcooldown_2': self.spellCooldown2,
      'spellcategory_2': self.spellCategory2,
      'spellcategorycooldown_2': self.spellCategoryCooldown2,
      'spellid_3': self.spellId3,
      'spelltrigger_3': self.spellTrigger3,
      'spellcharges_3': self.spellCharges3,
      'spellppmRate_3': self.spellPpmRate3,
      'spellcooldown_3': self.spellCooldown3,
      'spellcategory_3': self.spellCategory3,
      'spellcategorycooldown_3': self.spellCategoryCooldown3,
      'spellid_4': self.spellId4,
      'spelltrigger_4': self.spellTrigger4,
      'spellcharges_4': self.spellCharges4,
      'spellppmRate_4': self.spellPpmRate4,
      'spellcooldown_4': self.spellCooldown4,
      'spellcategory_4': self.spellCategory4,
      'spellcategorycooldown_4': self.spellCategoryCooldown4,
      'spellid_5': self.spellId5,
      'spelltrigger_5': self.spellTrigger5,
      'spellcharges_5': self.spellCharges5,
      'spellppmRate_5': self.spellPpmRate5,
      'spellcooldown_5': self.spellCooldown5,
      'spellcategory_5': self.spellCategory5,
      'spellcategorycooldown_5': self.spellCategoryCooldown5,
      'AllowableClass': self.allowableClass,
      'AllowableRace': self.allowableRace,
      'ItemLevel': self.itemLevel,
      'RequiredLevel': self.requiredLevel,
      'RequiredSkill': self.requiredSkill,
      'RequiredSkillRank': self.requiredSkillRank,
      'requiredspell': self.requiredSpell,
      'requiredhonorrank': self.requiredHonorRank,
      'RequiredCityRank': self.requiredCityRank,
      'RequiredReputationFaction': self.requiredReputationFaction,
      'RequiredReputationRank': self.requiredReputationRank,
      'RequiredDisenchantSkill': self.requiredDisenchantSkill,
      'Map': self.mapId,
      'area': self.area,
      'HolidayId': self.holidayId,
      'lockid': self.lockid,
      'GemProperties': self.gemProperties,
      'socketBonus': self.socketBonus,
      'socketColor_1': self.socketColor1,
      'socketContent_1': self.socketContent1,
      'socketColor_2': self.socketColor2,
      'socketContent_2': self.socketContent2,
      'socketColor_3': self.socketColor3,
      'socketContent_3': self.socketContent3,
      'PageText': self.pageText,
      'PageMaterial': self.pageMaterial,
      'LanguageID': self.languageId,
      'ScriptName': self.scriptName,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as ItemTemplateEntity;
    return identical(self, other) ||
        other is ItemTemplateEntity &&
            self.runtimeType == other.runtimeType &&
            self.entry == other.entry &&
            self.name == other.name &&
            self.description == other.description &&
            self.quality == other.quality &&
            self.className == other.className &&
            self.subclass == other.subclass &&
            self.soundOverrideSubclass == other.soundOverrideSubclass &&
            self.material == other.material &&
            self.displayId == other.displayId &&
            self.inventoryType == other.inventoryType &&
            self.sheath == other.sheath &&
            self.bonding == other.bonding &&
            self.itemset == other.itemset &&
            self.randomProperty == other.randomProperty &&
            self.randomSuffix == other.randomSuffix &&
            self.maxDurability == other.maxDurability &&
            self.buyPrice == other.buyPrice &&
            self.sellPrice == other.sellPrice &&
            self.buyCount == other.buyCount &&
            self.maxcount == other.maxcount &&
            self.stackable == other.stackable &&
            self.totemCategory == other.totemCategory &&
            self.foodType == other.foodType &&
            self.bagFamily == other.bagFamily &&
            self.containerSlots == other.containerSlots &&
            self.itemLimitCategory == other.itemLimitCategory &&
            self.startquest == other.startquest &&
            self.duration == other.duration &&
            self.disenchantId == other.disenchantId &&
            self.minMoneyLoot == other.minMoneyLoot &&
            self.maxMoneyLoot == other.maxMoneyLoot &&
            self.flags == other.flags &&
            self.flagsExtra == other.flagsExtra &&
            self.flagsCustom == other.flagsCustom &&
            self.delay == other.delay &&
            self.rangedModRange == other.rangedModRange &&
            self.armorDamageModifier == other.armorDamageModifier &&
            self.dmgType1 == other.dmgType1 &&
            self.dmgMin1 == other.dmgMin1 &&
            self.dmgMax1 == other.dmgMax1 &&
            self.dmgType2 == other.dmgType2 &&
            self.dmgMin2 == other.dmgMin2 &&
            self.dmgMax2 == other.dmgMax2 &&
            self.ammoType == other.ammoType &&
            self.armor == other.armor &&
            self.block == other.block &&
            self.scalingStatDistribution == other.scalingStatDistribution &&
            self.scalingStatValue == other.scalingStatValue &&
            self.statType1 == other.statType1 &&
            self.statValue1 == other.statValue1 &&
            self.statType2 == other.statType2 &&
            self.statValue2 == other.statValue2 &&
            self.statType3 == other.statType3 &&
            self.statValue3 == other.statValue3 &&
            self.statType4 == other.statType4 &&
            self.statValue4 == other.statValue4 &&
            self.statType5 == other.statType5 &&
            self.statValue5 == other.statValue5 &&
            self.statType6 == other.statType6 &&
            self.statValue6 == other.statValue6 &&
            self.statType7 == other.statType7 &&
            self.statValue7 == other.statValue7 &&
            self.statType8 == other.statType8 &&
            self.statValue8 == other.statValue8 &&
            self.statType9 == other.statType9 &&
            self.statValue9 == other.statValue9 &&
            self.statType10 == other.statType10 &&
            self.statValue10 == other.statValue10 &&
            self.holyRes == other.holyRes &&
            self.fireRes == other.fireRes &&
            self.natureRes == other.natureRes &&
            self.shadowRes == other.shadowRes &&
            self.frostRes == other.frostRes &&
            self.arcaneRes == other.arcaneRes &&
            self.spellId1 == other.spellId1 &&
            self.spellTrigger1 == other.spellTrigger1 &&
            self.spellCharges1 == other.spellCharges1 &&
            self.spellPpmRate1 == other.spellPpmRate1 &&
            self.spellCooldown1 == other.spellCooldown1 &&
            self.spellCategory1 == other.spellCategory1 &&
            self.spellCategoryCooldown1 == other.spellCategoryCooldown1 &&
            self.spellId2 == other.spellId2 &&
            self.spellTrigger2 == other.spellTrigger2 &&
            self.spellCharges2 == other.spellCharges2 &&
            self.spellPpmRate2 == other.spellPpmRate2 &&
            self.spellCooldown2 == other.spellCooldown2 &&
            self.spellCategory2 == other.spellCategory2 &&
            self.spellCategoryCooldown2 == other.spellCategoryCooldown2 &&
            self.spellId3 == other.spellId3 &&
            self.spellTrigger3 == other.spellTrigger3 &&
            self.spellCharges3 == other.spellCharges3 &&
            self.spellPpmRate3 == other.spellPpmRate3 &&
            self.spellCooldown3 == other.spellCooldown3 &&
            self.spellCategory3 == other.spellCategory3 &&
            self.spellCategoryCooldown3 == other.spellCategoryCooldown3 &&
            self.spellId4 == other.spellId4 &&
            self.spellTrigger4 == other.spellTrigger4 &&
            self.spellCharges4 == other.spellCharges4 &&
            self.spellPpmRate4 == other.spellPpmRate4 &&
            self.spellCooldown4 == other.spellCooldown4 &&
            self.spellCategory4 == other.spellCategory4 &&
            self.spellCategoryCooldown4 == other.spellCategoryCooldown4 &&
            self.spellId5 == other.spellId5 &&
            self.spellTrigger5 == other.spellTrigger5 &&
            self.spellCharges5 == other.spellCharges5 &&
            self.spellPpmRate5 == other.spellPpmRate5 &&
            self.spellCooldown5 == other.spellCooldown5 &&
            self.spellCategory5 == other.spellCategory5 &&
            self.spellCategoryCooldown5 == other.spellCategoryCooldown5 &&
            self.allowableClass == other.allowableClass &&
            self.allowableRace == other.allowableRace &&
            self.itemLevel == other.itemLevel &&
            self.requiredLevel == other.requiredLevel &&
            self.requiredSkill == other.requiredSkill &&
            self.requiredSkillRank == other.requiredSkillRank &&
            self.requiredSpell == other.requiredSpell &&
            self.requiredHonorRank == other.requiredHonorRank &&
            self.requiredCityRank == other.requiredCityRank &&
            self.requiredReputationFaction == other.requiredReputationFaction &&
            self.requiredReputationRank == other.requiredReputationRank &&
            self.requiredDisenchantSkill == other.requiredDisenchantSkill &&
            self.mapId == other.mapId &&
            self.area == other.area &&
            self.holidayId == other.holidayId &&
            self.lockid == other.lockid &&
            self.gemProperties == other.gemProperties &&
            self.socketBonus == other.socketBonus &&
            self.socketColor1 == other.socketColor1 &&
            self.socketContent1 == other.socketContent1 &&
            self.socketColor2 == other.socketColor2 &&
            self.socketContent2 == other.socketContent2 &&
            self.socketColor3 == other.socketColor3 &&
            self.socketContent3 == other.socketContent3 &&
            self.pageText == other.pageText &&
            self.pageMaterial == other.pageMaterial &&
            self.languageId == other.languageId &&
            self.scriptName == other.scriptName &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as ItemTemplateEntity;
    return Object.hashAll([
      self.runtimeType,
      self.entry,
      self.name,
      self.description,
      self.quality,
      self.className,
      self.subclass,
      self.soundOverrideSubclass,
      self.material,
      self.displayId,
      self.inventoryType,
      self.sheath,
      self.bonding,
      self.itemset,
      self.randomProperty,
      self.randomSuffix,
      self.maxDurability,
      self.buyPrice,
      self.sellPrice,
      self.buyCount,
      self.maxcount,
      self.stackable,
      self.totemCategory,
      self.foodType,
      self.bagFamily,
      self.containerSlots,
      self.itemLimitCategory,
      self.startquest,
      self.duration,
      self.disenchantId,
      self.minMoneyLoot,
      self.maxMoneyLoot,
      self.flags,
      self.flagsExtra,
      self.flagsCustom,
      self.delay,
      self.rangedModRange,
      self.armorDamageModifier,
      self.dmgType1,
      self.dmgMin1,
      self.dmgMax1,
      self.dmgType2,
      self.dmgMin2,
      self.dmgMax2,
      self.ammoType,
      self.armor,
      self.block,
      self.scalingStatDistribution,
      self.scalingStatValue,
      self.statType1,
      self.statValue1,
      self.statType2,
      self.statValue2,
      self.statType3,
      self.statValue3,
      self.statType4,
      self.statValue4,
      self.statType5,
      self.statValue5,
      self.statType6,
      self.statValue6,
      self.statType7,
      self.statValue7,
      self.statType8,
      self.statValue8,
      self.statType9,
      self.statValue9,
      self.statType10,
      self.statValue10,
      self.holyRes,
      self.fireRes,
      self.natureRes,
      self.shadowRes,
      self.frostRes,
      self.arcaneRes,
      self.spellId1,
      self.spellTrigger1,
      self.spellCharges1,
      self.spellPpmRate1,
      self.spellCooldown1,
      self.spellCategory1,
      self.spellCategoryCooldown1,
      self.spellId2,
      self.spellTrigger2,
      self.spellCharges2,
      self.spellPpmRate2,
      self.spellCooldown2,
      self.spellCategory2,
      self.spellCategoryCooldown2,
      self.spellId3,
      self.spellTrigger3,
      self.spellCharges3,
      self.spellPpmRate3,
      self.spellCooldown3,
      self.spellCategory3,
      self.spellCategoryCooldown3,
      self.spellId4,
      self.spellTrigger4,
      self.spellCharges4,
      self.spellPpmRate4,
      self.spellCooldown4,
      self.spellCategory4,
      self.spellCategoryCooldown4,
      self.spellId5,
      self.spellTrigger5,
      self.spellCharges5,
      self.spellPpmRate5,
      self.spellCooldown5,
      self.spellCategory5,
      self.spellCategoryCooldown5,
      self.allowableClass,
      self.allowableRace,
      self.itemLevel,
      self.requiredLevel,
      self.requiredSkill,
      self.requiredSkillRank,
      self.requiredSpell,
      self.requiredHonorRank,
      self.requiredCityRank,
      self.requiredReputationFaction,
      self.requiredReputationRank,
      self.requiredDisenchantSkill,
      self.mapId,
      self.area,
      self.holidayId,
      self.lockid,
      self.gemProperties,
      self.socketBonus,
      self.socketColor1,
      self.socketContent1,
      self.socketColor2,
      self.socketContent2,
      self.socketColor3,
      self.socketContent3,
      self.pageText,
      self.pageMaterial,
      self.languageId,
      self.scriptName,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as ItemTemplateEntity;
    return 'ItemTemplateEntity('
        'entry: ${self.entry}, '
        'name: ${self.name}, '
        'description: ${self.description}, '
        'quality: ${self.quality}, '
        'className: ${self.className}, '
        'subclass: ${self.subclass}, '
        'soundOverrideSubclass: ${self.soundOverrideSubclass}, '
        'material: ${self.material}, '
        'displayId: ${self.displayId}, '
        'inventoryType: ${self.inventoryType}, '
        'sheath: ${self.sheath}, '
        'bonding: ${self.bonding}, '
        'itemset: ${self.itemset}, '
        'randomProperty: ${self.randomProperty}, '
        'randomSuffix: ${self.randomSuffix}, '
        'maxDurability: ${self.maxDurability}, '
        'buyPrice: ${self.buyPrice}, '
        'sellPrice: ${self.sellPrice}, '
        'buyCount: ${self.buyCount}, '
        'maxcount: ${self.maxcount}, '
        'stackable: ${self.stackable}, '
        'totemCategory: ${self.totemCategory}, '
        'foodType: ${self.foodType}, '
        'bagFamily: ${self.bagFamily}, '
        'containerSlots: ${self.containerSlots}, '
        'itemLimitCategory: ${self.itemLimitCategory}, '
        'startquest: ${self.startquest}, '
        'duration: ${self.duration}, '
        'disenchantId: ${self.disenchantId}, '
        'minMoneyLoot: ${self.minMoneyLoot}, '
        'maxMoneyLoot: ${self.maxMoneyLoot}, '
        'flags: ${self.flags}, '
        'flagsExtra: ${self.flagsExtra}, '
        'flagsCustom: ${self.flagsCustom}, '
        'delay: ${self.delay}, '
        'rangedModRange: ${self.rangedModRange}, '
        'armorDamageModifier: ${self.armorDamageModifier}, '
        'dmgType1: ${self.dmgType1}, '
        'dmgMin1: ${self.dmgMin1}, '
        'dmgMax1: ${self.dmgMax1}, '
        'dmgType2: ${self.dmgType2}, '
        'dmgMin2: ${self.dmgMin2}, '
        'dmgMax2: ${self.dmgMax2}, '
        'ammoType: ${self.ammoType}, '
        'armor: ${self.armor}, '
        'block: ${self.block}, '
        'scalingStatDistribution: ${self.scalingStatDistribution}, '
        'scalingStatValue: ${self.scalingStatValue}, '
        'statType1: ${self.statType1}, '
        'statValue1: ${self.statValue1}, '
        'statType2: ${self.statType2}, '
        'statValue2: ${self.statValue2}, '
        'statType3: ${self.statType3}, '
        'statValue3: ${self.statValue3}, '
        'statType4: ${self.statType4}, '
        'statValue4: ${self.statValue4}, '
        'statType5: ${self.statType5}, '
        'statValue5: ${self.statValue5}, '
        'statType6: ${self.statType6}, '
        'statValue6: ${self.statValue6}, '
        'statType7: ${self.statType7}, '
        'statValue7: ${self.statValue7}, '
        'statType8: ${self.statType8}, '
        'statValue8: ${self.statValue8}, '
        'statType9: ${self.statType9}, '
        'statValue9: ${self.statValue9}, '
        'statType10: ${self.statType10}, '
        'statValue10: ${self.statValue10}, '
        'holyRes: ${self.holyRes}, '
        'fireRes: ${self.fireRes}, '
        'natureRes: ${self.natureRes}, '
        'shadowRes: ${self.shadowRes}, '
        'frostRes: ${self.frostRes}, '
        'arcaneRes: ${self.arcaneRes}, '
        'spellId1: ${self.spellId1}, '
        'spellTrigger1: ${self.spellTrigger1}, '
        'spellCharges1: ${self.spellCharges1}, '
        'spellPpmRate1: ${self.spellPpmRate1}, '
        'spellCooldown1: ${self.spellCooldown1}, '
        'spellCategory1: ${self.spellCategory1}, '
        'spellCategoryCooldown1: ${self.spellCategoryCooldown1}, '
        'spellId2: ${self.spellId2}, '
        'spellTrigger2: ${self.spellTrigger2}, '
        'spellCharges2: ${self.spellCharges2}, '
        'spellPpmRate2: ${self.spellPpmRate2}, '
        'spellCooldown2: ${self.spellCooldown2}, '
        'spellCategory2: ${self.spellCategory2}, '
        'spellCategoryCooldown2: ${self.spellCategoryCooldown2}, '
        'spellId3: ${self.spellId3}, '
        'spellTrigger3: ${self.spellTrigger3}, '
        'spellCharges3: ${self.spellCharges3}, '
        'spellPpmRate3: ${self.spellPpmRate3}, '
        'spellCooldown3: ${self.spellCooldown3}, '
        'spellCategory3: ${self.spellCategory3}, '
        'spellCategoryCooldown3: ${self.spellCategoryCooldown3}, '
        'spellId4: ${self.spellId4}, '
        'spellTrigger4: ${self.spellTrigger4}, '
        'spellCharges4: ${self.spellCharges4}, '
        'spellPpmRate4: ${self.spellPpmRate4}, '
        'spellCooldown4: ${self.spellCooldown4}, '
        'spellCategory4: ${self.spellCategory4}, '
        'spellCategoryCooldown4: ${self.spellCategoryCooldown4}, '
        'spellId5: ${self.spellId5}, '
        'spellTrigger5: ${self.spellTrigger5}, '
        'spellCharges5: ${self.spellCharges5}, '
        'spellPpmRate5: ${self.spellPpmRate5}, '
        'spellCooldown5: ${self.spellCooldown5}, '
        'spellCategory5: ${self.spellCategory5}, '
        'spellCategoryCooldown5: ${self.spellCategoryCooldown5}, '
        'allowableClass: ${self.allowableClass}, '
        'allowableRace: ${self.allowableRace}, '
        'itemLevel: ${self.itemLevel}, '
        'requiredLevel: ${self.requiredLevel}, '
        'requiredSkill: ${self.requiredSkill}, '
        'requiredSkillRank: ${self.requiredSkillRank}, '
        'requiredSpell: ${self.requiredSpell}, '
        'requiredHonorRank: ${self.requiredHonorRank}, '
        'requiredCityRank: ${self.requiredCityRank}, '
        'requiredReputationFaction: ${self.requiredReputationFaction}, '
        'requiredReputationRank: ${self.requiredReputationRank}, '
        'requiredDisenchantSkill: ${self.requiredDisenchantSkill}, '
        'mapId: ${self.mapId}, '
        'area: ${self.area}, '
        'holidayId: ${self.holidayId}, '
        'lockid: ${self.lockid}, '
        'gemProperties: ${self.gemProperties}, '
        'socketBonus: ${self.socketBonus}, '
        'socketColor1: ${self.socketColor1}, '
        'socketContent1: ${self.socketContent1}, '
        'socketColor2: ${self.socketColor2}, '
        'socketContent2: ${self.socketContent2}, '
        'socketColor3: ${self.socketColor3}, '
        'socketContent3: ${self.socketContent3}, '
        'pageText: ${self.pageText}, '
        'pageMaterial: ${self.pageMaterial}, '
        'languageId: ${self.languageId}, '
        'scriptName: ${self.scriptName}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class BriefItemTemplateEntity {
  final int entry;
  final String name;
  final int quality;
  final int subclass;
  final int inventoryType;
  final int itemLevel;
  final int requiredLevel;
  final String localeName;
  final int classId;
  final String inventoryIcon;

  const BriefItemTemplateEntity({
    this.entry = 0,
    this.name = '',
    this.quality = 0,
    this.subclass = 0,
    this.inventoryType = 0,
    this.itemLevel = 0,
    this.requiredLevel = 0,
    this.localeName = '',
    this.classId = 0,
    this.inventoryIcon = '',
  });

  factory BriefItemTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemTemplateEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      quality: (json['Quality'] as num?)?.toInt() ?? 0,
      subclass: (json['subclass'] as num?)?.toInt() ?? 0,
      inventoryType: (json['InventoryType'] as num?)?.toInt() ?? 0,
      itemLevel: (json['ItemLevel'] as num?)?.toInt() ?? 0,
      requiredLevel: (json['RequiredLevel'] as num?)?.toInt() ?? 0,
      localeName: json['localeName']?.toString() ?? '',
      classId: (json['classId'] as num?)?.toInt() ?? 0,
      inventoryIcon: json['inventoryIcon']?.toString() ?? '',
    );
  }

  int get key => entry;
}
