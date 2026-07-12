import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemTemplateDetailViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<ItemTemplateRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Card 1: Basic Info
  late final entryController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final descriptionController = registerController(
    StringFieldController(),
  );
  late final qualityController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final classNameController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final subclassController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final soundOverrideSubclassController = registerController(
    IntFieldController(),
  );
  late final materialController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final displayIdController = registerController(IntFieldController());
  late final inventoryTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final sheathController = registerController(
    SelectFieldController<int>(fallback: 0),
  );

  /// Card 2: Set/Pricing/Container/Misc
  late final bondingController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final itemsetController = registerController(IntFieldController());
  late final randomPropertyController = registerController(
    IntFieldController(),
  );
  late final randomSuffixController = registerController(IntFieldController());
  late final maxDurabilityController = registerController(IntFieldController());
  late final buyPriceController = registerController(IntFieldController());
  late final sellPriceController = registerController(IntFieldController());
  late final buyCountController = registerController(IntFieldController());
  late final maxcountController = registerController(IntFieldController());
  late final stackableController = registerController(IntFieldController());
  late final totemCategoryController = registerController(IntFieldController());
  late final foodTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final bagFamilyController = registerController(FlagFieldController());
  late final containerSlotsController = registerController(
    IntFieldController(),
  );
  late final itemLimitCategoryController = registerController(
    IntFieldController(),
  );
  late final startquestController = registerController(IntFieldController());
  late final durationController = registerController(IntFieldController());
  late final disenchantIdController = registerController(IntFieldController());
  late final minMoneyLootController = registerController(IntFieldController());
  late final maxMoneyLootController = registerController(IntFieldController());

  /// Card 3: Flags
  late final flagsController = registerController(FlagFieldController());
  late final flagsExtraController = registerController(FlagFieldController());
  late final flagsCustomController = registerController(FlagFieldController());

  /// Card 4: Damage/Armor
  late final delayController = registerController(IntFieldController());
  late final rangedModRangeController = registerController(
    IntFieldController(),
  );
  late final armorDamageModifierController = registerController(
    DoubleFieldController(),
  );
  late final dmgType1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final dmgMin1Controller = registerController(DoubleFieldController());
  late final dmgMax1Controller = registerController(DoubleFieldController());
  late final dmgType2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final dmgMin2Controller = registerController(DoubleFieldController());
  late final dmgMax2Controller = registerController(DoubleFieldController());
  late final ammoTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final armorController = registerController(IntFieldController());
  late final blockController = registerController(IntFieldController());

  /// Card 5: Scaling Stats
  late final scalingStatDistributionController = registerController(
    IntFieldController(),
  );
  late final scalingStatValueController = registerController(
    FlagFieldController(),
  );

  /// Card 6: Stats
  late final statsCountController = registerController(IntFieldController());
  late final statType0Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statType1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statType2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statType3Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statType4Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statType5Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statType6Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statType7Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statType8Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statType9Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statValue0Controller = registerController(IntFieldController());
  late final statValue1Controller = registerController(IntFieldController());
  late final statValue2Controller = registerController(IntFieldController());
  late final statValue3Controller = registerController(IntFieldController());
  late final statValue4Controller = registerController(IntFieldController());
  late final statValue5Controller = registerController(IntFieldController());
  late final statValue6Controller = registerController(IntFieldController());
  late final statValue7Controller = registerController(IntFieldController());
  late final statValue8Controller = registerController(IntFieldController());
  late final statValue9Controller = registerController(IntFieldController());

  /// Card 7: Resistances
  late final holyResController = registerController(IntFieldController());
  late final fireResController = registerController(IntFieldController());
  late final natureResController = registerController(IntFieldController());
  late final shadowResController = registerController(IntFieldController());
  late final frostResController = registerController(IntFieldController());
  late final arcaneResController = registerController(IntFieldController());

  /// Card 8: Spells (5 slots)
  late final spellId0Controller = registerController(IntFieldController());
  late final spellId1Controller = registerController(IntFieldController());
  late final spellId2Controller = registerController(IntFieldController());
  late final spellId3Controller = registerController(IntFieldController());
  late final spellId4Controller = registerController(IntFieldController());
  late final spellTrigger0Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellTrigger1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellTrigger2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellTrigger3Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellTrigger4Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellCharge0Controller = registerController(IntFieldController());
  late final spellCharge1Controller = registerController(IntFieldController());
  late final spellCharge2Controller = registerController(IntFieldController());
  late final spellCharge3Controller = registerController(IntFieldController());
  late final spellCharge4Controller = registerController(IntFieldController());
  late final spellPpmRate0Controller = registerController(
    DoubleFieldController(),
  );
  late final spellPpmRate1Controller = registerController(
    DoubleFieldController(),
  );
  late final spellPpmRate2Controller = registerController(
    DoubleFieldController(),
  );
  late final spellPpmRate3Controller = registerController(
    DoubleFieldController(),
  );
  late final spellPpmRate4Controller = registerController(
    DoubleFieldController(),
  );
  late final spellCooldown0Controller = registerController(
    IntFieldController(),
  );
  late final spellCooldown1Controller = registerController(
    IntFieldController(),
  );
  late final spellCooldown2Controller = registerController(
    IntFieldController(),
  );
  late final spellCooldown3Controller = registerController(
    IntFieldController(),
  );
  late final spellCooldown4Controller = registerController(
    IntFieldController(),
  );
  late final spellCategory0Controller = registerController(
    IntFieldController(),
  );
  late final spellCategory1Controller = registerController(
    IntFieldController(),
  );
  late final spellCategory2Controller = registerController(
    IntFieldController(),
  );
  late final spellCategory3Controller = registerController(
    IntFieldController(),
  );
  late final spellCategory4Controller = registerController(
    IntFieldController(),
  );
  late final spellCategoryCooldown0Controller = registerController(
    IntFieldController(),
  );
  late final spellCategoryCooldown1Controller = registerController(
    IntFieldController(),
  );
  late final spellCategoryCooldown2Controller = registerController(
    IntFieldController(),
  );
  late final spellCategoryCooldown3Controller = registerController(
    IntFieldController(),
  );
  late final spellCategoryCooldown4Controller = registerController(
    IntFieldController(),
  );

  /// Card 9: Requirements
  late final allowableClassController = registerController(
    FlagFieldController(),
  );
  late final allowableRaceController = registerController(
    FlagFieldController(),
  );
  late final itemLevelController = registerController(IntFieldController());
  late final requiredLevelController = registerController(IntFieldController());
  late final requiredSkillController = registerController(IntFieldController());
  late final requiredSkillRankController = registerController(
    IntFieldController(),
  );
  late final requiredSpellController = registerController(IntFieldController());
  late final requiredHonorRankController = registerController(
    IntFieldController(),
  );
  late final requiredCityRankController = registerController(
    IntFieldController(),
  );
  late final requiredReputationFactionController = registerController(
    IntFieldController(),
  );
  late final requiredReputationRankController = registerController(
    IntFieldController(),
  );
  late final requiredDisenchantSkillController = registerController(
    IntFieldController(),
  );

  /// Card 10: Socket/Gem
  late final lockidController = registerController(IntFieldController());
  late final gemPropertiesController = registerController(IntFieldController());
  late final socketBonusController = registerController(IntFieldController());
  late final socketColor0Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final socketColor1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final socketColor2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final socketContent0Controller = registerController(
    IntFieldController(),
  );
  late final socketContent1Controller = registerController(
    IntFieldController(),
  );
  late final socketContent2Controller = registerController(
    IntFieldController(),
  );

  SelectFieldController<int> statTypeController(int i) => switch (i) {
    0 => statType0Controller,
    1 => statType1Controller,
    2 => statType2Controller,
    3 => statType3Controller,
    4 => statType4Controller,
    5 => statType5Controller,
    6 => statType6Controller,
    7 => statType7Controller,
    8 => statType8Controller,
    9 => statType9Controller,
    _ => statType0Controller,
  };

  IntFieldController statValueController(int i) => switch (i) {
    0 => statValue0Controller,
    1 => statValue1Controller,
    2 => statValue2Controller,
    3 => statValue3Controller,
    4 => statValue4Controller,
    5 => statValue5Controller,
    6 => statValue6Controller,
    7 => statValue7Controller,
    8 => statValue8Controller,
    9 => statValue9Controller,
    _ => statValue0Controller,
  };

  IntFieldController spellIdController(int i) => switch (i) {
    0 => spellId0Controller,
    1 => spellId1Controller,
    2 => spellId2Controller,
    3 => spellId3Controller,
    4 => spellId4Controller,
    _ => spellId0Controller,
  };

  SelectFieldController<int> spellTriggerController(int i) => switch (i) {
    0 => spellTrigger0Controller,
    1 => spellTrigger1Controller,
    2 => spellTrigger2Controller,
    3 => spellTrigger3Controller,
    4 => spellTrigger4Controller,
    _ => spellTrigger0Controller,
  };

  IntFieldController spellChargeController(int i) => switch (i) {
    0 => spellCharge0Controller,
    1 => spellCharge1Controller,
    2 => spellCharge2Controller,
    3 => spellCharge3Controller,
    4 => spellCharge4Controller,
    _ => spellCharge0Controller,
  };

  DoubleFieldController spellPpmRateController(int i) => switch (i) {
    0 => spellPpmRate0Controller,
    1 => spellPpmRate1Controller,
    2 => spellPpmRate2Controller,
    3 => spellPpmRate3Controller,
    4 => spellPpmRate4Controller,
    _ => spellPpmRate0Controller,
  };

  IntFieldController spellCooldownController(int i) => switch (i) {
    0 => spellCooldown0Controller,
    1 => spellCooldown1Controller,
    2 => spellCooldown2Controller,
    3 => spellCooldown3Controller,
    4 => spellCooldown4Controller,
    _ => spellCooldown0Controller,
  };

  IntFieldController spellCategoryController(int i) => switch (i) {
    0 => spellCategory0Controller,
    1 => spellCategory1Controller,
    2 => spellCategory2Controller,
    3 => spellCategory3Controller,
    4 => spellCategory4Controller,
    _ => spellCategory0Controller,
  };

  IntFieldController spellCategoryCooldownController(int i) => switch (i) {
    0 => spellCategoryCooldown0Controller,
    1 => spellCategoryCooldown1Controller,
    2 => spellCategoryCooldown2Controller,
    3 => spellCategoryCooldown3Controller,
    4 => spellCategoryCooldown4Controller,
    _ => spellCategoryCooldown0Controller,
  };

  SelectFieldController<int> socketColorController(int i) => switch (i) {
    0 => socketColor0Controller,
    1 => socketColor1Controller,
    2 => socketColor2Controller,
    _ => socketColor0Controller,
  };

  IntFieldController socketContentController(int i) => switch (i) {
    0 => socketContent0Controller,
    1 => socketContent1Controller,
    2 => socketContent2Controller,
    _ => socketContent0Controller,
  };

  /// Card 11: Page/Misc
  late final mapIdController = registerController(IntFieldController());
  late final areaController = registerController(IntFieldController());
  late final holidayIdController = registerController(IntFieldController());
  late final pageTextController = registerController(IntFieldController());
  late final pageMaterialController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final languageIdController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final scriptNameController = registerController(StringFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  /// Signals
  final entry = signal<int>(0);
  final template = signal(ItemTemplateEntity());

  /// Computed conditions
  bool get hasEnchantment =>
      template.value.randomProperty != 0 || template.value.randomSuffix != 0;
  bool get hasItemLoot => (template.value.flags & 4) != 0;
  bool get hasDisenchantLoot => template.value.disenchantId != 0;
  bool get hasProspectingLoot => (template.value.flags & 262144) != 0;
  bool get hasMillingLoot => (template.value.flags & 536870912) != 0;

  Future<void> initSignals({int? entry}) async {
    try {
      if (entry == null || entry <= 0) {
        final blank = await _repository.createItemTemplate();
        template.value = blank;
        _initControllers(blank);
        return;
      }
      final result = await _repository.getItemTemplate(entry);
      if (result == null) return;
      template.value = result;
      _initControllers(result);
    } catch (e, s) {
      LoggerUtil.instance.e('加载物品模板(entry=$entry)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ItemTemplateEntity template) {
    /// Card 1: Basic Info
    entryController.init(template.entry);
    nameController.init(template.name);
    descriptionController.init(template.description);
    qualityController.init(template.quality);
    classNameController.init(template.className);
    subclassController.init(template.subclass);
    soundOverrideSubclassController.init(template.soundOverrideSubclass);
    materialController.init(template.material);
    displayIdController.init(template.displayId);
    inventoryTypeController.init(template.inventoryType);
    sheathController.init(template.sheath);

    /// Card 2: Set/Pricing/Container/Misc
    bondingController.init(template.bonding);
    itemsetController.init(template.itemset);
    randomPropertyController.init(template.randomProperty);
    randomSuffixController.init(template.randomSuffix);
    maxDurabilityController.init(template.maxDurability);
    buyPriceController.init(template.buyPrice);
    sellPriceController.init(template.sellPrice);
    buyCountController.init(template.buyCount);
    maxcountController.init(template.maxcount);
    stackableController.init(template.stackable);
    totemCategoryController.init(template.totemCategory);
    foodTypeController.init(template.foodType);
    bagFamilyController.init(template.bagFamily);
    containerSlotsController.init(template.containerSlots);
    itemLimitCategoryController.init(template.itemLimitCategory);
    startquestController.init(template.startquest);
    durationController.init(template.duration);
    disenchantIdController.init(template.disenchantId);
    minMoneyLootController.init(template.minMoneyLoot);
    maxMoneyLootController.init(template.maxMoneyLoot);

    /// Card 3: Flags
    flagsController.init(template.flags);
    flagsExtraController.init(template.flagsExtra);
    flagsCustomController.init(template.flagsCustom);

    /// Card 4: Damage/Armor
    delayController.init(template.delay);
    rangedModRangeController.init(template.rangedModRange);
    armorDamageModifierController.init(template.armorDamageModifier);
    dmgType1Controller.init(template.dmgType1);
    dmgMin1Controller.init(template.dmgMin1);
    dmgMax1Controller.init(template.dmgMax1);
    dmgType2Controller.init(template.dmgType2);
    dmgMin2Controller.init(template.dmgMin2);
    dmgMax2Controller.init(template.dmgMax2);
    ammoTypeController.init(template.ammoType);
    armorController.init(template.armor);
    blockController.init(template.block);

    /// Card 5: Scaling Stats
    scalingStatDistributionController.init(template.scalingStatDistribution);
    scalingStatValueController.init(template.scalingStatValue);

    /// Card 6: Stats
    statsCountController.init(template.statsCount);
    statType0Controller.init(template.statTypes[0]);
    statType1Controller.init(template.statTypes[1]);
    statType2Controller.init(template.statTypes[2]);
    statType3Controller.init(template.statTypes[3]);
    statType4Controller.init(template.statTypes[4]);
    statType5Controller.init(template.statTypes[5]);
    statType6Controller.init(template.statTypes[6]);
    statType7Controller.init(template.statTypes[7]);
    statType8Controller.init(template.statTypes[8]);
    statType9Controller.init(template.statTypes[9]);
    statValue0Controller.init(template.statValues[0]);
    statValue1Controller.init(template.statValues[1]);
    statValue2Controller.init(template.statValues[2]);
    statValue3Controller.init(template.statValues[3]);
    statValue4Controller.init(template.statValues[4]);
    statValue5Controller.init(template.statValues[5]);
    statValue6Controller.init(template.statValues[6]);
    statValue7Controller.init(template.statValues[7]);
    statValue8Controller.init(template.statValues[8]);
    statValue9Controller.init(template.statValues[9]);

    /// Card 7: Resistances
    holyResController.init(template.holyRes);
    fireResController.init(template.fireRes);
    natureResController.init(template.natureRes);
    shadowResController.init(template.shadowRes);
    frostResController.init(template.frostRes);
    arcaneResController.init(template.arcaneRes);

    /// Card 8: Spells (5 slots)
    spellId0Controller.init(template.spellIds[0]);
    spellId1Controller.init(template.spellIds[1]);
    spellId2Controller.init(template.spellIds[2]);
    spellId3Controller.init(template.spellIds[3]);
    spellId4Controller.init(template.spellIds[4]);
    spellTrigger0Controller.init(template.spellTriggers[0]);
    spellTrigger1Controller.init(template.spellTriggers[1]);
    spellTrigger2Controller.init(template.spellTriggers[2]);
    spellTrigger3Controller.init(template.spellTriggers[3]);
    spellTrigger4Controller.init(template.spellTriggers[4]);
    spellCharge0Controller.init(template.spellCharges[0]);
    spellCharge1Controller.init(template.spellCharges[1]);
    spellCharge2Controller.init(template.spellCharges[2]);
    spellCharge3Controller.init(template.spellCharges[3]);
    spellCharge4Controller.init(template.spellCharges[4]);
    spellPpmRate0Controller.init(template.spellPpmRates[0]);
    spellPpmRate1Controller.init(template.spellPpmRates[1]);
    spellPpmRate2Controller.init(template.spellPpmRates[2]);
    spellPpmRate3Controller.init(template.spellPpmRates[3]);
    spellPpmRate4Controller.init(template.spellPpmRates[4]);
    spellCooldown0Controller.init(template.spellCooldowns[0]);
    spellCooldown1Controller.init(template.spellCooldowns[1]);
    spellCooldown2Controller.init(template.spellCooldowns[2]);
    spellCooldown3Controller.init(template.spellCooldowns[3]);
    spellCooldown4Controller.init(template.spellCooldowns[4]);
    spellCategory0Controller.init(template.spellCategories[0]);
    spellCategory1Controller.init(template.spellCategories[1]);
    spellCategory2Controller.init(template.spellCategories[2]);
    spellCategory3Controller.init(template.spellCategories[3]);
    spellCategory4Controller.init(template.spellCategories[4]);
    spellCategoryCooldown0Controller.init(template.spellCategoryCooldowns[0]);
    spellCategoryCooldown1Controller.init(template.spellCategoryCooldowns[1]);
    spellCategoryCooldown2Controller.init(template.spellCategoryCooldowns[2]);
    spellCategoryCooldown3Controller.init(template.spellCategoryCooldowns[3]);
    spellCategoryCooldown4Controller.init(template.spellCategoryCooldowns[4]);

    /// Card 9: Requirements
    allowableClassController.init(template.allowableClass);
    allowableRaceController.init(template.allowableRace);
    itemLevelController.init(template.itemLevel);
    requiredLevelController.init(template.requiredLevel);
    requiredSkillController.init(template.requiredSkill);
    requiredSkillRankController.init(template.requiredSkillRank);
    requiredSpellController.init(template.requiredSpell);
    requiredHonorRankController.init(template.requiredHonorRank);
    requiredCityRankController.init(template.requiredCityRank);
    requiredReputationFactionController.init(
      template.requiredReputationFaction,
    );
    requiredReputationRankController.init(template.requiredReputationRank);
    requiredDisenchantSkillController.init(template.requiredDisenchantSkill);

    /// Card 10: Socket/Gem
    lockidController.init(template.lockid);
    gemPropertiesController.init(template.gemProperties);
    socketBonusController.init(template.socketBonus);
    socketColor0Controller.init(template.socketColors[0]);
    socketColor1Controller.init(template.socketColors[1]);
    socketColor2Controller.init(template.socketColors[2]);
    socketContent0Controller.init(template.socketContents[0]);
    socketContent1Controller.init(template.socketContents[1]);
    socketContent2Controller.init(template.socketContents[2]);

    /// Card 11: Page/Misc
    mapIdController.init(template.mapId);
    areaController.init(template.area);
    holidayIdController.init(template.holidayId);
    pageTextController.init(template.pageText);
    pageMaterialController.init(template.pageMaterial);
    languageIdController.init(template.languageId);
    scriptNameController.init(template.scriptName);
    verifiedBuildController.init(template.verifiedBuild);
  }

  ItemTemplateEntity _collectFromControllers() {
    return ItemTemplateEntity(
      /// Card 1: Basic Info
      entry: entryController.collect(),
      name: nameController.collect(),
      description: descriptionController.collect(),
      quality: qualityController.collect(),
      className: classNameController.collect(),
      subclass: subclassController.collect(),
      soundOverrideSubclass: soundOverrideSubclassController.collect(),
      material: materialController.collect(),
      displayId: displayIdController.collect(),
      inventoryType: inventoryTypeController.collect(),
      sheath: sheathController.collect(),

      /// Card 2: Set/Pricing/Container/Misc
      bonding: bondingController.collect(),
      itemset: itemsetController.collect(),
      randomProperty: randomPropertyController.collect(),
      randomSuffix: randomSuffixController.collect(),
      maxDurability: maxDurabilityController.collect(),
      buyPrice: buyPriceController.collect(),
      sellPrice: sellPriceController.collect(),
      buyCount: buyCountController.collect(),
      maxcount: maxcountController.collect(),
      stackable: stackableController.collect(),
      totemCategory: totemCategoryController.collect(),
      foodType: foodTypeController.collect(),
      bagFamily: bagFamilyController.collect(),
      containerSlots: containerSlotsController.collect(),
      itemLimitCategory: itemLimitCategoryController.collect(),
      startquest: startquestController.collect(),
      duration: durationController.collect(),
      disenchantId: disenchantIdController.collect(),
      minMoneyLoot: minMoneyLootController.collect(),
      maxMoneyLoot: maxMoneyLootController.collect(),

      /// Card 3: Flags
      flags: flagsController.collect(),
      flagsExtra: flagsExtraController.collect(),
      flagsCustom: flagsCustomController.collect(),

      /// Card 4: Damage/Armor
      delay: delayController.collect(),
      rangedModRange: rangedModRangeController.collect(),
      armorDamageModifier: armorDamageModifierController.collect(),
      dmgType1: dmgType1Controller.collect(),
      dmgMin1: dmgMin1Controller.collect(),
      dmgMax1: dmgMax1Controller.collect(),
      dmgType2: dmgType2Controller.collect(),
      dmgMin2: dmgMin2Controller.collect(),
      dmgMax2: dmgMax2Controller.collect(),
      ammoType: ammoTypeController.collect(),
      armor: armorController.collect(),
      block: blockController.collect(),

      /// Card 5: Scaling Stats
      scalingStatDistribution: scalingStatDistributionController.collect(),
      scalingStatValue: scalingStatValueController.collect(),

      /// Card 6: Stats
      statsCount: statsCountController.collect(),
      statTypes: [
        statType0Controller.collect(),
        statType1Controller.collect(),
        statType2Controller.collect(),
        statType3Controller.collect(),
        statType4Controller.collect(),
        statType5Controller.collect(),
        statType6Controller.collect(),
        statType7Controller.collect(),
        statType8Controller.collect(),
        statType9Controller.collect(),
      ],
      statValues: [
        statValue0Controller.collect(),
        statValue1Controller.collect(),
        statValue2Controller.collect(),
        statValue3Controller.collect(),
        statValue4Controller.collect(),
        statValue5Controller.collect(),
        statValue6Controller.collect(),
        statValue7Controller.collect(),
        statValue8Controller.collect(),
        statValue9Controller.collect(),
      ],

      /// Card 7: Resistances
      holyRes: holyResController.collect(),
      fireRes: fireResController.collect(),
      natureRes: natureResController.collect(),
      shadowRes: shadowResController.collect(),
      frostRes: frostResController.collect(),
      arcaneRes: arcaneResController.collect(),

      /// Card 8: Spells (5 slots)
      spellIds: [
        spellId0Controller.collect(),
        spellId1Controller.collect(),
        spellId2Controller.collect(),
        spellId3Controller.collect(),
        spellId4Controller.collect(),
      ],
      spellTriggers: [
        spellTrigger0Controller.collect(),
        spellTrigger1Controller.collect(),
        spellTrigger2Controller.collect(),
        spellTrigger3Controller.collect(),
        spellTrigger4Controller.collect(),
      ],
      spellCharges: [
        spellCharge0Controller.collect(),
        spellCharge1Controller.collect(),
        spellCharge2Controller.collect(),
        spellCharge3Controller.collect(),
        spellCharge4Controller.collect(),
      ],
      spellPpmRates: [
        spellPpmRate0Controller.collect(),
        spellPpmRate1Controller.collect(),
        spellPpmRate2Controller.collect(),
        spellPpmRate3Controller.collect(),
        spellPpmRate4Controller.collect(),
      ],
      spellCooldowns: [
        spellCooldown0Controller.collect(),
        spellCooldown1Controller.collect(),
        spellCooldown2Controller.collect(),
        spellCooldown3Controller.collect(),
        spellCooldown4Controller.collect(),
      ],
      spellCategories: [
        spellCategory0Controller.collect(),
        spellCategory1Controller.collect(),
        spellCategory2Controller.collect(),
        spellCategory3Controller.collect(),
        spellCategory4Controller.collect(),
      ],
      spellCategoryCooldowns: [
        spellCategoryCooldown0Controller.collect(),
        spellCategoryCooldown1Controller.collect(),
        spellCategoryCooldown2Controller.collect(),
        spellCategoryCooldown3Controller.collect(),
        spellCategoryCooldown4Controller.collect(),
      ],

      /// Card 9: Requirements
      allowableClass: allowableClassController.collect(),
      allowableRace: allowableRaceController.collect(),
      itemLevel: itemLevelController.collect(),
      requiredLevel: requiredLevelController.collect(),
      requiredSkill: requiredSkillController.collect(),
      requiredSkillRank: requiredSkillRankController.collect(),
      requiredSpell: requiredSpellController.collect(),
      requiredHonorRank: requiredHonorRankController.collect(),
      requiredCityRank: requiredCityRankController.collect(),
      requiredReputationFaction: requiredReputationFactionController.collect(),
      requiredReputationRank: requiredReputationRankController.collect(),
      requiredDisenchantSkill: requiredDisenchantSkillController.collect(),

      /// Card 10: Socket/Gem
      lockid: lockidController.collect(),
      gemProperties: gemPropertiesController.collect(),
      socketBonus: socketBonusController.collect(),
      socketColors: [
        socketColor0Controller.collect(),
        socketColor1Controller.collect(),
        socketColor2Controller.collect(),
      ],
      socketContents: [
        socketContent0Controller.collect(),
        socketContent1Controller.collect(),
        socketContent2Controller.collect(),
      ],

      /// Card 11: Page/Misc
      mapId: mapIdController.collect(),
      area: areaController.collect(),
      holidayId: holidayIdController.collect(),
      pageText: pageTextController.collect(),
      pageMaterial: pageMaterialController.collect(),
      languageId: languageIdController.collect(),
      scriptName: scriptNameController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final existed = await _repository.getItemTemplate(t.entry);
      if (existed == null) {
        final id = await _repository.storeItemTemplate(t);
        entryController.init(id);
        template.value = t.copyWith(entry: id);
        _logActivity(ActivityActionType.create, template.value);
      } else {
        await _repository.updateItemTemplate(t);
        template.value = t;
        _logActivity(ActivityActionType.update, t);
      }
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('模板数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void _logActivity(ActivityActionType action, ItemTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'item_template',
      actionType: action,
      entityId: t.entry,
      entityName: t.name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
