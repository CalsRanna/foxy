import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'item_template_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('localeName')
@FoxyBriefField.integer('classId')
@FoxyBriefField.text('inventoryIcon')
@FoxyFullEntity(table: 'item_template')
class ItemTemplateEntity with _ItemTemplateEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('entry', key: true)
  final int entry;

  @FoxyBriefField()
  @FoxyFullField('name')
  final String name;

  @FoxyFullField('description')
  final String description;

  @FoxyBriefField()
  @FoxyFullField('Quality')
  final int quality;

  @FoxyFullField('class')
  final int className;

  @FoxyBriefField()
  @FoxyFullField('subclass')
  final int subclass;

  @FoxyFullField('SoundOverrideSubclass')
  final int soundOverrideSubclass;

  @FoxyFullField('Material')
  final int material;

  @FoxyFullField('displayid')
  final int displayId;

  @FoxyBriefField()
  @FoxyFullField('InventoryType')
  final int inventoryType;

  @FoxyFullField('sheath')
  final int sheath;

  @FoxyFullField('bonding')
  final int bonding;

  @FoxyFullField('itemset')
  final int itemset;

  @FoxyFullField('RandomProperty')
  final int randomProperty;

  @FoxyFullField('RandomSuffix')
  final int randomSuffix;

  @FoxyFullField('MaxDurability')
  final int maxDurability;

  @FoxyFullField('BuyPrice')
  final int buyPrice;

  @FoxyFullField('SellPrice')
  final int sellPrice;

  @FoxyFullField('BuyCount')
  final int buyCount;

  @FoxyFullField('maxcount')
  final int maxcount;

  @FoxyFullField('stackable')
  final int stackable;

  @FoxyFullField('TotemCategory')
  final int totemCategory;

  @FoxyFullField('FoodType')
  final int foodType;

  @FoxyFullField('BagFamily')
  final int bagFamily;

  @FoxyFullField('ContainerSlots')
  final int containerSlots;

  @FoxyFullField('ItemLimitCategory')
  final int itemLimitCategory;

  @FoxyFullField('startquest')
  final int startquest;

  @FoxyFullField('duration')
  final int duration;

  @FoxyFullField('DisenchantID')
  final int disenchantId;

  @FoxyFullField('minMoneyLoot')
  final int minMoneyLoot;

  @FoxyFullField('maxMoneyLoot')
  final int maxMoneyLoot;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('FlagsExtra')
  final int flagsExtra;

  @FoxyFullField('flagsCustom')
  final int flagsCustom;

  @FoxyFullField('delay')
  final int delay;

  @FoxyFullField('RangedModRange')
  final double rangedModRange;

  @FoxyFullField('ArmorDamageModifier')
  final double armorDamageModifier;

  @FoxyFullField('dmg_type1')
  final int dmgType1;

  @FoxyFullField('dmg_min1')
  final double dmgMin1;

  @FoxyFullField('dmg_max1')
  final double dmgMax1;

  @FoxyFullField('dmg_type2')
  final int dmgType2;

  @FoxyFullField('dmg_min2')
  final double dmgMin2;

  @FoxyFullField('dmg_max2')
  final double dmgMax2;

  @FoxyFullField('ammo_type')
  final int ammoType;

  @FoxyFullField('armor')
  final int armor;

  @FoxyFullField('block')
  final int block;

  @FoxyFullField('ScalingStatDistribution')
  final int scalingStatDistribution;

  @FoxyFullField('ScalingStatValue')
  final int scalingStatValue;

  @FoxyFullField('stat_type1')
  final int statType1;

  @FoxyFullField('stat_value1')
  final int statValue1;

  @FoxyFullField('stat_type2')
  final int statType2;

  @FoxyFullField('stat_value2')
  final int statValue2;

  @FoxyFullField('stat_type3')
  final int statType3;

  @FoxyFullField('stat_value3')
  final int statValue3;

  @FoxyFullField('stat_type4')
  final int statType4;

  @FoxyFullField('stat_value4')
  final int statValue4;

  @FoxyFullField('stat_type5')
  final int statType5;

  @FoxyFullField('stat_value5')
  final int statValue5;

  @FoxyFullField('stat_type6')
  final int statType6;

  @FoxyFullField('stat_value6')
  final int statValue6;

  @FoxyFullField('stat_type7')
  final int statType7;

  @FoxyFullField('stat_value7')
  final int statValue7;

  @FoxyFullField('stat_type8')
  final int statType8;

  @FoxyFullField('stat_value8')
  final int statValue8;

  @FoxyFullField('stat_type9')
  final int statType9;

  @FoxyFullField('stat_value9')
  final int statValue9;

  @FoxyFullField('stat_type10')
  final int statType10;

  @FoxyFullField('stat_value10')
  final int statValue10;

  @FoxyFullField('holy_res')
  final int holyRes;

  @FoxyFullField('fire_res')
  final int fireRes;

  @FoxyFullField('nature_res')
  final int natureRes;

  @FoxyFullField('shadow_res')
  final int shadowRes;

  @FoxyFullField('frost_res')
  final int frostRes;

  @FoxyFullField('arcane_res')
  final int arcaneRes;

  @FoxyFullField('spellid_1')
  final int spellId1;

  @FoxyFullField('spelltrigger_1')
  final int spellTrigger1;

  @FoxyFullField('spellcharges_1')
  final int spellCharges1;

  @FoxyFullField('spellppmRate_1')
  final double spellPpmRate1;

  @FoxyFullField('spellcooldown_1')
  final int spellCooldown1;

  @FoxyFullField('spellcategory_1')
  final int spellCategory1;

  @FoxyFullField('spellcategorycooldown_1')
  final int spellCategoryCooldown1;

  @FoxyFullField('spellid_2')
  final int spellId2;

  @FoxyFullField('spelltrigger_2')
  final int spellTrigger2;

  @FoxyFullField('spellcharges_2')
  final int spellCharges2;

  @FoxyFullField('spellppmRate_2')
  final double spellPpmRate2;

  @FoxyFullField('spellcooldown_2')
  final int spellCooldown2;

  @FoxyFullField('spellcategory_2')
  final int spellCategory2;

  @FoxyFullField('spellcategorycooldown_2')
  final int spellCategoryCooldown2;

  @FoxyFullField('spellid_3')
  final int spellId3;

  @FoxyFullField('spelltrigger_3')
  final int spellTrigger3;

  @FoxyFullField('spellcharges_3')
  final int spellCharges3;

  @FoxyFullField('spellppmRate_3')
  final double spellPpmRate3;

  @FoxyFullField('spellcooldown_3')
  final int spellCooldown3;

  @FoxyFullField('spellcategory_3')
  final int spellCategory3;

  @FoxyFullField('spellcategorycooldown_3')
  final int spellCategoryCooldown3;

  @FoxyFullField('spellid_4')
  final int spellId4;

  @FoxyFullField('spelltrigger_4')
  final int spellTrigger4;

  @FoxyFullField('spellcharges_4')
  final int spellCharges4;

  @FoxyFullField('spellppmRate_4')
  final double spellPpmRate4;

  @FoxyFullField('spellcooldown_4')
  final int spellCooldown4;

  @FoxyFullField('spellcategory_4')
  final int spellCategory4;

  @FoxyFullField('spellcategorycooldown_4')
  final int spellCategoryCooldown4;

  @FoxyFullField('spellid_5')
  final int spellId5;

  @FoxyFullField('spelltrigger_5')
  final int spellTrigger5;

  @FoxyFullField('spellcharges_5')
  final int spellCharges5;

  @FoxyFullField('spellppmRate_5')
  final double spellPpmRate5;

  @FoxyFullField('spellcooldown_5')
  final int spellCooldown5;

  @FoxyFullField('spellcategory_5')
  final int spellCategory5;

  @FoxyFullField('spellcategorycooldown_5')
  final int spellCategoryCooldown5;

  @FoxyFullField('AllowableClass')
  final int allowableClass;

  @FoxyFullField('AllowableRace')
  final int allowableRace;

  @FoxyBriefField()
  @FoxyFullField('ItemLevel')
  final int itemLevel;

  @FoxyBriefField()
  @FoxyFullField('RequiredLevel')
  final int requiredLevel;

  @FoxyFullField('RequiredSkill')
  final int requiredSkill;

  @FoxyFullField('RequiredSkillRank')
  final int requiredSkillRank;

  @FoxyFullField('requiredspell')
  final int requiredSpell;

  @FoxyFullField('requiredhonorrank')
  final int requiredHonorRank;

  @FoxyFullField('RequiredCityRank')
  final int requiredCityRank;

  @FoxyFullField('RequiredReputationFaction')
  final int requiredReputationFaction;

  @FoxyFullField('RequiredReputationRank')
  final int requiredReputationRank;

  @FoxyFullField('RequiredDisenchantSkill')
  final int requiredDisenchantSkill;

  @FoxyFullField('Map')
  final int mapId;

  @FoxyFullField('area')
  final int area;

  @FoxyFullField('HolidayId')
  final int holidayId;

  @FoxyFullField('lockid')
  final int lockid;

  @FoxyFullField('GemProperties')
  final int gemProperties;

  @FoxyFullField('socketBonus')
  final int socketBonus;

  @FoxyFullField('socketColor_1')
  final int socketColor1;

  @FoxyFullField('socketContent_1')
  final int socketContent1;

  @FoxyFullField('socketColor_2')
  final int socketColor2;

  @FoxyFullField('socketContent_2')
  final int socketContent2;

  @FoxyFullField('socketColor_3')
  final int socketColor3;

  @FoxyFullField('socketContent_3')
  final int socketContent3;

  @FoxyFullField('PageText')
  final int pageText;

  @FoxyFullField('PageMaterial')
  final int pageMaterial;

  @FoxyFullField('LanguageID')
  final int languageId;

  @FoxyFullField('ScriptName')
  final String scriptName;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const ItemTemplateEntity({
    this.entry = 0,
    this.name = '',
    this.description = '',
    this.quality = 0,
    this.className = 0,
    this.subclass = 0,
    this.soundOverrideSubclass = -1,
    this.material = 0,
    this.displayId = 0,
    this.inventoryType = 0,
    this.sheath = 0,
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
    this.totemCategory = 0,
    this.foodType = 0,
    this.bagFamily = 0,
    this.containerSlots = 0,
    this.itemLimitCategory = 0,
    this.startquest = 0,
    this.duration = 0,
    this.disenchantId = 0,
    this.minMoneyLoot = 0,
    this.maxMoneyLoot = 0,
    this.flags = 0,
    this.flagsExtra = 0,
    this.flagsCustom = 0,
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
    this.scalingStatDistribution = 0,
    this.scalingStatValue = 0,
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
    this.holyRes = 0,
    this.fireRes = 0,
    this.natureRes = 0,
    this.shadowRes = 0,
    this.frostRes = 0,
    this.arcaneRes = 0,
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
    this.mapId = 0,
    this.area = 0,
    this.holidayId = 0,
    this.lockid = 0,
    this.gemProperties = 0,
    this.socketBonus = 0,
    this.socketColor1 = 0,
    this.socketContent1 = 0,
    this.socketColor2 = 0,
    this.socketContent2 = 0,
    this.socketColor3 = 0,
    this.socketContent3 = 0,
    this.pageText = 0,
    this.pageMaterial = 0,
    this.languageId = 0,
    this.scriptName = '',
    this.verifiedBuild = 0,
  });

  factory ItemTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _ItemTemplateEntityMixin.fromJson(json);

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
}

extension BriefItemTemplateEntityDisplay on BriefItemTemplateEntity {
  String get displayName => localeName.isNotEmpty ? localeName : name;
}
