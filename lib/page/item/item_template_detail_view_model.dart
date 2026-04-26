import 'package:flutter/widgets.dart';
import 'package:foxy/model/item_template.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemTemplateDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Card 1: Basic Info
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final qualityController = ShadSelectController<int>();
  final classNameController = ShadSelectController<int>();
  final subclassController = ShadSelectController<int>();
  final soundOverrideSubclassController = TextEditingController();
  final materialController = ShadSelectController<int>();
  final displayIdController = TextEditingController();
  final inventoryTypeController = ShadSelectController<int>();
  final sheathController = ShadSelectController<int>();

  /// Card 2: Set/Pricing/Container/Misc
  final bondingController = ShadSelectController<int>();
  final itemsetController = TextEditingController();
  final randomPropertyController = TextEditingController();
  final randomSuffixController = TextEditingController();
  final maxDurabilityController = TextEditingController();
  final buyPriceController = TextEditingController();
  final sellPriceController = TextEditingController();
  final buyCountController = TextEditingController();
  final maxcountController = TextEditingController();
  final stackableController = TextEditingController();
  final totemCategoryController = TextEditingController();
  final foodTypeController = ShadSelectController<int>();
  final bagFamilyController = TextEditingController();
  final containerSlotsController = TextEditingController();
  final itemLimitCategoryController = TextEditingController();
  final startquestController = TextEditingController();
  final durationController = TextEditingController();
  final disenchantIdController = TextEditingController();
  final minMoneyLootController = TextEditingController();
  final maxMoneyLootController = TextEditingController();

  /// Card 3: Flags
  final flagsController = TextEditingController();
  final flagsExtraController = TextEditingController();
  final flagsCustomController = TextEditingController();

  /// Card 4: Damage/Armor
  final delayController = TextEditingController();
  final rangedModRangeController = TextEditingController();
  final armorDamageModifierController = TextEditingController();
  final dmgType1Controller = ShadSelectController<int>();
  final dmgMin1Controller = TextEditingController();
  final dmgMax1Controller = TextEditingController();
  final dmgType2Controller = ShadSelectController<int>();
  final dmgMin2Controller = TextEditingController();
  final dmgMax2Controller = TextEditingController();
  final ammoTypeController = ShadSelectController<int>();
  final armorController = TextEditingController();
  final blockController = TextEditingController();

  /// Card 5: Scaling Stats
  final scalingStatDistributionController = TextEditingController();
  final scalingStatValueController = TextEditingController();

  /// Card 6: Stats (dynamic)
  final statsCountController = TextEditingController();
  final List<ShadSelectController<int>> statTypeControllers = List.generate(
    10,
    (_) => ShadSelectController<int>(),
  );
  final List<TextEditingController> statValueControllers = List.generate(
    10,
    (_) => TextEditingController(),
  );

  /// Card 7: Resistances
  final holyResController = TextEditingController();
  final fireResController = TextEditingController();
  final natureResController = TextEditingController();
  final shadowResController = TextEditingController();
  final frostResController = TextEditingController();
  final arcaneResController = TextEditingController();

  /// Card 8: Spells (5 slots)
  final List<TextEditingController> spellIdControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<ShadSelectController<int>> spellTriggerControllers = List.generate(
    5,
    (_) => ShadSelectController<int>(),
  );
  final List<TextEditingController> spellChargeControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> spellPpmRateControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> spellCooldownControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> spellCategoryControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> spellCategoryCooldownControllers =
      List.generate(5, (_) => TextEditingController());

  /// Card 9: Requirements
  final allowableClassController = TextEditingController();
  final allowableRaceController = TextEditingController();
  final itemLevelController = TextEditingController();
  final requiredLevelController = TextEditingController();
  final requiredSkillController = TextEditingController();
  final requiredSkillRankController = TextEditingController();
  final requiredSpellController = TextEditingController();
  final requiredHonorRankController = TextEditingController();
  final requiredCityRankController = TextEditingController();
  final requiredReputationFactionController = TextEditingController();
  final requiredReputationRankController = TextEditingController();
  final requiredDisenchantSkillController = TextEditingController();

  /// Card 10: Socket/Gem
  final lockidController = TextEditingController();
  final gemPropertiesController = TextEditingController();
  final socketBonusController = TextEditingController();
  final List<ShadSelectController<int>> socketColorControllers = List.generate(
    3,
    (_) => ShadSelectController<int>(),
  );
  final List<TextEditingController> socketContentControllers = List.generate(
    3,
    (_) => TextEditingController(),
  );

  /// Card 11: Page/Misc
  final mapIdController = TextEditingController();
  final areaController = TextEditingController();
  final holidayIdController = TextEditingController();
  final pageTextController = TextEditingController();
  final pageMaterialController = ShadSelectController<int>();
  final languageIdController = ShadSelectController<int>();
  final scriptNameController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  /// Signals
  final entry = signal(0);
  final template = signal(ItemTemplate());
  final statsCount = signal(0);

  /// Computed conditions
  bool get hasEnchantment =>
      template.value.randomProperty != 0 || template.value.randomSuffix != 0;
  bool get hasItemLoot => (template.value.flags & 4) != 0;
  bool get hasDisenchantLoot => template.value.disenchantId != 0;
  bool get hasProspectingLoot => (template.value.flags & 262144) != 0;
  bool get hasMillingLoot => (template.value.flags & 536870912) != 0;

  Future<void> initSignals({int? entry}) async {
    if (entry == null || entry <= 0) return;
    final repository = ItemTemplateRepository();
    template.value = await repository.getItemTemplate(entry);
    _initControllers(template.value);
    statsCount.value = template.value.statsCount;
  }

  void _initControllers(ItemTemplate template) {
    /// Card 1: Basic Info
    entryController.text = template.entry.toString();
    nameController.text = template.name;
    descriptionController.text = template.description;
    qualityController.value = {template.quality};
    classNameController.value = {template.className};
    subclassController.value = {template.subclass};
    soundOverrideSubclassController.text = template.soundOverrideSubclass
        .toString();
    materialController.value = {template.material};
    displayIdController.text = template.displayId.toString();
    inventoryTypeController.value = {template.inventoryType};
    sheathController.value = {template.sheath};

    /// Card 2: Set/Pricing/Container/Misc
    bondingController.value = {template.bonding};
    itemsetController.text = template.itemset.toString();
    randomPropertyController.text = template.randomProperty.toString();
    randomSuffixController.text = template.randomSuffix.toString();
    maxDurabilityController.text = template.maxDurability.toString();
    buyPriceController.text = template.buyPrice.toString();
    sellPriceController.text = template.sellPrice.toString();
    buyCountController.text = template.buyCount.toString();
    maxcountController.text = template.maxcount.toString();
    stackableController.text = template.stackable.toString();
    totemCategoryController.text = template.totemCategory.toString();
    foodTypeController.value = {template.foodType};
    bagFamilyController.text = template.bagFamily.toString();
    containerSlotsController.text = template.containerSlots.toString();
    itemLimitCategoryController.text = template.itemLimitCategory.toString();
    startquestController.text = template.startquest.toString();
    durationController.text = template.duration.toString();
    disenchantIdController.text = template.disenchantId.toString();
    minMoneyLootController.text = template.minMoneyLoot.toString();
    maxMoneyLootController.text = template.maxMoneyLoot.toString();

    /// Card 3: Flags
    flagsController.text = template.flags.toString();
    flagsExtraController.text = template.flagsExtra.toString();
    flagsCustomController.text = template.flagsCustom.toString();

    /// Card 4: Damage/Armor
    delayController.text = template.delay.toString();
    rangedModRangeController.text = template.rangedModRange.toString();
    armorDamageModifierController.text = template.armorDamageModifier
        .toString();
    dmgType1Controller.value = {template.dmgType1};
    dmgMin1Controller.text = template.dmgMin1.toString();
    dmgMax1Controller.text = template.dmgMax1.toString();
    dmgType2Controller.value = {template.dmgType2};
    dmgMin2Controller.text = template.dmgMin2.toString();
    dmgMax2Controller.text = template.dmgMax2.toString();
    ammoTypeController.value = {template.ammoType};
    armorController.text = template.armor.toString();
    blockController.text = template.block.toString();

    /// Card 5: Scaling Stats
    scalingStatDistributionController.text = template.scalingStatDistribution
        .toString();
    scalingStatValueController.text = template.scalingStatValue.toString();

    /// Card 6: Stats (dynamic)
    statsCountController.text = template.statsCount.toString();
    statsCount.value = template.statsCount;
    for (var i = 0; i < 10; i++) {
      statTypeControllers[i].value = {template.statTypes[i]};
      statValueControllers[i].text = template.statValues[i].toString();
    }

    /// Card 7: Resistances
    holyResController.text = template.holyRes.toString();
    fireResController.text = template.fireRes.toString();
    natureResController.text = template.natureRes.toString();
    shadowResController.text = template.shadowRes.toString();
    frostResController.text = template.frostRes.toString();
    arcaneResController.text = template.arcaneRes.toString();

    /// Card 8: Spells (5 slots)
    for (var i = 0; i < 5; i++) {
      spellIdControllers[i].text = template.spellIds[i].toString();
      spellTriggerControllers[i].value = {template.spellTriggers[i]};
      spellChargeControllers[i].text = template.spellCharges[i].toString();
      spellPpmRateControllers[i].text = template.spellPpmRates[i].toString();
      spellCooldownControllers[i].text = template.spellCooldowns[i].toString();
      spellCategoryControllers[i].text = template.spellCategories[i].toString();
      spellCategoryCooldownControllers[i].text = template
          .spellCategoryCooldowns[i]
          .toString();
    }

    /// Card 9: Requirements
    allowableClassController.text = template.allowableClass.toString();
    allowableRaceController.text = template.allowableRace.toString();
    itemLevelController.text = template.itemLevel.toString();
    requiredLevelController.text = template.requiredLevel.toString();
    requiredSkillController.text = template.requiredSkill.toString();
    requiredSkillRankController.text = template.requiredSkillRank.toString();
    requiredSpellController.text = template.requiredSpell.toString();
    requiredHonorRankController.text = template.requiredHonorRank.toString();
    requiredCityRankController.text = template.requiredCityRank.toString();
    requiredReputationFactionController.text = template
        .requiredReputationFaction
        .toString();
    requiredReputationRankController.text = template.requiredReputationRank
        .toString();
    requiredDisenchantSkillController.text = template.requiredDisenchantSkill
        .toString();

    /// Card 10: Socket/Gem
    lockidController.text = template.lockid.toString();
    gemPropertiesController.text = template.gemProperties.toString();
    socketBonusController.text = template.socketBonus.toString();
    for (var i = 0; i < 3; i++) {
      socketColorControllers[i].value = {template.socketColors[i]};
      socketContentControllers[i].text = template.socketContents[i].toString();
    }

    /// Card 11: Page/Misc
    mapIdController.text = template.mapId.toString();
    areaController.text = template.area.toString();
    holidayIdController.text = template.holidayId.toString();
    pageTextController.text = template.pageText.toString();
    pageMaterialController.value = {template.pageMaterial};
    languageIdController.value = {template.languageId};
    scriptNameController.text = template.scriptName;
    verifiedBuildController.text = template.verifiedBuild.toString();
  }

  ItemTemplate _collectFromControllers() {
    final t = ItemTemplate();

    /// Card 1: Basic Info
    t.entry = _parseInt(entryController.text);
    t.name = nameController.text;
    t.description = descriptionController.text;
    t.quality = _getSelectValue(qualityController);
    t.className = _getSelectValue(classNameController);
    t.subclass = _getSelectValue(subclassController);
    t.soundOverrideSubclass = _parseInt(soundOverrideSubclassController.text);
    t.material = _getSelectValue(materialController);
    t.displayId = _parseInt(displayIdController.text);
    t.inventoryType = _getSelectValue(inventoryTypeController);
    t.sheath = _getSelectValue(sheathController);

    /// Card 2: Set/Pricing/Container/Misc
    t.bonding = _getSelectValue(bondingController);
    t.itemset = _parseInt(itemsetController.text);
    t.randomProperty = _parseInt(randomPropertyController.text);
    t.randomSuffix = _parseInt(randomSuffixController.text);
    t.maxDurability = _parseInt(maxDurabilityController.text);
    t.buyPrice = _parseInt(buyPriceController.text);
    t.sellPrice = _parseInt(sellPriceController.text);
    t.buyCount = _parseInt(buyCountController.text);
    t.maxcount = _parseInt(maxcountController.text);
    t.stackable = _parseInt(stackableController.text);
    t.totemCategory = _parseInt(totemCategoryController.text);
    t.foodType = _getSelectValue(foodTypeController);
    t.bagFamily = _parseInt(bagFamilyController.text);
    t.containerSlots = _parseInt(containerSlotsController.text);
    t.itemLimitCategory = _parseInt(itemLimitCategoryController.text);
    t.startquest = _parseInt(startquestController.text);
    t.duration = _parseInt(durationController.text);
    t.disenchantId = _parseInt(disenchantIdController.text);
    t.minMoneyLoot = _parseInt(minMoneyLootController.text);
    t.maxMoneyLoot = _parseInt(maxMoneyLootController.text);

    /// Card 3: Flags
    t.flags = _parseInt(flagsController.text);
    t.flagsExtra = _parseInt(flagsExtraController.text);
    t.flagsCustom = _parseInt(flagsCustomController.text);

    /// Card 4: Damage/Armor
    t.delay = _parseInt(delayController.text);
    t.rangedModRange = _parseInt(rangedModRangeController.text);
    t.armorDamageModifier = _parseDouble(armorDamageModifierController.text);
    t.dmgType1 = _getSelectValue(dmgType1Controller);
    t.dmgMin1 = _parseDouble(dmgMin1Controller.text);
    t.dmgMax1 = _parseDouble(dmgMax1Controller.text);
    t.dmgType2 = _getSelectValue(dmgType2Controller);
    t.dmgMin2 = _parseDouble(dmgMin2Controller.text);
    t.dmgMax2 = _parseDouble(dmgMax2Controller.text);
    t.ammoType = _getSelectValue(ammoTypeController);
    t.armor = _parseInt(armorController.text);
    t.block = _parseInt(blockController.text);

    /// Card 5: Scaling Stats
    t.scalingStatDistribution = _parseInt(
      scalingStatDistributionController.text,
    );
    t.scalingStatValue = _parseInt(scalingStatValueController.text);

    /// Card 6: Stats (dynamic)
    t.statsCount = _parseInt(statsCountController.text);
    for (var i = 0; i < 10; i++) {
      t.statTypes[i] = _getSelectValue(statTypeControllers[i]);
      t.statValues[i] = _parseInt(statValueControllers[i].text);
    }

    /// Card 7: Resistances
    t.holyRes = _parseInt(holyResController.text);
    t.fireRes = _parseInt(fireResController.text);
    t.natureRes = _parseInt(natureResController.text);
    t.shadowRes = _parseInt(shadowResController.text);
    t.frostRes = _parseInt(frostResController.text);
    t.arcaneRes = _parseInt(arcaneResController.text);

    /// Card 8: Spells (5 slots)
    for (var i = 0; i < 5; i++) {
      t.spellIds[i] = _parseInt(spellIdControllers[i].text);
      t.spellTriggers[i] = _getSelectValue(spellTriggerControllers[i]);
      t.spellCharges[i] = _parseInt(spellChargeControllers[i].text);
      t.spellPpmRates[i] = _parseDouble(spellPpmRateControllers[i].text);
      t.spellCooldowns[i] = _parseInt(spellCooldownControllers[i].text);
      t.spellCategories[i] = _parseInt(spellCategoryControllers[i].text);
      t.spellCategoryCooldowns[i] = _parseInt(
        spellCategoryCooldownControllers[i].text,
      );
    }

    /// Card 9: Requirements
    t.allowableClass = _parseInt(allowableClassController.text);
    t.allowableRace = _parseInt(allowableRaceController.text);
    t.itemLevel = _parseInt(itemLevelController.text);
    t.requiredLevel = _parseInt(requiredLevelController.text);
    t.requiredSkill = _parseInt(requiredSkillController.text);
    t.requiredSkillRank = _parseInt(requiredSkillRankController.text);
    t.requiredSpell = _parseInt(requiredSpellController.text);
    t.requiredHonorRank = _parseInt(requiredHonorRankController.text);
    t.requiredCityRank = _parseInt(requiredCityRankController.text);
    t.requiredReputationFaction = _parseInt(
      requiredReputationFactionController.text,
    );
    t.requiredReputationRank = _parseInt(requiredReputationRankController.text);
    t.requiredDisenchantSkill = _parseInt(
      requiredDisenchantSkillController.text,
    );

    /// Card 10: Socket/Gem
    t.lockid = _parseInt(lockidController.text);
    t.gemProperties = _parseInt(gemPropertiesController.text);
    t.socketBonus = _parseInt(socketBonusController.text);
    for (var i = 0; i < 3; i++) {
      t.socketColors[i] = _getSelectValue(socketColorControllers[i]);
      t.socketContents[i] = _parseInt(socketContentControllers[i].text);
    }

    /// Card 11: Page/Misc
    t.mapId = _parseInt(mapIdController.text);
    t.area = _parseInt(areaController.text);
    t.holidayId = _parseInt(holidayIdController.text);
    t.pageText = _parseInt(pageTextController.text);
    t.pageMaterial = _getSelectValue(pageMaterialController);
    t.languageId = _getSelectValue(languageIdController);
    t.scriptName = scriptNameController.text;
    t.verifiedBuild = _parseInt(verifiedBuildController.text);

    return t;
  }

  /// 保存模板到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = ItemTemplateRepository();
      if (t.entry == 0) {
        await repository.storeItemTemplate(t);
      } else {
        await repository.updateItemTemplate(t);
      }
      template.value = t;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('模板数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);
  double _parseDouble(String text) => text.isEmpty ? 0.0 : double.parse(text);
  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;

  void dispose() {
    /// Card 1: Basic Info
    entryController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    qualityController.dispose();
    classNameController.dispose();
    subclassController.dispose();
    soundOverrideSubclassController.dispose();
    materialController.dispose();
    displayIdController.dispose();
    inventoryTypeController.dispose();
    sheathController.dispose();

    /// Card 2: Set/Pricing/Container/Misc
    bondingController.dispose();
    itemsetController.dispose();
    randomPropertyController.dispose();
    randomSuffixController.dispose();
    maxDurabilityController.dispose();
    buyPriceController.dispose();
    sellPriceController.dispose();
    buyCountController.dispose();
    maxcountController.dispose();
    stackableController.dispose();
    totemCategoryController.dispose();
    foodTypeController.dispose();
    bagFamilyController.dispose();
    containerSlotsController.dispose();
    itemLimitCategoryController.dispose();
    startquestController.dispose();
    durationController.dispose();
    disenchantIdController.dispose();
    minMoneyLootController.dispose();
    maxMoneyLootController.dispose();

    /// Card 3: Flags
    flagsController.dispose();
    flagsExtraController.dispose();
    flagsCustomController.dispose();

    /// Card 4: Damage/Armor
    delayController.dispose();
    rangedModRangeController.dispose();
    armorDamageModifierController.dispose();
    dmgType1Controller.dispose();
    dmgMin1Controller.dispose();
    dmgMax1Controller.dispose();
    dmgType2Controller.dispose();
    dmgMin2Controller.dispose();
    dmgMax2Controller.dispose();
    ammoTypeController.dispose();
    armorController.dispose();
    blockController.dispose();

    /// Card 5: Scaling Stats
    scalingStatDistributionController.dispose();
    scalingStatValueController.dispose();

    /// Card 6: Stats (dynamic)
    statsCountController.dispose();
    for (var i = 0; i < 10; i++) {
      statTypeControllers[i].dispose();
      statValueControllers[i].dispose();
    }

    /// Card 7: Resistances
    holyResController.dispose();
    fireResController.dispose();
    natureResController.dispose();
    shadowResController.dispose();
    frostResController.dispose();
    arcaneResController.dispose();

    /// Card 8: Spells (5 slots)
    for (var i = 0; i < 5; i++) {
      spellIdControllers[i].dispose();
      spellTriggerControllers[i].dispose();
      spellChargeControllers[i].dispose();
      spellPpmRateControllers[i].dispose();
      spellCooldownControllers[i].dispose();
      spellCategoryControllers[i].dispose();
      spellCategoryCooldownControllers[i].dispose();
    }

    /// Card 9: Requirements
    allowableClassController.dispose();
    allowableRaceController.dispose();
    itemLevelController.dispose();
    requiredLevelController.dispose();
    requiredSkillController.dispose();
    requiredSkillRankController.dispose();
    requiredSpellController.dispose();
    requiredHonorRankController.dispose();
    requiredCityRankController.dispose();
    requiredReputationFactionController.dispose();
    requiredReputationRankController.dispose();
    requiredDisenchantSkillController.dispose();

    /// Card 10: Socket/Gem
    lockidController.dispose();
    gemPropertiesController.dispose();
    socketBonusController.dispose();
    for (var i = 0; i < 3; i++) {
      socketColorControllers[i].dispose();
      socketContentControllers[i].dispose();
    }

    /// Card 11: Page/Misc
    mapIdController.dispose();
    areaController.dispose();
    holidayIdController.dispose();
    pageTextController.dispose();
    pageMaterialController.dispose();
    languageIdController.dispose();
    scriptNameController.dispose();
    verifiedBuildController.dispose();
  }
}
