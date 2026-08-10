// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_template_detail_view_model.dart';

mixin _ItemTemplateDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<ItemTemplateRepository>();

  final entity = signal<ItemTemplateEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

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
  late final flagsController = registerController(FlagFieldController());
  late final flagsExtraController = registerController(FlagFieldController());
  late final flagsCustomController = registerController(FlagFieldController());
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
  late final scalingStatDistributionController = registerController(
    IntFieldController(),
  );
  late final scalingStatValueController = registerController(
    FlagFieldController(),
  );
  late final statType1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statValue1Controller = registerController(IntFieldController());
  late final statType2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statValue2Controller = registerController(IntFieldController());
  late final statType3Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statValue3Controller = registerController(IntFieldController());
  late final statType4Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statValue4Controller = registerController(IntFieldController());
  late final statType5Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statValue5Controller = registerController(IntFieldController());
  late final statType6Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statValue6Controller = registerController(IntFieldController());
  late final statType7Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statValue7Controller = registerController(IntFieldController());
  late final statType8Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statValue8Controller = registerController(IntFieldController());
  late final statType9Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statValue9Controller = registerController(IntFieldController());
  late final statType10Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final statValue10Controller = registerController(IntFieldController());
  late final holyResController = registerController(IntFieldController());
  late final fireResController = registerController(IntFieldController());
  late final natureResController = registerController(IntFieldController());
  late final shadowResController = registerController(IntFieldController());
  late final frostResController = registerController(IntFieldController());
  late final arcaneResController = registerController(IntFieldController());
  late final spellId1Controller = registerController(IntFieldController());
  late final spellTrigger1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellCharges1Controller = registerController(IntFieldController());
  late final spellPpmRate1Controller = registerController(
    DoubleFieldController(),
  );
  late final spellCooldown1Controller = registerController(
    IntFieldController(),
  );
  late final spellCategory1Controller = registerController(
    IntFieldController(),
  );
  late final spellCategoryCooldown1Controller = registerController(
    IntFieldController(),
  );
  late final spellId2Controller = registerController(IntFieldController());
  late final spellTrigger2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellCharges2Controller = registerController(IntFieldController());
  late final spellPpmRate2Controller = registerController(
    DoubleFieldController(),
  );
  late final spellCooldown2Controller = registerController(
    IntFieldController(),
  );
  late final spellCategory2Controller = registerController(
    IntFieldController(),
  );
  late final spellCategoryCooldown2Controller = registerController(
    IntFieldController(),
  );
  late final spellId3Controller = registerController(IntFieldController());
  late final spellTrigger3Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellCharges3Controller = registerController(IntFieldController());
  late final spellPpmRate3Controller = registerController(
    DoubleFieldController(),
  );
  late final spellCooldown3Controller = registerController(
    IntFieldController(),
  );
  late final spellCategory3Controller = registerController(
    IntFieldController(),
  );
  late final spellCategoryCooldown3Controller = registerController(
    IntFieldController(),
  );
  late final spellId4Controller = registerController(IntFieldController());
  late final spellTrigger4Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellCharges4Controller = registerController(IntFieldController());
  late final spellPpmRate4Controller = registerController(
    DoubleFieldController(),
  );
  late final spellCooldown4Controller = registerController(
    IntFieldController(),
  );
  late final spellCategory4Controller = registerController(
    IntFieldController(),
  );
  late final spellCategoryCooldown4Controller = registerController(
    IntFieldController(),
  );
  late final spellId5Controller = registerController(IntFieldController());
  late final spellTrigger5Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellCharges5Controller = registerController(IntFieldController());
  late final spellPpmRate5Controller = registerController(
    DoubleFieldController(),
  );
  late final spellCooldown5Controller = registerController(
    IntFieldController(),
  );
  late final spellCategory5Controller = registerController(
    IntFieldController(),
  );
  late final spellCategoryCooldown5Controller = registerController(
    IntFieldController(),
  );
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
  late final mapIdController = registerController(IntFieldController());
  late final areaController = registerController(IntFieldController());
  late final holidayIdController = registerController(IntFieldController());
  late final lockidController = registerController(IntFieldController());
  late final gemPropertiesController = registerController(IntFieldController());
  late final socketBonusController = registerController(IntFieldController());
  late final socketColor1Controller = registerController(FlagFieldController());
  late final socketContent1Controller = registerController(
    IntFieldController(),
  );
  late final socketColor2Controller = registerController(FlagFieldController());
  late final socketContent2Controller = registerController(
    IntFieldController(),
  );
  late final socketColor3Controller = registerController(FlagFieldController());
  late final socketContent3Controller = registerController(
    IntFieldController(),
  );
  late final pageTextController = registerController(IntFieldController());
  late final pageMaterialController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final languageIdController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final scriptNameController = registerController(StringFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createItemTemplate();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getItemTemplate(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = FoxyError.message(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        final storedKey = await _repository.storeItemTemplate(candidate);
        persistedKey.value = storedKey;
      } else {
        await _repository.updateItemTemplate(originalKey, candidate);
        persistedKey.value = candidate.entry;
      }
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(ItemTemplateEntity itemTemplate) {}

  void _applyCandidate(ItemTemplateEntity itemTemplate) {
    entryController.init(itemTemplate.entry);
    nameController.init(itemTemplate.name);
    descriptionController.init(itemTemplate.description);
    qualityController.init(itemTemplate.quality);
    classNameController.init(itemTemplate.className);
    subclassController.init(itemTemplate.subclass);
    soundOverrideSubclassController.init(itemTemplate.soundOverrideSubclass);
    materialController.init(itemTemplate.material);
    displayIdController.init(itemTemplate.displayId);
    inventoryTypeController.init(itemTemplate.inventoryType);
    sheathController.init(itemTemplate.sheath);
    bondingController.init(itemTemplate.bonding);
    itemsetController.init(itemTemplate.itemset);
    randomPropertyController.init(itemTemplate.randomProperty);
    randomSuffixController.init(itemTemplate.randomSuffix);
    maxDurabilityController.init(itemTemplate.maxDurability);
    buyPriceController.init(itemTemplate.buyPrice);
    sellPriceController.init(itemTemplate.sellPrice);
    buyCountController.init(itemTemplate.buyCount);
    maxcountController.init(itemTemplate.maxcount);
    stackableController.init(itemTemplate.stackable);
    totemCategoryController.init(itemTemplate.totemCategory);
    foodTypeController.init(itemTemplate.foodType);
    bagFamilyController.init(itemTemplate.bagFamily);
    containerSlotsController.init(itemTemplate.containerSlots);
    itemLimitCategoryController.init(itemTemplate.itemLimitCategory);
    startquestController.init(itemTemplate.startquest);
    durationController.init(itemTemplate.duration);
    disenchantIdController.init(itemTemplate.disenchantId);
    minMoneyLootController.init(itemTemplate.minMoneyLoot);
    maxMoneyLootController.init(itemTemplate.maxMoneyLoot);
    flagsController.init(itemTemplate.flags);
    flagsExtraController.init(itemTemplate.flagsExtra);
    flagsCustomController.init(itemTemplate.flagsCustom);
    delayController.init(itemTemplate.delay);
    rangedModRangeController.init(itemTemplate.rangedModRange);
    armorDamageModifierController.init(itemTemplate.armorDamageModifier);
    dmgType1Controller.init(itemTemplate.dmgType1);
    dmgMin1Controller.init(itemTemplate.dmgMin1);
    dmgMax1Controller.init(itemTemplate.dmgMax1);
    dmgType2Controller.init(itemTemplate.dmgType2);
    dmgMin2Controller.init(itemTemplate.dmgMin2);
    dmgMax2Controller.init(itemTemplate.dmgMax2);
    ammoTypeController.init(itemTemplate.ammoType);
    armorController.init(itemTemplate.armor);
    blockController.init(itemTemplate.block);
    scalingStatDistributionController.init(
      itemTemplate.scalingStatDistribution,
    );
    scalingStatValueController.init(itemTemplate.scalingStatValue);
    statType1Controller.init(itemTemplate.statType1);
    statValue1Controller.init(itemTemplate.statValue1);
    statType2Controller.init(itemTemplate.statType2);
    statValue2Controller.init(itemTemplate.statValue2);
    statType3Controller.init(itemTemplate.statType3);
    statValue3Controller.init(itemTemplate.statValue3);
    statType4Controller.init(itemTemplate.statType4);
    statValue4Controller.init(itemTemplate.statValue4);
    statType5Controller.init(itemTemplate.statType5);
    statValue5Controller.init(itemTemplate.statValue5);
    statType6Controller.init(itemTemplate.statType6);
    statValue6Controller.init(itemTemplate.statValue6);
    statType7Controller.init(itemTemplate.statType7);
    statValue7Controller.init(itemTemplate.statValue7);
    statType8Controller.init(itemTemplate.statType8);
    statValue8Controller.init(itemTemplate.statValue8);
    statType9Controller.init(itemTemplate.statType9);
    statValue9Controller.init(itemTemplate.statValue9);
    statType10Controller.init(itemTemplate.statType10);
    statValue10Controller.init(itemTemplate.statValue10);
    holyResController.init(itemTemplate.holyRes);
    fireResController.init(itemTemplate.fireRes);
    natureResController.init(itemTemplate.natureRes);
    shadowResController.init(itemTemplate.shadowRes);
    frostResController.init(itemTemplate.frostRes);
    arcaneResController.init(itemTemplate.arcaneRes);
    spellId1Controller.init(itemTemplate.spellId1);
    spellTrigger1Controller.init(itemTemplate.spellTrigger1);
    spellCharges1Controller.init(itemTemplate.spellCharges1);
    spellPpmRate1Controller.init(itemTemplate.spellPpmRate1);
    spellCooldown1Controller.init(itemTemplate.spellCooldown1);
    spellCategory1Controller.init(itemTemplate.spellCategory1);
    spellCategoryCooldown1Controller.init(itemTemplate.spellCategoryCooldown1);
    spellId2Controller.init(itemTemplate.spellId2);
    spellTrigger2Controller.init(itemTemplate.spellTrigger2);
    spellCharges2Controller.init(itemTemplate.spellCharges2);
    spellPpmRate2Controller.init(itemTemplate.spellPpmRate2);
    spellCooldown2Controller.init(itemTemplate.spellCooldown2);
    spellCategory2Controller.init(itemTemplate.spellCategory2);
    spellCategoryCooldown2Controller.init(itemTemplate.spellCategoryCooldown2);
    spellId3Controller.init(itemTemplate.spellId3);
    spellTrigger3Controller.init(itemTemplate.spellTrigger3);
    spellCharges3Controller.init(itemTemplate.spellCharges3);
    spellPpmRate3Controller.init(itemTemplate.spellPpmRate3);
    spellCooldown3Controller.init(itemTemplate.spellCooldown3);
    spellCategory3Controller.init(itemTemplate.spellCategory3);
    spellCategoryCooldown3Controller.init(itemTemplate.spellCategoryCooldown3);
    spellId4Controller.init(itemTemplate.spellId4);
    spellTrigger4Controller.init(itemTemplate.spellTrigger4);
    spellCharges4Controller.init(itemTemplate.spellCharges4);
    spellPpmRate4Controller.init(itemTemplate.spellPpmRate4);
    spellCooldown4Controller.init(itemTemplate.spellCooldown4);
    spellCategory4Controller.init(itemTemplate.spellCategory4);
    spellCategoryCooldown4Controller.init(itemTemplate.spellCategoryCooldown4);
    spellId5Controller.init(itemTemplate.spellId5);
    spellTrigger5Controller.init(itemTemplate.spellTrigger5);
    spellCharges5Controller.init(itemTemplate.spellCharges5);
    spellPpmRate5Controller.init(itemTemplate.spellPpmRate5);
    spellCooldown5Controller.init(itemTemplate.spellCooldown5);
    spellCategory5Controller.init(itemTemplate.spellCategory5);
    spellCategoryCooldown5Controller.init(itemTemplate.spellCategoryCooldown5);
    allowableClassController.init(itemTemplate.allowableClass);
    allowableRaceController.init(itemTemplate.allowableRace);
    itemLevelController.init(itemTemplate.itemLevel);
    requiredLevelController.init(itemTemplate.requiredLevel);
    requiredSkillController.init(itemTemplate.requiredSkill);
    requiredSkillRankController.init(itemTemplate.requiredSkillRank);
    requiredSpellController.init(itemTemplate.requiredSpell);
    requiredHonorRankController.init(itemTemplate.requiredHonorRank);
    requiredCityRankController.init(itemTemplate.requiredCityRank);
    requiredReputationFactionController.init(
      itemTemplate.requiredReputationFaction,
    );
    requiredReputationRankController.init(itemTemplate.requiredReputationRank);
    requiredDisenchantSkillController.init(
      itemTemplate.requiredDisenchantSkill,
    );
    mapIdController.init(itemTemplate.mapId);
    areaController.init(itemTemplate.area);
    holidayIdController.init(itemTemplate.holidayId);
    lockidController.init(itemTemplate.lockid);
    gemPropertiesController.init(itemTemplate.gemProperties);
    socketBonusController.init(itemTemplate.socketBonus);
    socketColor1Controller.init(itemTemplate.socketColor1);
    socketContent1Controller.init(itemTemplate.socketContent1);
    socketColor2Controller.init(itemTemplate.socketColor2);
    socketContent2Controller.init(itemTemplate.socketContent2);
    socketColor3Controller.init(itemTemplate.socketColor3);
    socketContent3Controller.init(itemTemplate.socketContent3);
    pageTextController.init(itemTemplate.pageText);
    pageMaterialController.init(itemTemplate.pageMaterial);
    languageIdController.init(itemTemplate.languageId);
    scriptNameController.init(itemTemplate.scriptName);
    verifiedBuildController.init(itemTemplate.verifiedBuild);
    _afterApplyCandidate(itemTemplate);
  }

  ItemTemplateEntity _collectCandidate() {
    return ItemTemplateEntity(
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
      flags: flagsController.collect(),
      flagsExtra: flagsExtraController.collect(),
      flagsCustom: flagsCustomController.collect(),
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
      scalingStatDistribution: scalingStatDistributionController.collect(),
      scalingStatValue: scalingStatValueController.collect(),
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
      holyRes: holyResController.collect(),
      fireRes: fireResController.collect(),
      natureRes: natureResController.collect(),
      shadowRes: shadowResController.collect(),
      frostRes: frostResController.collect(),
      arcaneRes: arcaneResController.collect(),
      spellId1: spellId1Controller.collect(),
      spellTrigger1: spellTrigger1Controller.collect(),
      spellCharges1: spellCharges1Controller.collect(),
      spellPpmRate1: spellPpmRate1Controller.collect(),
      spellCooldown1: spellCooldown1Controller.collect(),
      spellCategory1: spellCategory1Controller.collect(),
      spellCategoryCooldown1: spellCategoryCooldown1Controller.collect(),
      spellId2: spellId2Controller.collect(),
      spellTrigger2: spellTrigger2Controller.collect(),
      spellCharges2: spellCharges2Controller.collect(),
      spellPpmRate2: spellPpmRate2Controller.collect(),
      spellCooldown2: spellCooldown2Controller.collect(),
      spellCategory2: spellCategory2Controller.collect(),
      spellCategoryCooldown2: spellCategoryCooldown2Controller.collect(),
      spellId3: spellId3Controller.collect(),
      spellTrigger3: spellTrigger3Controller.collect(),
      spellCharges3: spellCharges3Controller.collect(),
      spellPpmRate3: spellPpmRate3Controller.collect(),
      spellCooldown3: spellCooldown3Controller.collect(),
      spellCategory3: spellCategory3Controller.collect(),
      spellCategoryCooldown3: spellCategoryCooldown3Controller.collect(),
      spellId4: spellId4Controller.collect(),
      spellTrigger4: spellTrigger4Controller.collect(),
      spellCharges4: spellCharges4Controller.collect(),
      spellPpmRate4: spellPpmRate4Controller.collect(),
      spellCooldown4: spellCooldown4Controller.collect(),
      spellCategory4: spellCategory4Controller.collect(),
      spellCategoryCooldown4: spellCategoryCooldown4Controller.collect(),
      spellId5: spellId5Controller.collect(),
      spellTrigger5: spellTrigger5Controller.collect(),
      spellCharges5: spellCharges5Controller.collect(),
      spellPpmRate5: spellPpmRate5Controller.collect(),
      spellCooldown5: spellCooldown5Controller.collect(),
      spellCategory5: spellCategory5Controller.collect(),
      spellCategoryCooldown5: spellCategoryCooldown5Controller.collect(),
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
      mapId: mapIdController.collect(),
      area: areaController.collect(),
      holidayId: holidayIdController.collect(),
      lockid: lockidController.collect(),
      gemProperties: gemPropertiesController.collect(),
      socketBonus: socketBonusController.collect(),
      socketColor1: socketColor1Controller.collect(),
      socketContent1: socketContent1Controller.collect(),
      socketColor2: socketColor2Controller.collect(),
      socketContent2: socketContent2Controller.collect(),
      socketColor3: socketColor3Controller.collect(),
      socketContent3: socketContent3Controller.collect(),
      pageText: pageTextController.collect(),
      pageMaterial: pageMaterialController.collect(),
      languageId: languageIdController.collect(),
      scriptName: scriptNameController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(
    ActivityActionType action,
    ItemTemplateEntity itemTemplate,
  ) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'item_template',
          actionType: action,
          entityName: itemTemplate.name,
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
