import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
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
  final template = signal(ItemTemplateEntity());
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
    try {
      final repository = ItemTemplateRepository();
      template.value = await repository.getItemTemplate(entry);
      _initControllers(template.value);
      statsCount.value = template.value.statsCount;
    } catch (e, s) {
      LoggerUtil.instance.e('加载物品模板(entry=$entry)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ItemTemplateEntity template) {
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

  ItemTemplateEntity _collectFromControllers() {
    return ItemTemplateEntity(
      /// Card 1: Basic Info
      entry: _parseInt(entryController.text),
      name: nameController.text,
      description: descriptionController.text,
      quality: _getSelectValue(qualityController),
      className: _getSelectValue(classNameController),
      subclass: _getSelectValue(subclassController),
      soundOverrideSubclass: _parseInt(soundOverrideSubclassController.text),
      material: _getSelectValue(materialController),
      displayId: _parseInt(displayIdController.text),
      inventoryType: _getSelectValue(inventoryTypeController),
      sheath: _getSelectValue(sheathController),

      /// Card 2: Set/Pricing/Container/Misc
      bonding: _getSelectValue(bondingController),
      itemset: _parseInt(itemsetController.text),
      randomProperty: _parseInt(randomPropertyController.text),
      randomSuffix: _parseInt(randomSuffixController.text),
      maxDurability: _parseInt(maxDurabilityController.text),
      buyPrice: _parseInt(buyPriceController.text),
      sellPrice: _parseInt(sellPriceController.text),
      buyCount: _parseInt(buyCountController.text),
      maxcount: _parseInt(maxcountController.text),
      stackable: _parseInt(stackableController.text),
      totemCategory: _parseInt(totemCategoryController.text),
      foodType: _getSelectValue(foodTypeController),
      bagFamily: _parseInt(bagFamilyController.text),
      containerSlots: _parseInt(containerSlotsController.text),
      itemLimitCategory: _parseInt(itemLimitCategoryController.text),
      startquest: _parseInt(startquestController.text),
      duration: _parseInt(durationController.text),
      disenchantId: _parseInt(disenchantIdController.text),
      minMoneyLoot: _parseInt(minMoneyLootController.text),
      maxMoneyLoot: _parseInt(maxMoneyLootController.text),

      /// Card 3: Flags
      flags: _parseInt(flagsController.text),
      flagsExtra: _parseInt(flagsExtraController.text),
      flagsCustom: _parseInt(flagsCustomController.text),

      /// Card 4: Damage/Armor
      delay: _parseInt(delayController.text),
      rangedModRange: _parseInt(rangedModRangeController.text),
      armorDamageModifier: _parseDouble(armorDamageModifierController.text),
      dmgType1: _getSelectValue(dmgType1Controller),
      dmgMin1: _parseDouble(dmgMin1Controller.text),
      dmgMax1: _parseDouble(dmgMax1Controller.text),
      dmgType2: _getSelectValue(dmgType2Controller),
      dmgMin2: _parseDouble(dmgMin2Controller.text),
      dmgMax2: _parseDouble(dmgMax2Controller.text),
      ammoType: _getSelectValue(ammoTypeController),
      armor: _parseInt(armorController.text),
      block: _parseInt(blockController.text),

      /// Card 5: Scaling Stats
      scalingStatDistribution: _parseInt(
        scalingStatDistributionController.text,
      ),
      scalingStatValue: _parseInt(scalingStatValueController.text),

      /// Card 6: Stats (dynamic)
      statsCount: _parseInt(statsCountController.text),
      statTypes: [
        for (var i = 0; i < 10; i++) _getSelectValue(statTypeControllers[i]),
      ],
      statValues: [
        for (var i = 0; i < 10; i++) _parseInt(statValueControllers[i].text),
      ],

      /// Card 7: Resistances
      holyRes: _parseInt(holyResController.text),
      fireRes: _parseInt(fireResController.text),
      natureRes: _parseInt(natureResController.text),
      shadowRes: _parseInt(shadowResController.text),
      frostRes: _parseInt(frostResController.text),
      arcaneRes: _parseInt(arcaneResController.text),

      /// Card 8: Spells (5 slots)
      spellIds: [
        for (var i = 0; i < 5; i++) _parseInt(spellIdControllers[i].text),
      ],
      spellTriggers: [
        for (var i = 0; i < 5; i++) _getSelectValue(spellTriggerControllers[i]),
      ],
      spellCharges: [
        for (var i = 0; i < 5; i++) _parseInt(spellChargeControllers[i].text),
      ],
      spellPpmRates: [
        for (var i = 0; i < 5; i++)
          _parseDouble(spellPpmRateControllers[i].text),
      ],
      spellCooldowns: [
        for (var i = 0; i < 5; i++) _parseInt(spellCooldownControllers[i].text),
      ],
      spellCategories: [
        for (var i = 0; i < 5; i++) _parseInt(spellCategoryControllers[i].text),
      ],
      spellCategoryCooldowns: [
        for (var i = 0; i < 5; i++)
          _parseInt(spellCategoryCooldownControllers[i].text),
      ],

      /// Card 9: Requirements
      allowableClass: _parseInt(allowableClassController.text),
      allowableRace: _parseInt(allowableRaceController.text),
      itemLevel: _parseInt(itemLevelController.text),
      requiredLevel: _parseInt(requiredLevelController.text),
      requiredSkill: _parseInt(requiredSkillController.text),
      requiredSkillRank: _parseInt(requiredSkillRankController.text),
      requiredSpell: _parseInt(requiredSpellController.text),
      requiredHonorRank: _parseInt(requiredHonorRankController.text),
      requiredCityRank: _parseInt(requiredCityRankController.text),
      requiredReputationFaction: _parseInt(
        requiredReputationFactionController.text,
      ),
      requiredReputationRank: _parseInt(requiredReputationRankController.text),
      requiredDisenchantSkill: _parseInt(
        requiredDisenchantSkillController.text,
      ),

      /// Card 10: Socket/Gem
      lockid: _parseInt(lockidController.text),
      gemProperties: _parseInt(gemPropertiesController.text),
      socketBonus: _parseInt(socketBonusController.text),
      socketColors: [
        for (var i = 0; i < 3; i++) _getSelectValue(socketColorControllers[i]),
      ],
      socketContents: [
        for (var i = 0; i < 3; i++) _parseInt(socketContentControllers[i].text),
      ],

      /// Card 11: Page/Misc
      mapId: _parseInt(mapIdController.text),
      area: _parseInt(areaController.text),
      holidayId: _parseInt(holidayIdController.text),
      pageText: _parseInt(pageTextController.text),
      pageMaterial: _getSelectValue(pageMaterialController),
      languageId: _getSelectValue(languageIdController),
      scriptName: scriptNameController.text,
      verifiedBuild: _parseInt(verifiedBuildController.text),
    );
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
      _logActivity(
        t.entry == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
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

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  double _parseDouble(String text) {
    if (text.isEmpty) return 0.0;
    final value = double.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;

  void _logActivity(ActivityActionType action, ItemTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'item_template',
      actionType: action,
      entityId: t.entry,
      entityName: t.name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

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
