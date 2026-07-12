import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemTemplateDetailViewModel {
  final _repository = GetIt.instance.get<ItemTemplateRepository>();
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
  final List<TextEditingController> statValues = List.generate(
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
  final List<TextEditingController> spellIds = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<ShadSelectController<int>> spellTriggerControllers = List.generate(
    5,
    (_) => ShadSelectController<int>(),
  );
  final List<TextEditingController> spellCharges = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> spellPpmRates = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> spellCooldowns = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> spellCategories = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> spellCategoryCooldowns = List.generate(
    5,
    (_) => TextEditingController(),
  );

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
  final List<TextEditingController> socketContents = List.generate(
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
  final entry = signal<int>(0);
  final template = signal(ItemTemplateEntity());

  /// Computed conditions
  bool get hasEnchantment =>
      template.value.randomProperty != 0 || template.value.randomSuffix != 0;
  bool get hasItemLoot => (template.value.flags & 4) != 0;
  bool get hasDisenchantLoot => template.value.disenchantId != 0;
  bool get hasProspectingLoot => (template.value.flags & 262144) != 0;
  bool get hasMillingLoot => (template.value.flags & 536870912) != 0;

  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);
  double _pd(String t, [String field = '']) =>
      parseDoubleField(t, field: field);

  Future<void> initSignals({int? entry}) async {
    if (entry == null || entry <= 0) return;
    try {
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
    entryController.text = template.entry.toString();
    nameController.text = template.name;
    descriptionController.text = template.description;
    qualityController.value = {template.quality};
    classNameController.value = {template.className};
    subclassController.value = {template.subclass};
    soundOverrideSubclassController.text = _fmt(template.soundOverrideSubclass);
    materialController.value = {template.material};
    displayIdController.text = _fmt(template.displayId);
    inventoryTypeController.value = {template.inventoryType};
    sheathController.value = {template.sheath};

    /// Card 2: Set/Pricing/Container/Misc
    bondingController.value = {template.bonding};
    itemsetController.text = _fmt(template.itemset);
    randomPropertyController.text = _fmt(template.randomProperty);
    randomSuffixController.text = _fmt(template.randomSuffix);
    maxDurabilityController.text = _fmt(template.maxDurability);
    buyPriceController.text = _fmt(template.buyPrice);
    sellPriceController.text = _fmt(template.sellPrice);
    buyCountController.text = _fmt(template.buyCount);
    maxcountController.text = _fmt(template.maxcount);
    stackableController.text = _fmt(template.stackable);
    totemCategoryController.text = _fmt(template.totemCategory);
    foodTypeController.value = {template.foodType};
    bagFamilyController.text = formatFlagValue(template.bagFamily);
    containerSlotsController.text = _fmt(template.containerSlots);
    itemLimitCategoryController.text = _fmt(template.itemLimitCategory);
    startquestController.text = _fmt(template.startquest);
    durationController.text = _fmt(template.duration);
    disenchantIdController.text = _fmt(template.disenchantId);
    minMoneyLootController.text = _fmt(template.minMoneyLoot);
    maxMoneyLootController.text = _fmt(template.maxMoneyLoot);

    /// Card 3: Flags
    flagsController.text = formatFlagValue(template.flags);
    flagsExtraController.text = formatFlagValue(template.flagsExtra);
    flagsCustomController.text = formatFlagValue(template.flagsCustom);

    /// Card 4: Damage/Armor
    delayController.text = _fmt(template.delay);
    rangedModRangeController.text = _fmt(template.rangedModRange);
    armorDamageModifierController.text = _fmt(template.armorDamageModifier);
    dmgType1Controller.value = {template.dmgType1};
    dmgMin1Controller.text = _fmt(template.dmgMin1);
    dmgMax1Controller.text = _fmt(template.dmgMax1);
    dmgType2Controller.value = {template.dmgType2};
    dmgMin2Controller.text = _fmt(template.dmgMin2);
    dmgMax2Controller.text = _fmt(template.dmgMax2);
    ammoTypeController.value = {template.ammoType};
    armorController.text = _fmt(template.armor);
    blockController.text = _fmt(template.block);

    /// Card 5: Scaling Stats
    scalingStatDistributionController.text = _fmt(
      template.scalingStatDistribution,
    );
    scalingStatValueController.text = formatFlagValue(
      template.scalingStatValue,
    );

    /// Card 6: Stats (dynamic)
    statsCountController.text = _fmt(template.statsCount);
    statsCountController.text = _fmt(template.statsCount);
    for (var i = 0; i < 10; i++) {
      statTypeControllers[i].value = {template.statTypes[i]};
      statValues[i].text = _fmt(template.statValues[i]);
    }

    /// Card 7: Resistances
    holyResController.text = _fmt(template.holyRes);
    fireResController.text = _fmt(template.fireRes);
    natureResController.text = _fmt(template.natureRes);
    shadowResController.text = _fmt(template.shadowRes);
    frostResController.text = _fmt(template.frostRes);
    arcaneResController.text = _fmt(template.arcaneRes);

    /// Card 8: Spells (5 slots)
    for (var i = 0; i < 5; i++) {
      spellIds[i].text = _fmt(template.spellIds[i]);
      spellTriggerControllers[i].value = {template.spellTriggers[i]};
      spellCharges[i].text = _fmt(template.spellCharges[i]);
      spellPpmRates[i].text = _fmt(template.spellPpmRates[i]);
      spellCooldowns[i].text = _fmt(template.spellCooldowns[i]);
      spellCategories[i].text = _fmt(template.spellCategories[i]);
      spellCategoryCooldowns[i].text = _fmt(template.spellCategoryCooldowns[i]);
    }

    /// Card 9: Requirements
    allowableClassController.text = formatFlagValue(template.allowableClass);
    allowableRaceController.text = formatFlagValue(template.allowableRace);
    itemLevelController.text = _fmt(template.itemLevel);
    requiredLevelController.text = _fmt(template.requiredLevel);
    requiredSkillController.text = _fmt(template.requiredSkill);
    requiredSkillRankController.text = _fmt(template.requiredSkillRank);
    requiredSpellController.text = _fmt(template.requiredSpell);
    requiredHonorRankController.text = _fmt(template.requiredHonorRank);
    requiredCityRankController.text = _fmt(template.requiredCityRank);
    requiredReputationFactionController.text = _fmt(
      template.requiredReputationFaction,
    );
    requiredReputationRankController.text = _fmt(
      template.requiredReputationRank,
    );
    requiredDisenchantSkillController.text = _fmt(
      template.requiredDisenchantSkill,
    );

    /// Card 10: Socket/Gem
    lockidController.text = _fmt(template.lockid);
    gemPropertiesController.text = _fmt(template.gemProperties);
    socketBonusController.text = _fmt(template.socketBonus);
    for (var i = 0; i < 3; i++) {
      socketColorControllers[i].value = {template.socketColors[i]};
      socketContents[i].text = _fmt(template.socketContents[i]);
    }

    /// Card 11: Page/Misc
    mapIdController.text = _fmt(template.mapId);
    areaController.text = _fmt(template.area);
    holidayIdController.text = _fmt(template.holidayId);
    pageTextController.text = _fmt(template.pageText);
    pageMaterialController.value = {template.pageMaterial};
    languageIdController.value = {template.languageId};
    scriptNameController.text = template.scriptName;
    verifiedBuildController.text = _fmt(template.verifiedBuild);
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
      soundOverrideSubclass: _pi(soundOverrideSubclassController.text),
      material: _getSelectValue(materialController),
      displayId: _pi(displayIdController.text),
      inventoryType: _getSelectValue(inventoryTypeController),
      sheath: _getSelectValue(sheathController),

      /// Card 2: Set/Pricing/Container/Misc
      bonding: _getSelectValue(bondingController),
      itemset: _pi(itemsetController.text),
      randomProperty: _pi(randomPropertyController.text),
      randomSuffix: _pi(randomSuffixController.text),
      maxDurability: _pi(maxDurabilityController.text),
      buyPrice: _pi(buyPriceController.text),
      sellPrice: _pi(sellPriceController.text),
      buyCount: _pi(buyCountController.text),
      maxcount: _pi(maxcountController.text),
      stackable: _pi(stackableController.text),
      totemCategory: _pi(totemCategoryController.text),
      foodType: _getSelectValue(foodTypeController),
      bagFamily: parseFlagValue(bagFamilyController.text),
      containerSlots: _pi(containerSlotsController.text),
      itemLimitCategory: _pi(itemLimitCategoryController.text),
      startquest: _pi(startquestController.text),
      duration: _pi(durationController.text),
      disenchantId: _pi(disenchantIdController.text),
      minMoneyLoot: _pi(minMoneyLootController.text),
      maxMoneyLoot: _pi(maxMoneyLootController.text),

      /// Card 3: Flags
      flags: parseFlagValue(flagsController.text),
      flagsExtra: parseFlagValue(flagsExtraController.text),
      flagsCustom: parseFlagValue(flagsCustomController.text),

      /// Card 4: Damage/Armor
      delay: _pi(delayController.text),
      rangedModRange: _pi(rangedModRangeController.text),
      armorDamageModifier: _pd(armorDamageModifierController.text),
      dmgType1: _getSelectValue(dmgType1Controller),
      dmgMin1: _pd(dmgMin1Controller.text),
      dmgMax1: _pd(dmgMax1Controller.text),
      dmgType2: _getSelectValue(dmgType2Controller),
      dmgMin2: _pd(dmgMin2Controller.text),
      dmgMax2: _pd(dmgMax2Controller.text),
      ammoType: _getSelectValue(ammoTypeController),
      armor: _pi(armorController.text),
      block: _pi(blockController.text),

      /// Card 5: Scaling Stats
      scalingStatDistribution: _pi(scalingStatDistributionController.text),
      scalingStatValue: parseFlagValue(scalingStatValueController.text),

      /// Card 6: Stats (dynamic)
      statsCount: _pi(statsCountController.text),
      statTypes: [
        for (var i = 0; i < 10; i++) _getSelectValue(statTypeControllers[i]),
      ],
      statValues: [for (var i = 0; i < 10; i++) _pi(statValues[i].text)],

      /// Card 7: Resistances
      holyRes: _pi(holyResController.text),
      fireRes: _pi(fireResController.text),
      natureRes: _pi(natureResController.text),
      shadowRes: _pi(shadowResController.text),
      frostRes: _pi(frostResController.text),
      arcaneRes: _pi(arcaneResController.text),

      /// Card 8: Spells (5 slots)
      spellIds: [for (var i = 0; i < 5; i++) _pi(spellIds[i].text)],
      spellTriggers: [
        for (var i = 0; i < 5; i++) _getSelectValue(spellTriggerControllers[i]),
      ],
      spellCharges: [for (var i = 0; i < 5; i++) _pi(spellCharges[i].text)],
      spellPpmRates: [for (var i = 0; i < 5; i++) _pd(spellPpmRates[i].text)],
      spellCooldowns: [for (var i = 0; i < 5; i++) _pi(spellCooldowns[i].text)],
      spellCategories: [
        for (var i = 0; i < 5; i++) _pi(spellCategories[i].text),
      ],
      spellCategoryCooldowns: [
        for (var i = 0; i < 5; i++) _pi(spellCategoryCooldowns[i].text),
      ],

      /// Card 9: Requirements
      allowableClass: parseFlagValue(allowableClassController.text),
      allowableRace: parseFlagValue(allowableRaceController.text),
      itemLevel: _pi(itemLevelController.text),
      requiredLevel: _pi(requiredLevelController.text),
      requiredSkill: _pi(requiredSkillController.text),
      requiredSkillRank: _pi(requiredSkillRankController.text),
      requiredSpell: _pi(requiredSpellController.text),
      requiredHonorRank: _pi(requiredHonorRankController.text),
      requiredCityRank: _pi(requiredCityRankController.text),
      requiredReputationFaction: _pi(requiredReputationFactionController.text),
      requiredReputationRank: _pi(requiredReputationRankController.text),
      requiredDisenchantSkill: _pi(requiredDisenchantSkillController.text),

      /// Card 10: Socket/Gem
      lockid: _pi(lockidController.text),
      gemProperties: _pi(gemPropertiesController.text),
      socketBonus: _pi(socketBonusController.text),
      socketColors: [
        for (var i = 0; i < 3; i++) _getSelectValue(socketColorControllers[i]),
      ],
      socketContents: [for (var i = 0; i < 3; i++) _pi(socketContents[i].text)],

      /// Card 11: Page/Misc
      mapId: _pi(mapIdController.text),
      area: _pi(areaController.text),
      holidayId: _pi(holidayIdController.text),
      pageText: _pi(pageTextController.text),
      pageMaterial: _getSelectValue(pageMaterialController),
      languageId: _getSelectValue(languageIdController),
      scriptName: scriptNameController.text,
      verifiedBuild: _pi(verifiedBuildController.text),
    );
  }

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.entry == 0) {
        final id = await _repository.storeItemTemplate(t);
        entryController.text = '$id';
      } else {
        await _repository.updateItemTemplate(t);
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

  void pop() {
    routerFacade.goBack();
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    for (final c in spellIds) {
      c.dispose();
    }
    for (final c in statValues) {
      c.dispose();
    }
    for (final c in spellCharges) {
      c.dispose();
    }
    for (final c in spellPpmRates) {
      c.dispose();
    }
    for (final c in spellCooldowns) {
      c.dispose();
    }
    for (final c in spellCategories) {
      c.dispose();
    }
    for (final c in spellCategoryCooldowns) {
      c.dispose();
    }
    for (final c in socketContents) {
      c.dispose();
    }
    allowableClassController.dispose();
    allowableRaceController.dispose();
    ammoTypeController.dispose();
    arcaneResController.dispose();
    areaController.dispose();
    armorController.dispose();
    armorDamageModifierController.dispose();
    bagFamilyController.dispose();
    blockController.dispose();
    bondingController.dispose();
    buyCountController.dispose();
    buyPriceController.dispose();
    classNameController.dispose();
    containerSlotsController.dispose();
    delayController.dispose();
    descriptionController.dispose();
    disenchantIdController.dispose();
    displayIdController.dispose();
    dmgMax1Controller.dispose();
    dmgMax2Controller.dispose();
    dmgMin1Controller.dispose();
    dmgMin2Controller.dispose();
    dmgType1Controller.dispose();
    dmgType2Controller.dispose();
    durationController.dispose();
    entryController.dispose();
    fireResController.dispose();
    flagsController.dispose();
    flagsCustomController.dispose();
    flagsExtraController.dispose();
    foodTypeController.dispose();
    frostResController.dispose();
    gemPropertiesController.dispose();
    holidayIdController.dispose();
    holyResController.dispose();
    inventoryTypeController.dispose();
    itemLevelController.dispose();
    itemLimitCategoryController.dispose();
    itemsetController.dispose();
    languageIdController.dispose();
    lockidController.dispose();
    mapIdController.dispose();
    materialController.dispose();
    maxDurabilityController.dispose();
    maxMoneyLootController.dispose();
    maxcountController.dispose();
    minMoneyLootController.dispose();
    nameController.dispose();
    natureResController.dispose();
    pageMaterialController.dispose();
    pageTextController.dispose();
    qualityController.dispose();
    randomPropertyController.dispose();
    randomSuffixController.dispose();
    rangedModRangeController.dispose();
    requiredCityRankController.dispose();
    requiredDisenchantSkillController.dispose();
    requiredHonorRankController.dispose();
    requiredLevelController.dispose();
    requiredReputationFactionController.dispose();
    requiredReputationRankController.dispose();
    requiredSkillController.dispose();
    requiredSkillRankController.dispose();
    requiredSpellController.dispose();
    scalingStatDistributionController.dispose();
    scalingStatValueController.dispose();
    scriptNameController.dispose();
    sellPriceController.dispose();
    shadowResController.dispose();
    sheathController.dispose();
    socketBonusController.dispose();
    soundOverrideSubclassController.dispose();
    stackableController.dispose();
    startquestController.dispose();
    statsCountController.dispose();
    subclassController.dispose();
    totemCategoryController.dispose();
    verifiedBuildController.dispose();
  }
}
