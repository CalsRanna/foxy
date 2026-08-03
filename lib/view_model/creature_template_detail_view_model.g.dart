// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_detail_view_model.dart';

mixin _CreatureTemplateDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<CreatureTemplateRepository>();

  final entity = signal<CreatureTemplateEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final aiNameController = registerController(StringFieldController());
  late final armorModifierController = registerController(
    DoubleFieldController(),
  );
  late final baseAttackTimeController = registerController(
    IntFieldController(),
  );
  late final baseVarianceController = registerController(
    DoubleFieldController(),
  );
  late final damageModifierController = registerController(
    DoubleFieldController(),
  );
  late final difficultyEntry1Controller = registerController(
    IntFieldController(),
  );
  late final difficultyEntry2Controller = registerController(
    IntFieldController(),
  );
  late final difficultyEntry3Controller = registerController(
    IntFieldController(),
  );
  late final damageSchoolController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final detectionRangeController = registerController(
    DoubleFieldController(),
  );
  late final dynamicFlagsController = registerController(FlagFieldController());
  late final entryController = registerController(IntFieldController());
  late final expController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final experienceModifierController = registerController(
    DoubleFieldController(),
  );
  late final factionController = registerController(IntFieldController());
  late final familyController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final flagsExtraController = registerController(FlagFieldController());
  late final gossipMenuIdController = registerController(IntFieldController());
  late final healthModifierController = registerController(
    DoubleFieldController(),
  );
  late final hoverHeightController = registerController(
    DoubleFieldController(),
  );
  late final iconNameController = registerController(StringFieldController());
  late final killCredit1Controller = registerController(IntFieldController());
  late final killCredit2Controller = registerController(IntFieldController());
  late final lootIdController = registerController(IntFieldController());
  late final maxGoldController = registerController(IntFieldController());
  late final maxLevelController = registerController(IntFieldController());
  late final manaModifierController = registerController(
    DoubleFieldController(),
  );
  late final minLevelController = registerController(IntFieldController());
  late final minGoldController = registerController(IntFieldController());
  late final movementIdController = registerController(IntFieldController());
  late final movementTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final nameController = registerController(StringFieldController());
  late final npcFlagController = registerController(FlagFieldController());
  late final petSpellDataIdController = registerController(
    IntFieldController(),
  );
  late final pickpocketLootController = registerController(
    IntFieldController(),
  );
  late final racialLeaderController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final rangeAttackTimeController = registerController(
    IntFieldController(),
  );
  late final rangeVarianceController = registerController(
    DoubleFieldController(),
  );
  late final rankController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final regenHealthController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final scriptNameController = registerController(StringFieldController());
  late final skinLootController = registerController(IntFieldController());
  late final speedFlightController = registerController(
    DoubleFieldController(),
  );
  late final speedRunController = registerController(DoubleFieldController());
  late final speedSwimController = registerController(DoubleFieldController());
  late final speedWalkController = registerController(DoubleFieldController());
  late final subNameController = registerController(StringFieldController());
  late final typeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final typeFlagsController = registerController(FlagFieldController());
  late final unitClassController = registerController(
    SelectFieldController<int>(fallback: 1),
  );
  late final unitFlagsController = registerController(FlagFieldController());
  late final unitFlags2Controller = registerController(FlagFieldController());
  late final vehicleIdController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());
  late final creatureImmunitiesIdController = registerController(
    IntFieldController(),
  );

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createCreatureTemplate();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getCreatureTemplate(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = foxyErrorMessage(error);
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
        await _repository.storeCreatureTemplate(candidate);
      } else {
        await _repository.updateCreatureTemplate(originalKey, candidate);
      }
      persistedKey.value = candidate.entry;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(CreatureTemplateEntity creatureTemplate) {}

  void _applyCandidate(CreatureTemplateEntity creatureTemplate) {
    aiNameController.init(creatureTemplate.aiName);
    armorModifierController.init(creatureTemplate.armorModifier);
    baseAttackTimeController.init(creatureTemplate.baseAttackTime);
    baseVarianceController.init(creatureTemplate.baseVariance);
    damageModifierController.init(creatureTemplate.damageModifier);
    difficultyEntry1Controller.init(creatureTemplate.difficultyEntry1);
    difficultyEntry2Controller.init(creatureTemplate.difficultyEntry2);
    difficultyEntry3Controller.init(creatureTemplate.difficultyEntry3);
    damageSchoolController.init(creatureTemplate.damageSchool);
    detectionRangeController.init(creatureTemplate.detectionRange);
    dynamicFlagsController.init(creatureTemplate.dynamicFlags);
    entryController.init(creatureTemplate.entry);
    expController.init(creatureTemplate.exp);
    experienceModifierController.init(creatureTemplate.experienceModifier);
    factionController.init(creatureTemplate.faction);
    familyController.init(creatureTemplate.family);
    flagsExtraController.init(creatureTemplate.flagsExtra);
    gossipMenuIdController.init(creatureTemplate.gossipMenuId);
    healthModifierController.init(creatureTemplate.healthModifier);
    hoverHeightController.init(creatureTemplate.hoverHeight);
    iconNameController.init(creatureTemplate.iconName);
    killCredit1Controller.init(creatureTemplate.killCredit1);
    killCredit2Controller.init(creatureTemplate.killCredit2);
    lootIdController.init(creatureTemplate.lootId);
    maxGoldController.init(creatureTemplate.maxGold);
    maxLevelController.init(creatureTemplate.maxLevel);
    manaModifierController.init(creatureTemplate.manaModifier);
    minLevelController.init(creatureTemplate.minLevel);
    minGoldController.init(creatureTemplate.minGold);
    movementIdController.init(creatureTemplate.movementId);
    movementTypeController.init(creatureTemplate.movementType);
    nameController.init(creatureTemplate.name);
    npcFlagController.init(creatureTemplate.npcFlag);
    petSpellDataIdController.init(creatureTemplate.petSpellDataId);
    pickpocketLootController.init(creatureTemplate.pickpocketLoot);
    racialLeaderController.init(creatureTemplate.racialLeader);
    rangeAttackTimeController.init(creatureTemplate.rangeAttackTime);
    rangeVarianceController.init(creatureTemplate.rangeVariance);
    rankController.init(creatureTemplate.rank);
    regenHealthController.init(creatureTemplate.regenHealth);
    scriptNameController.init(creatureTemplate.scriptName);
    skinLootController.init(creatureTemplate.skinLoot);
    speedFlightController.init(creatureTemplate.speedFlight);
    speedRunController.init(creatureTemplate.speedRun);
    speedSwimController.init(creatureTemplate.speedSwim);
    speedWalkController.init(creatureTemplate.speedWalk);
    subNameController.init(creatureTemplate.subName);
    typeController.init(creatureTemplate.type);
    typeFlagsController.init(creatureTemplate.typeFlags);
    unitClassController.init(creatureTemplate.unitClass);
    unitFlagsController.init(creatureTemplate.unitFlags);
    unitFlags2Controller.init(creatureTemplate.unitFlags2);
    vehicleIdController.init(creatureTemplate.vehicleId);
    verifiedBuildController.init(creatureTemplate.verifiedBuild);
    creatureImmunitiesIdController.init(creatureTemplate.creatureImmunitiesId);
    _afterApplyCandidate(creatureTemplate);
  }

  CreatureTemplateEntity _collectCandidate() {
    return CreatureTemplateEntity(
      aiName: aiNameController.collect(),
      armorModifier: armorModifierController.collect(),
      baseAttackTime: baseAttackTimeController.collect(),
      baseVariance: baseVarianceController.collect(),
      damageModifier: damageModifierController.collect(),
      difficultyEntry1: difficultyEntry1Controller.collect(),
      difficultyEntry2: difficultyEntry2Controller.collect(),
      difficultyEntry3: difficultyEntry3Controller.collect(),
      damageSchool: damageSchoolController.collect(),
      detectionRange: detectionRangeController.collect(),
      dynamicFlags: dynamicFlagsController.collect(),
      entry: entryController.collect(),
      exp: expController.collect(),
      experienceModifier: experienceModifierController.collect(),
      faction: factionController.collect(),
      family: familyController.collect(),
      flagsExtra: flagsExtraController.collect(),
      gossipMenuId: gossipMenuIdController.collect(),
      healthModifier: healthModifierController.collect(),
      hoverHeight: hoverHeightController.collect(),
      iconName: iconNameController.collect(),
      killCredit1: killCredit1Controller.collect(),
      killCredit2: killCredit2Controller.collect(),
      lootId: lootIdController.collect(),
      maxGold: maxGoldController.collect(),
      maxLevel: maxLevelController.collect(),
      manaModifier: manaModifierController.collect(),
      minLevel: minLevelController.collect(),
      minGold: minGoldController.collect(),
      movementId: movementIdController.collect(),
      movementType: movementTypeController.collect(),
      name: nameController.collect(),
      npcFlag: npcFlagController.collect(),
      petSpellDataId: petSpellDataIdController.collect(),
      pickpocketLoot: pickpocketLootController.collect(),
      racialLeader: racialLeaderController.collect(),
      rangeAttackTime: rangeAttackTimeController.collect(),
      rangeVariance: rangeVarianceController.collect(),
      rank: rankController.collect(),
      regenHealth: regenHealthController.collect(),
      scriptName: scriptNameController.collect(),
      skinLoot: skinLootController.collect(),
      speedFlight: speedFlightController.collect(),
      speedRun: speedRunController.collect(),
      speedSwim: speedSwimController.collect(),
      speedWalk: speedWalkController.collect(),
      subName: subNameController.collect(),
      type: typeController.collect(),
      typeFlags: typeFlagsController.collect(),
      unitClass: unitClassController.collect(),
      unitFlags: unitFlagsController.collect(),
      unitFlags2: unitFlags2Controller.collect(),
      vehicleId: vehicleIdController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
      creatureImmunitiesId: creatureImmunitiesIdController.collect(),
    );
  }

  void _logActivity(
    ActivityActionType action,
    CreatureTemplateEntity creatureTemplate,
  ) {}
}
