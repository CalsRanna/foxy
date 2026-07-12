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

class ItemTemplateDetailViewModel {
  final _repository = GetIt.instance.get<ItemTemplateRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Card 1: Basic Info
  final entryController = IntFieldController();
  final nameController = StringFieldController();
  final descriptionController = StringFieldController();
  final qualityController = SelectFieldController<int>(fallback: 0);
  final classNameController = SelectFieldController<int>(fallback: 0);
  final subclassController = SelectFieldController<int>(fallback: 0);
  final soundOverrideSubclassController = IntFieldController();
  final materialController = SelectFieldController<int>(fallback: 0);
  final displayIdController = IntFieldController();
  final inventoryTypeController = SelectFieldController<int>(fallback: 0);
  final sheathController = SelectFieldController<int>(fallback: 0);

  /// Card 2: Set/Pricing/Container/Misc
  final bondingController = SelectFieldController<int>(fallback: 0);
  final itemsetController = IntFieldController();
  final randomPropertyController = IntFieldController();
  final randomSuffixController = IntFieldController();
  final maxDurabilityController = IntFieldController();
  final buyPriceController = IntFieldController();
  final sellPriceController = IntFieldController();
  final buyCountController = IntFieldController();
  final maxcountController = IntFieldController();
  final stackableController = IntFieldController();
  final totemCategoryController = IntFieldController();
  final foodTypeController = SelectFieldController<int>(fallback: 0);
  final bagFamilyController = FlagFieldController();
  final containerSlotsController = IntFieldController();
  final itemLimitCategoryController = IntFieldController();
  final startquestController = IntFieldController();
  final durationController = IntFieldController();
  final disenchantIdController = IntFieldController();
  final minMoneyLootController = IntFieldController();
  final maxMoneyLootController = IntFieldController();

  /// Card 3: Flags
  final flagsController = FlagFieldController();
  final flagsExtraController = FlagFieldController();
  final flagsCustomController = FlagFieldController();

  /// Card 4: Damage/Armor
  final delayController = IntFieldController();
  final rangedModRangeController = IntFieldController();
  final armorDamageModifierController = DoubleFieldController();
  final dmgType1Controller = SelectFieldController<int>(fallback: 0);
  final dmgMin1Controller = DoubleFieldController();
  final dmgMax1Controller = DoubleFieldController();
  final dmgType2Controller = SelectFieldController<int>(fallback: 0);
  final dmgMin2Controller = DoubleFieldController();
  final dmgMax2Controller = DoubleFieldController();
  final ammoTypeController = SelectFieldController<int>(fallback: 0);
  final armorController = IntFieldController();
  final blockController = IntFieldController();

  /// Card 5: Scaling Stats
  final scalingStatDistributionController = IntFieldController();
  final scalingStatValueController = FlagFieldController();

  /// Card 6: Stats (dynamic)
  final statsCountController = IntFieldController();
  final List<SelectFieldController<int>> statTypeControllers = List.generate(
    10,
    (_) => SelectFieldController<int>(fallback: 0),
  );
  final List<IntFieldController> statValues = List.generate(
    10,
    (_) => IntFieldController(),
  );

  /// Card 7: Resistances
  final holyResController = IntFieldController();
  final fireResController = IntFieldController();
  final natureResController = IntFieldController();
  final shadowResController = IntFieldController();
  final frostResController = IntFieldController();
  final arcaneResController = IntFieldController();

  /// Card 8: Spells (5 slots)
  final List<IntFieldController> spellIds = List.generate(
    5,
    (_) => IntFieldController(),
  );
  final List<SelectFieldController<int>> spellTriggerControllers =
      List.generate(5, (_) => SelectFieldController<int>(fallback: 0));
  final List<IntFieldController> spellCharges = List.generate(
    5,
    (_) => IntFieldController(),
  );
  final List<DoubleFieldController> spellPpmRates = List.generate(
    5,
    (_) => DoubleFieldController(),
  );
  final List<IntFieldController> spellCooldowns = List.generate(
    5,
    (_) => IntFieldController(),
  );
  final List<IntFieldController> spellCategories = List.generate(
    5,
    (_) => IntFieldController(),
  );
  final List<IntFieldController> spellCategoryCooldowns = List.generate(
    5,
    (_) => IntFieldController(),
  );

  /// Card 9: Requirements
  final allowableClassController = FlagFieldController();
  final allowableRaceController = FlagFieldController();
  final itemLevelController = IntFieldController();
  final requiredLevelController = IntFieldController();
  final requiredSkillController = IntFieldController();
  final requiredSkillRankController = IntFieldController();
  final requiredSpellController = IntFieldController();
  final requiredHonorRankController = IntFieldController();
  final requiredCityRankController = IntFieldController();
  final requiredReputationFactionController = IntFieldController();
  final requiredReputationRankController = IntFieldController();
  final requiredDisenchantSkillController = IntFieldController();

  /// Card 10: Socket/Gem
  final lockidController = IntFieldController();
  final gemPropertiesController = IntFieldController();
  final socketBonusController = IntFieldController();
  final List<SelectFieldController<int>> socketColorControllers = List.generate(
    3,
    (_) => SelectFieldController<int>(fallback: 0),
  );
  final List<IntFieldController> socketContents = List.generate(
    3,
    (_) => IntFieldController(),
  );

