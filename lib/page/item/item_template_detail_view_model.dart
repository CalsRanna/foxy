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
  final soundOverrideSubclass = signal<int>(0);
  final materialController = ShadSelectController<int>();
  final displayIdController = TextEditingController();
  final inventoryTypeController = ShadSelectController<int>();
  final sheathController = ShadSelectController<int>();

  /// Card 2: Set/Pricing/Container/Misc
  final bondingController = ShadSelectController<int>();
  final itemset = signal<int>(0);
  final randomPropertyController = TextEditingController();
  final randomSuffixController = TextEditingController();
  final maxDurability = signal<int>(0);
  final buyPrice = signal<int>(0);
  final sellPrice = signal<int>(0);
  final buyCount = signal<int>(0);
  final maxcount = signal<int>(0);
  final stackable = signal<int>(0);
  final totemCategory = signal<int>(0);
  final foodTypeController = ShadSelectController<int>();
  final bagFamilyController = TextEditingController();
  final containerSlots = signal<int>(0);
  final itemLimitCategory = signal<int>(0);
  final startquestController = TextEditingController();
  final duration = signal<int>(0);
  final disenchantId = signal<int>(0);
  final minMoneyLoot = signal<int>(0);
  final maxMoneyLoot = signal<int>(0);

  /// Card 3: Flags
  final flagsController = TextEditingController();
  final flagsExtraController = TextEditingController();
  final flagsCustomController = TextEditingController();

  /// Card 4: Damage/Armor
  final delay = signal<int>(0);
  final rangedModRange = signal<int>(0);
  final armorDamageModifier = signal<double>(0.0);
  final dmgType1Controller = ShadSelectController<int>();
  final dmgMin1 = signal<double>(0.0);
  final dmgMax1 = signal<double>(0.0);
  final dmgType2Controller = ShadSelectController<int>();
  final dmgMin2 = signal<double>(0.0);
  final dmgMax2 = signal<double>(0.0);
  final ammoTypeController = ShadSelectController<int>();
  final armor = signal<int>(0);
  final block = signal<int>(0);

  /// Card 5: Scaling Stats
  final scalingStatDistributionController = TextEditingController();
  final scalingStatValueController = TextEditingController();

  /// Card 6: Stats (dynamic)
  final statsCount = signal<int>(0);
  final List<ShadSelectController<int>> statTypeControllers = List.generate(
    10,
    (_) => ShadSelectController<int>(),
  );
  final List<Signal<int>> statValues = List.generate(
    10,
    (_) => signal<int>(0),
  );

  /// Card 7: Resistances
  final holyRes = signal<int>(0);
  final fireRes = signal<int>(0);
  final natureRes = signal<int>(0);
  final shadowRes = signal<int>(0);
  final frostRes = signal<int>(0);
  final arcaneRes = signal<int>(0);

  /// Card 8: Spells (5 slots)
  final List<TextEditingController> spellIdControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<ShadSelectController<int>> spellTriggerControllers = List.generate(
    5,
    (_) => ShadSelectController<int>(),
  );
  final List<Signal<int>> spellCharges = List.generate(
    5,
    (_) => signal<int>(0),
  );
  final List<Signal<double>> spellPpmRates = List.generate(
    5,
    (_) => signal<double>(0.0),
  );
  final List<Signal<int>> spellCooldowns = List.generate(
    5,
    (_) => signal<int>(0),
  );
  final List<Signal<int>> spellCategories = List.generate(
    5,
    (_) => signal<int>(0),
  );
  final List<Signal<int>> spellCategoryCooldowns = List.generate(
    5,
    (_) => signal<int>(0),
  );

  /// Card 9: Requirements
  final allowableClassController = TextEditingController();
  final allowableRaceController = TextEditingController();
  final itemLevel = signal<int>(0);
  final requiredLevel = signal<int>(0);
  final requiredSkill = signal<int>(0);
  final requiredSkillRank = signal<int>(0);
  final requiredSpellController = TextEditingController();
  final requiredHonorRank = signal<int>(0);
  final requiredCityRank = signal<int>(0);
  final requiredReputationFaction = signal<int>(0);
  final requiredReputationRank = signal<int>(0);
  final requiredDisenchantSkill = signal<int>(0);

  /// Card 10: Socket/Gem
  final lockidController = TextEditingController();
  final gemProperties = signal<int>(0);
  final socketBonus = signal<int>(0);
  final List<ShadSelectController<int>> socketColorControllers = List.generate(
    3,
    (_) => ShadSelectController<int>(),
  );
  final List<Signal<int>> socketContents = List.generate(
    3,
    (_) => signal<int>(0),
  );

  /// Card 11: Page/Misc
  final mapIdController = TextEditingController();
  final areaController = TextEditingController();
  final holidayId = signal<int>(0);
  final pageTextController = TextEditingController();
  final pageMaterialController = ShadSelectController<int>();
  final languageIdController = ShadSelectController<int>();
  final scriptNameController = TextEditingController();
  final verifiedBuild = signal<int>(0);

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
    if (entry == null || entry <= 0) return;
    try {
      final repository = ItemTemplateRepository();
      template.value = await repository.getItemTemplate(entry);
      _initControllers(template.value);
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
    soundOverrideSubclass.value = template.soundOverrideSubclass;
    materialController.value = {template.material};
    displayIdController.text = template.displayId.toString();
    inventoryTypeController.value = {template.inventoryType};
    sheathController.value = {template.sheath};

    /// Card 2: Set/Pricing/Container/Misc
    bondingController.value = {template.bonding};
    itemset.value = template.itemset;
    randomPropertyController.text = template.randomProperty.toString();
    randomSuffixController.text = template.randomSuffix.toString();
    maxDurability.value = template.maxDurability;
    buyPrice.value = template.buyPrice;
    sellPrice.value = template.sellPrice;
    buyCount.value = template.buyCount;
    maxcount.value = template.maxcount;
    stackable.value = template.stackable;
    totemCategory.value = template.totemCategory;
    foodTypeController.value = {template.foodType};
    bagFamilyController.text = template.bagFamily.toString();
    containerSlots.value = template.containerSlots;
    itemLimitCategory.value = template.itemLimitCategory;
    startquestController.text = template.startquest.toString();
    duration.value = template.duration;
    disenchantId.value = template.disenchantId;
    minMoneyLoot.value = template.minMoneyLoot;
    maxMoneyLoot.value = template.maxMoneyLoot;

    /// Card 3: Flags
    flagsController.text = template.flags.toString();
    flagsExtraController.text = template.flagsExtra.toString();
    flagsCustomController.text = template.flagsCustom.toString();

    /// Card 4: Damage/Armor
    delay.value = template.delay;
    rangedModRange.value = template.rangedModRange;
    armorDamageModifier.value = template.armorDamageModifier;
    dmgType1Controller.value = {template.dmgType1};
    dmgMin1.value = template.dmgMin1;
    dmgMax1.value = template.dmgMax1;
    dmgType2Controller.value = {template.dmgType2};
    dmgMin2.value = template.dmgMin2;
    dmgMax2.value = template.dmgMax2;
    ammoTypeController.value = {template.ammoType};
    armor.value = template.armor;
    block.value = template.block;

    /// Card 5: Scaling Stats
    scalingStatDistributionController.text = template.scalingStatDistribution
        .toString();
    scalingStatValueController.text = template.scalingStatValue.toString();

    /// Card 6: Stats (dynamic)
    statsCount.value = template.statsCount;
    statsCount.value = template.statsCount;
    for (var i = 0; i < 10; i++) {
      statTypeControllers[i].value = {template.statTypes[i]};
      statValues[i].value = template.statValues[i];
    }

    /// Card 7: Resistances
    holyRes.value = template.holyRes;
    fireRes.value = template.fireRes;
    natureRes.value = template.natureRes;
    shadowRes.value = template.shadowRes;
    frostRes.value = template.frostRes;
    arcaneRes.value = template.arcaneRes;

    /// Card 8: Spells (5 slots)
    for (var i = 0; i < 5; i++) {
      spellIdControllers[i].text = template.spellIds[i].toString();
      spellTriggerControllers[i].value = {template.spellTriggers[i]};
      spellCharges[i].value = template.spellCharges[i];
      spellPpmRates[i].value = template.spellPpmRates[i];
      spellCooldowns[i].value = template.spellCooldowns[i];
      spellCategories[i].value = template.spellCategories[i];
      spellCategoryCooldowns[i].value = template.spellCategoryCooldowns[i];
    }

    /// Card 9: Requirements
    allowableClassController.text = template.allowableClass.toString();
    allowableRaceController.text = template.allowableRace.toString();
    itemLevel.value = template.itemLevel;
    requiredLevel.value = template.requiredLevel;
    requiredSkill.value = template.requiredSkill;
    requiredSkillRank.value = template.requiredSkillRank;
    requiredSpellController.text = template.requiredSpell.toString();
    requiredHonorRank.value = template.requiredHonorRank;
    requiredCityRank.value = template.requiredCityRank;
    requiredReputationFaction.value = template.requiredReputationFaction;
    requiredReputationRank.value = template.requiredReputationRank;
    requiredDisenchantSkill.value = template.requiredDisenchantSkill;

    /// Card 10: Socket/Gem
    lockidController.text = template.lockid.toString();
    gemProperties.value = template.gemProperties;
    socketBonus.value = template.socketBonus;
    for (var i = 0; i < 3; i++) {
      socketColorControllers[i].value = {template.socketColors[i]};
      socketContents[i].value = template.socketContents[i];
    }

    /// Card 11: Page/Misc
    mapIdController.text = template.mapId.toString();
    areaController.text = template.area.toString();
    holidayId.value = template.holidayId;
    pageTextController.text = template.pageText.toString();
    pageMaterialController.value = {template.pageMaterial};
    languageIdController.value = {template.languageId};
    scriptNameController.text = template.scriptName;
    verifiedBuild.value = template.verifiedBuild;
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
      soundOverrideSubclass: soundOverrideSubclass.value,
      material: _getSelectValue(materialController),
      displayId: _parseInt(displayIdController.text),
      inventoryType: _getSelectValue(inventoryTypeController),
      sheath: _getSelectValue(sheathController),

      /// Card 2: Set/Pricing/Container/Misc
      bonding: _getSelectValue(bondingController),
      itemset: itemset.value,
      randomProperty: _parseInt(randomPropertyController.text),
      randomSuffix: _parseInt(randomSuffixController.text),
      maxDurability: maxDurability.value,
      buyPrice: buyPrice.value,
      sellPrice: sellPrice.value,
      buyCount: buyCount.value,
      maxcount: maxcount.value,
      stackable: stackable.value,
      totemCategory: totemCategory.value,
      foodType: _getSelectValue(foodTypeController),
      bagFamily: _parseInt(bagFamilyController.text),
      containerSlots: containerSlots.value,
      itemLimitCategory: itemLimitCategory.value,
      startquest: _parseInt(startquestController.text),
      duration: duration.value,
      disenchantId: disenchantId.value,
      minMoneyLoot: minMoneyLoot.value,
      maxMoneyLoot: maxMoneyLoot.value,

      /// Card 3: Flags
      flags: _parseInt(flagsController.text),
      flagsExtra: _parseInt(flagsExtraController.text),
      flagsCustom: _parseInt(flagsCustomController.text),

      /// Card 4: Damage/Armor
      delay: delay.value,
      rangedModRange: rangedModRange.value,
      armorDamageModifier: armorDamageModifier.value,
      dmgType1: _getSelectValue(dmgType1Controller),
      dmgMin1: dmgMin1.value,
      dmgMax1: dmgMax1.value,
      dmgType2: _getSelectValue(dmgType2Controller),
      dmgMin2: dmgMin2.value,
      dmgMax2: dmgMax2.value,
      ammoType: _getSelectValue(ammoTypeController),
      armor: armor.value,
      block: block.value,

      /// Card 5: Scaling Stats
      scalingStatDistribution: _parseInt(
        scalingStatDistributionController.text,
      ),
      scalingStatValue: _parseInt(scalingStatValueController.text),

      /// Card 6: Stats (dynamic)
      statsCount: statsCount.value,
      statTypes: [
        for (var i = 0; i < 10; i++) _getSelectValue(statTypeControllers[i]),
      ],
      statValues: [
        for (var i = 0; i < 10; i++) statValues[i].value,
      ],

      /// Card 7: Resistances
      holyRes: holyRes.value,
      fireRes: fireRes.value,
      natureRes: natureRes.value,
      shadowRes: shadowRes.value,
      frostRes: frostRes.value,
      arcaneRes: arcaneRes.value,

      /// Card 8: Spells (5 slots)
      spellIds: [
        for (var i = 0; i < 5; i++) _parseInt(spellIdControllers[i].text),
      ],
      spellTriggers: [
        for (var i = 0; i < 5; i++) _getSelectValue(spellTriggerControllers[i]),
      ],
      spellCharges: [
        for (var i = 0; i < 5; i++) spellCharges[i].value,
      ],
      spellPpmRates: [
        for (var i = 0; i < 5; i++) spellPpmRates[i].value,
      ],
      spellCooldowns: [
        for (var i = 0; i < 5; i++) spellCooldowns[i].value,
      ],
      spellCategories: [
        for (var i = 0; i < 5; i++) spellCategories[i].value,
      ],
      spellCategoryCooldowns: [
        for (var i = 0; i < 5; i++) spellCategoryCooldowns[i].value,
      ],

      /// Card 9: Requirements
      allowableClass: _parseInt(allowableClassController.text),
      allowableRace: _parseInt(allowableRaceController.text),
      itemLevel: itemLevel.value,
      requiredLevel: requiredLevel.value,
      requiredSkill: requiredSkill.value,
      requiredSkillRank: requiredSkillRank.value,
      requiredSpell: _parseInt(requiredSpellController.text),
      requiredHonorRank: requiredHonorRank.value,
      requiredCityRank: requiredCityRank.value,
      requiredReputationFaction: requiredReputationFaction.value,
      requiredReputationRank: requiredReputationRank.value,
      requiredDisenchantSkill: requiredDisenchantSkill.value,

      /// Card 10: Socket/Gem
      lockid: _parseInt(lockidController.text),
      gemProperties: gemProperties.value,
      socketBonus: socketBonus.value,
      socketColors: [
        for (var i = 0; i < 3; i++) _getSelectValue(socketColorControllers[i]),
      ],
      socketContents: [
        for (var i = 0; i < 3; i++) socketContents[i].value,
      ],

      /// Card 11: Page/Misc
      mapId: _parseInt(mapIdController.text),
      area: _parseInt(areaController.text),
      holidayId: holidayId.value,
      pageText: _parseInt(pageTextController.text),
      pageMaterial: _getSelectValue(pageMaterialController),
      languageId: _getSelectValue(languageIdController),
      scriptName: scriptNameController.text,
      verifiedBuild: verifiedBuild.value,
    );
  }

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
    materialController.dispose();
    displayIdController.dispose();
    inventoryTypeController.dispose();
    sheathController.dispose();

    /// Card 2: Set/Pricing/Container/Misc
    bondingController.dispose();
    randomPropertyController.dispose();
    randomSuffixController.dispose();
    foodTypeController.dispose();
    bagFamilyController.dispose();
    startquestController.dispose();

    /// Card 3: Flags
    flagsController.dispose();
    flagsExtraController.dispose();
    flagsCustomController.dispose();

    /// Card 4: Damage/Armor
    dmgType1Controller.dispose();
    dmgType2Controller.dispose();
    ammoTypeController.dispose();

    /// Card 5: Scaling Stats
    scalingStatDistributionController.dispose();
    scalingStatValueController.dispose();

    /// Card 6: Stats (dynamic)
    for (var i = 0; i < 10; i++) {
      statTypeControllers[i].dispose();
    }

    /// Card 8: Spells (5 slots)
    for (var i = 0; i < 5; i++) {
      spellIdControllers[i].dispose();
      spellTriggerControllers[i].dispose();
    }

    /// Card 9: Requirements
    allowableClassController.dispose();
    allowableRaceController.dispose();
    requiredSpellController.dispose();

    /// Card 10: Socket/Gem
    lockidController.dispose();
    for (var i = 0; i < 3; i++) {
      socketColorControllers[i].dispose();
    }

    /// Card 11: Page/Misc
    mapIdController.dispose();
    areaController.dispose();
    pageTextController.dispose();
    pageMaterialController.dispose();
    languageIdController.dispose();
    scriptNameController.dispose();
  }
}
