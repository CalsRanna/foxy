import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/entity/item_template_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/item_template_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemTemplateDetailViewModel
    with
        ViewModelValidationMixin,
        ItemTemplateValidationMixin,
        FieldControllerMixin {
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
    DoubleFieldController(),
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
  late final statType10Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statValue1Controller = registerController(IntFieldController());
  late final statValue2Controller = registerController(IntFieldController());
  late final statValue3Controller = registerController(IntFieldController());
  late final statValue4Controller = registerController(IntFieldController());
  late final statValue5Controller = registerController(IntFieldController());
  late final statValue6Controller = registerController(IntFieldController());
  late final statValue7Controller = registerController(IntFieldController());
  late final statValue8Controller = registerController(IntFieldController());
  late final statValue9Controller = registerController(IntFieldController());
  late final statValue10Controller = registerController(IntFieldController());

  /// Card 7: Resistances
  late final holyResController = registerController(IntFieldController());
  late final fireResController = registerController(IntFieldController());
  late final natureResController = registerController(IntFieldController());
  late final shadowResController = registerController(IntFieldController());
  late final frostResController = registerController(IntFieldController());
  late final arcaneResController = registerController(IntFieldController());

  /// Card 8: Spells (5 slots)
  late final spellId1Controller = registerController(IntFieldController());
  late final spellId2Controller = registerController(IntFieldController());
  late final spellId3Controller = registerController(IntFieldController());
  late final spellId4Controller = registerController(IntFieldController());
  late final spellId5Controller = registerController(IntFieldController());
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
  late final spellTrigger5Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellCharge1Controller = registerController(IntFieldController());
  late final spellCharge2Controller = registerController(IntFieldController());
  late final spellCharge3Controller = registerController(IntFieldController());
  late final spellCharge4Controller = registerController(IntFieldController());
  late final spellCharge5Controller = registerController(IntFieldController());
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
  late final spellPpmRate5Controller = registerController(
    DoubleFieldController(),
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
  late final spellCooldown5Controller = registerController(
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
  late final spellCategory5Controller = registerController(
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
  late final spellCategoryCooldown5Controller = registerController(
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
    SelectFieldController<int>(fallback: 0),
  );
  late final requiredDisenchantSkillController = registerController(
    IntFieldController(),
  );

  /// Card 10: Socket/Gem
  late final lockidController = registerController(IntFieldController());
  late final gemPropertiesController = registerController(IntFieldController());
  late final socketBonusController = registerController(IntFieldController());
  late final socketColor1Controller = registerController(FlagFieldController());
  late final socketColor2Controller = registerController(FlagFieldController());
  late final socketColor3Controller = registerController(FlagFieldController());
  late final socketContent1Controller = registerController(
    IntFieldController(),
  );
  late final socketContent2Controller = registerController(
    IntFieldController(),
  );
  late final socketContent3Controller = registerController(
    IntFieldController(),
  );

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
  final template = signal(ItemTemplateEntity());
  final persistedKey = signal<ItemTemplateKey?>(null);

  bool get hasDisenchantLoot => template.value.disenchantId != 0;

  /// Computed conditions
  bool get hasEnchantment =>
      template.value.randomProperty != 0 || template.value.randomSuffix != 0;
  bool get hasItemLoot => (template.value.flags & 4) != 0;
  bool get hasMillingLoot => (template.value.flags & 536870912) != 0;
  bool get hasProspectingLoot => (template.value.flags & 262144) != 0;

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({ItemTemplateKey? key}) async {
    try {
      if (key == null) {
        persistedKey.value = null;
        final blank = await _repository.createItemTemplate();
        template.value = blank;
        _initControllers(blank);
        return;
      }
      persistedKey.value = key;
      final result = await _repository.getItemTemplate(key);
      if (result == null) {
        throw StateError('原物品模板不存在，可能已被其他操作修改或删除');
      }
      template.value = result;
      _initControllers(result);
    } catch (e, s) {
      LoggerUtil.instance.e('加载物品模板(key=$key)失败', error: e, stackTrace: s);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<void> persist() async {
    final candidate = _collectFromControllers();
    validateItemTemplateFields(candidate);
    final originalKey = persistedKey.value;
    final action = originalKey == null
        ? ActivityActionType.create
        : ActivityActionType.update;
    if (originalKey == null) {
      await _repository.storeItemTemplate(candidate);
    } else {
      await _repository.updateItemTemplate(originalKey, candidate);
    }
    persistedKey.value = ItemTemplateKey.fromEntity(candidate);
    template.value = candidate;
    routerFacade.updateCurrentLabel(_labelFor(candidate));
    _logActivity(action, candidate);
  }

  Future<void> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('模板数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
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
      statType1: statType1Controller.collect(),
      statValue1: statValue1Controller.collect(),
      statType2: statType2Controller.collect(),
      statValue2: statValue2Controller.collect(),
      statType3: statType3Controller.collect(),
      statValue3: statValue3Controller.collect(),
      statType4: statType4Controller.collect(),
      statValue4: statValue4Controller.collect(),
      statType5: statType5Controller.collect(),
      statValue5: statValue5Controller.collect(),
      statType6: statType6Controller.collect(),
      statValue6: statValue6Controller.collect(),
      statType7: statType7Controller.collect(),
      statValue7: statValue7Controller.collect(),
      statType8: statType8Controller.collect(),
      statValue8: statValue8Controller.collect(),
      statType9: statType9Controller.collect(),
      statValue9: statValue9Controller.collect(),
      statType10: statType10Controller.collect(),
      statValue10: statValue10Controller.collect(),

      /// Card 7: Resistances
      holyRes: holyResController.collect(),
      fireRes: fireResController.collect(),
      natureRes: natureResController.collect(),
      shadowRes: shadowResController.collect(),
      frostRes: frostResController.collect(),
      arcaneRes: arcaneResController.collect(),

      /// Card 8: Spells (5 slots)
      spellId1: spellId1Controller.collect(),
      spellTrigger1: spellTrigger1Controller.collect(),
      spellCharges1: spellCharge1Controller.collect(),
      spellPpmRate1: spellPpmRate1Controller.collect(),
      spellCooldown1: spellCooldown1Controller.collect(),
      spellCategory1: spellCategory1Controller.collect(),
      spellCategoryCooldown1: spellCategoryCooldown1Controller.collect(),
      spellId2: spellId2Controller.collect(),
      spellTrigger2: spellTrigger2Controller.collect(),
      spellCharges2: spellCharge2Controller.collect(),
      spellPpmRate2: spellPpmRate2Controller.collect(),
      spellCooldown2: spellCooldown2Controller.collect(),
      spellCategory2: spellCategory2Controller.collect(),
      spellCategoryCooldown2: spellCategoryCooldown2Controller.collect(),
      spellId3: spellId3Controller.collect(),
      spellTrigger3: spellTrigger3Controller.collect(),
      spellCharges3: spellCharge3Controller.collect(),
      spellPpmRate3: spellPpmRate3Controller.collect(),
      spellCooldown3: spellCooldown3Controller.collect(),
      spellCategory3: spellCategory3Controller.collect(),
      spellCategoryCooldown3: spellCategoryCooldown3Controller.collect(),
      spellId4: spellId4Controller.collect(),
      spellTrigger4: spellTrigger4Controller.collect(),
      spellCharges4: spellCharge4Controller.collect(),
      spellPpmRate4: spellPpmRate4Controller.collect(),
      spellCooldown4: spellCooldown4Controller.collect(),
      spellCategory4: spellCategory4Controller.collect(),
      spellCategoryCooldown4: spellCategoryCooldown4Controller.collect(),
      spellId5: spellId5Controller.collect(),
      spellTrigger5: spellTrigger5Controller.collect(),
      spellCharges5: spellCharge5Controller.collect(),
      spellPpmRate5: spellPpmRate5Controller.collect(),
      spellCooldown5: spellCooldown5Controller.collect(),
      spellCategory5: spellCategory5Controller.collect(),
      spellCategoryCooldown5: spellCategoryCooldown5Controller.collect(),

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
      socketColor1: socketColor1Controller.collect(),
      socketContent1: socketContent1Controller.collect(),
      socketColor2: socketColor2Controller.collect(),
      socketContent2: socketContent2Controller.collect(),
      socketColor3: socketColor3Controller.collect(),
      socketContent3: socketContent3Controller.collect(),

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
    statType1Controller.init(template.statType1);
    statValue1Controller.init(template.statValue1);
    statType2Controller.init(template.statType2);
    statValue2Controller.init(template.statValue2);
    statType3Controller.init(template.statType3);
    statValue3Controller.init(template.statValue3);
    statType4Controller.init(template.statType4);
    statValue4Controller.init(template.statValue4);
    statType5Controller.init(template.statType5);
    statValue5Controller.init(template.statValue5);
    statType6Controller.init(template.statType6);
    statValue6Controller.init(template.statValue6);
    statType7Controller.init(template.statType7);
    statValue7Controller.init(template.statValue7);
    statType8Controller.init(template.statType8);
    statValue8Controller.init(template.statValue8);
    statType9Controller.init(template.statType9);
    statValue9Controller.init(template.statValue9);
    statType10Controller.init(template.statType10);
    statValue10Controller.init(template.statValue10);

    /// Card 7: Resistances
    holyResController.init(template.holyRes);
    fireResController.init(template.fireRes);
    natureResController.init(template.natureRes);
    shadowResController.init(template.shadowRes);
    frostResController.init(template.frostRes);
    arcaneResController.init(template.arcaneRes);

    /// Card 8: Spells (5 slots)
    spellId1Controller.init(template.spellId1);
    spellTrigger1Controller.init(template.spellTrigger1);
    spellCharge1Controller.init(template.spellCharges1);
    spellPpmRate1Controller.init(template.spellPpmRate1);
    spellCooldown1Controller.init(template.spellCooldown1);
    spellCategory1Controller.init(template.spellCategory1);
    spellCategoryCooldown1Controller.init(template.spellCategoryCooldown1);
    spellId2Controller.init(template.spellId2);
    spellTrigger2Controller.init(template.spellTrigger2);
    spellCharge2Controller.init(template.spellCharges2);
    spellPpmRate2Controller.init(template.spellPpmRate2);
    spellCooldown2Controller.init(template.spellCooldown2);
    spellCategory2Controller.init(template.spellCategory2);
    spellCategoryCooldown2Controller.init(template.spellCategoryCooldown2);
    spellId3Controller.init(template.spellId3);
    spellTrigger3Controller.init(template.spellTrigger3);
    spellCharge3Controller.init(template.spellCharges3);
    spellPpmRate3Controller.init(template.spellPpmRate3);
    spellCooldown3Controller.init(template.spellCooldown3);
    spellCategory3Controller.init(template.spellCategory3);
    spellCategoryCooldown3Controller.init(template.spellCategoryCooldown3);
    spellId4Controller.init(template.spellId4);
    spellTrigger4Controller.init(template.spellTrigger4);
    spellCharge4Controller.init(template.spellCharges4);
    spellPpmRate4Controller.init(template.spellPpmRate4);
    spellCooldown4Controller.init(template.spellCooldown4);
    spellCategory4Controller.init(template.spellCategory4);
    spellCategoryCooldown4Controller.init(template.spellCategoryCooldown4);
    spellId5Controller.init(template.spellId5);
    spellTrigger5Controller.init(template.spellTrigger5);
    spellCharge5Controller.init(template.spellCharges5);
    spellPpmRate5Controller.init(template.spellPpmRate5);
    spellCooldown5Controller.init(template.spellCooldown5);
    spellCategory5Controller.init(template.spellCategory5);
    spellCategoryCooldown5Controller.init(template.spellCategoryCooldown5);

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
    socketColor1Controller.init(template.socketColor1);
    socketContent1Controller.init(template.socketContent1);
    socketColor2Controller.init(template.socketColor2);
    socketContent2Controller.init(template.socketContent2);
    socketColor3Controller.init(template.socketColor3);
    socketContent3Controller.init(template.socketContent3);

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

  void _logActivity(ActivityActionType action, ItemTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'item_template',
      actionType: action,
      entityName: t.name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  String _labelFor(ItemTemplateEntity template) {
    return template.name.isNotEmpty ? template.name : '物品 #${template.entry}';
  }
}