  /// Card 11: Page/Misc
  final mapIdController = IntFieldController();
  final areaController = IntFieldController();
  final holidayIdController = IntFieldController();
  final pageTextController = IntFieldController();
  final pageMaterialController = SelectFieldController<int>(fallback: 0);
  final languageIdController = SelectFieldController<int>(fallback: 0);
  final scriptNameController = StringFieldController();
  final verifiedBuildController = IntFieldController();

  late final _controllers = <FieldController>[
    entryController,
    nameController,
    descriptionController,
    qualityController,
    classNameController,
    subclassController,
    soundOverrideSubclassController,
    materialController,
    displayIdController,
    inventoryTypeController,
    sheathController,
    bondingController,
    itemsetController,
    randomPropertyController,
    randomSuffixController,
    maxDurabilityController,
    buyPriceController,
    sellPriceController,
    buyCountController,
    maxcountController,
    stackableController,
    totemCategoryController,
    foodTypeController,
    bagFamilyController,
    containerSlotsController,
    itemLimitCategoryController,
    startquestController,
    durationController,
    disenchantIdController,
    minMoneyLootController,
    maxMoneyLootController,
    flagsController,
    flagsExtraController,
    flagsCustomController,
    delayController,
    rangedModRangeController,
    armorDamageModifierController,
    dmgType1Controller,
    dmgMin1Controller,
    dmgMax1Controller,
    dmgType2Controller,
    dmgMin2Controller,
    dmgMax2Controller,
    ammoTypeController,
    armorController,
    blockController,
    scalingStatDistributionController,
    scalingStatValueController,
    statsCountController,
    ...statTypeControllers,
    ...statValues,
    holyResController,
    fireResController,
    natureResController,
    shadowResController,
    frostResController,
    arcaneResController,
    ...spellIds,
    ...spellTriggerControllers,
    ...spellCharges,
    ...spellPpmRates,
    ...spellCooldowns,
    ...spellCategories,
    ...spellCategoryCooldowns,
    allowableClassController,
    allowableRaceController,
    itemLevelController,
    requiredLevelController,
    requiredSkillController,
    requiredSkillRankController,
    requiredSpellController,
    requiredHonorRankController,
    requiredCityRankController,
    requiredReputationFactionController,
    requiredReputationRankController,
    requiredDisenchantSkillController,
    lockidController,
    gemPropertiesController,
    socketBonusController,
    ...socketColorControllers,
    ...socketContents,
    mapIdController,
    areaController,
    holidayIdController,
    pageTextController,
    pageMaterialController,
    languageIdController,
    scriptNameController,
    verifiedBuildController,
  ];

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

    /// Card 6: Stats (dynamic)
    statsCountController.init(template.statsCount);
    for (var i = 0; i < 10; i++) {
      statTypeControllers[i].init(template.statTypes[i]);
      statValues[i].init(template.statValues[i]);
    }

    /// Card 7: Resistances
    holyResController.init(template.holyRes);
    fireResController.init(template.fireRes);
    natureResController.init(template.natureRes);
    shadowResController.init(template.shadowRes);
    frostResController.init(template.frostRes);
    arcaneResController.init(template.arcaneRes);

    /// Card 8: Spells (5 slots)
    for (var i = 0; i < 5; i++) {
      spellIds[i].init(template.spellIds[i]);
      spellTriggerControllers[i].init(template.spellTriggers[i]);
      spellCharges[i].init(template.spellCharges[i]);
      spellPpmRates[i].init(template.spellPpmRates[i]);
      spellCooldowns[i].init(template.spellCooldowns[i]);
      spellCategories[i].init(template.spellCategories[i]);
      spellCategoryCooldowns[i].init(template.spellCategoryCooldowns[i]);
    }

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
    for (var i = 0; i < 3; i++) {
      socketColorControllers[i].init(template.socketColors[i]);
      socketContents[i].init(template.socketContents[i]);
    }

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

      /// Card 6: Stats (dynamic)
      statsCount: statsCountController.collect(),
      statTypes: [
        for (var i = 0; i < 10; i++) statTypeControllers[i].collect(),
      ],
      statValues: [for (var i = 0; i < 10; i++) statValues[i].collect()],

      /// Card 7: Resistances
      holyRes: holyResController.collect(),
      fireRes: fireResController.collect(),
      natureRes: natureResController.collect(),
      shadowRes: shadowResController.collect(),
      frostRes: frostResController.collect(),
      arcaneRes: arcaneResController.collect(),

      /// Card 8: Spells (5 slots)
      spellIds: [for (var i = 0; i < 5; i++) spellIds[i].collect()],
      spellTriggers: [
        for (var i = 0; i < 5; i++) spellTriggerControllers[i].collect(),
      ],
      spellCharges: [for (var i = 0; i < 5; i++) spellCharges[i].collect()],
      spellPpmRates: [for (var i = 0; i < 5; i++) spellPpmRates[i].collect()],
      spellCooldowns: [for (var i = 0; i < 5; i++) spellCooldowns[i].collect()],
      spellCategories: [
        for (var i = 0; i < 5; i++) spellCategories[i].collect(),
      ],
      spellCategoryCooldowns: [
        for (var i = 0; i < 5; i++) spellCategoryCooldowns[i].collect(),
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
        for (var i = 0; i < 3; i++) socketColorControllers[i].collect(),
      ],
      socketContents: [for (var i = 0; i < 3; i++) socketContents[i].collect()],

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
    for (final controller in _controllers) {
      controller.dispose();
    }
  }
}
