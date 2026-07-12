import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellDetailViewModel {
  final _repository = GetIt.instance.get<SpellRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// 主键展示（只读）；新建时由 [createSpell] 预填 MAX+1。
  final idController = IntFieldController();

  // === 基础文本 ===
  final nameLangZhCNController = StringFieldController();
  final nameSubtextLangZhCNController = StringFieldController();
  final descriptionLangZhCNController = StringFieldController();
  final auraDescriptionLangZhCNController = StringFieldController();
  final nameLangFlagsController = IntFieldController();
  final nameSubtextLangFlagsController = IntFieldController();
  final descriptionLangFlagsController = IntFieldController();
  final auraDescriptionLangFlagsController = IntFieldController();

  // === 图标/视觉 ===
  final spellIconIDController = IntFieldController();
  final activeIconIDController = IntFieldController();
  final spellVisualID0Controller = IntFieldController();
  final spellVisualID1Controller = IntFieldController();

  // === 分类/类型 ===
  final categoryController = IntFieldController();

  /// 冗余整数字段（历史保留）；UI 与 collect 以 [schoolMaskFlagController] 为准。
  final schoolMaskController = IntFieldController();
  final schoolMaskFlagController = FlagFieldController();
  final mechanicController = SelectFieldController<int>(fallback: 0);
  final defenseTypeController = SelectFieldController<int>(fallback: 0);
  final dispelTypeController = SelectFieldController<int>(fallback: 0);
  final preventionTypeController = SelectFieldController<int>(fallback: 0);

  // === 施法参数 ===
  final castingTimeIndexController = IntFieldController();
  final durationIndexController = IntFieldController();
  final rangeIndexController = IntFieldController();
  final spellDescriptionVariableIDController = IntFieldController();

  // === 等级 ===
  final baseLevelController = IntFieldController();
  final spellLevelController = IntFieldController();
  final maxLevelController = IntFieldController();
  final spellDifficultyIDController = IntFieldController();

  // === 冷却/恢复 ===
  final startRecoveryCategoryController = IntFieldController();
  final startRecoveryTimeController = IntFieldController();
  final recoveryTimeController = IntFieldController();
  final categoryRecoveryTimeController = IntFieldController();

  // === 目标 ===
  final targetCreatureTypeController = SelectFieldController<int>(fallback: 0);
  final targetsController = FlagFieldController();
  final maxTargetsController = IntFieldController();
  final maxTargetLevelController = IntFieldController();

  // === 状态 ===
  final casterAuraStateController = IntFieldController();
  final targetAuraStateController = IntFieldController();
  final spellMissileIDController = IntFieldController();
  final speedController = DoubleFieldController();

  // === 需求 ===
  final requiredAreasIDController = IntFieldController();
  final requiresSpellFocusController = IntFieldController();
  final facingCasterFlagsController = FlagFieldController();

  // === 能量消耗 ===
  final powerDisplayIDController = IntFieldController();
  final powerTypeController = SelectFieldController<int>(fallback: 0);
  final runeCostIDController = IntFieldController();
  final manaCostController = IntFieldController();
  final manaCostPctController = IntFieldController();
  final manaCostPerLevelController = IntFieldController();
  final manaPerSecondController = IntFieldController();
  final manaPerSecondPerLevelController = IntFieldController();

  // === 标志位 ===
  final interruptFlagsController = FlagFieldController();
  final auraInterruptFlagsController = FlagFieldController();
  final channelInterruptFlagsController = FlagFieldController();
  final attributesController = FlagFieldController();
  final attributesExController = FlagFieldController();
  final attributesExBController = FlagFieldController();
  final attributesExCController = FlagFieldController();
  final attributesExDController = FlagFieldController();
  final attributesExEController = FlagFieldController();
  final attributesExFController = FlagFieldController();
  final attributesExGController = FlagFieldController();

  // === 触发 ===
  final procTypeMaskController = FlagFieldController();
  final procChanceController = IntFieldController();
  final procChargesController = IntFieldController();

  // === 法术分类 ===
  final spellClassSetController = SelectFieldController<int>(fallback: 0);
  final spellClassMask0Controller = FlagFieldController();
  final spellClassMask1Controller = FlagFieldController();
  final spellClassMask2Controller = FlagFieldController();

  // === 效果0 ===
  final effect0Controller = SelectFieldController<int>(fallback: 0);
  final effectBasePoints0Controller = IntFieldController();
  final effectDieSides0Controller = IntFieldController();
  final effectRealPointsPerLevel0Controller = DoubleFieldController();
  final effectMechanic0Controller = SelectFieldController<int>(fallback: 0);
  final effectChainTargets0Controller = IntFieldController();
  final effectAura0Controller = SelectFieldController<int>(fallback: 0);
  final effectAuraPeriod0Controller = IntFieldController();
  final effectAmplitude0Controller = DoubleFieldController();
  final implicitTargetA0Controller = SelectFieldController<int>(fallback: 0);
  final implicitTargetB0Controller = SelectFieldController<int>(fallback: 0);
  final effectMiscValue0Controller = IntFieldController();
  final effectMiscValueB0Controller = IntFieldController();
  final effectRadiusIndex0Controller = IntFieldController();
  final effectChainAmplitude0Controller = DoubleFieldController();
  final effectBonusCoefficient0Controller = DoubleFieldController();
  final effectItemType0Controller = SelectFieldController<int>(fallback: 0);
  final effectTriggerSpell0Controller = IntFieldController();
  final effectPointsPerCombo0Controller = DoubleFieldController();
  final effectSpellClassMaskA0Controller = FlagFieldController();
  final effectSpellClassMaskB0Controller = FlagFieldController();
  final effectSpellClassMaskC0Controller = FlagFieldController();

  // === 效果1 ===
  final effect1Controller = SelectFieldController<int>(fallback: 0);
  final effectBasePoints1Controller = IntFieldController();
  final effectDieSides1Controller = IntFieldController();
  final effectRealPointsPerLevel1Controller = DoubleFieldController();
  final effectMechanic1Controller = SelectFieldController<int>(fallback: 0);
  final effectChainTargets1Controller = IntFieldController();
  final effectAura1Controller = SelectFieldController<int>(fallback: 0);
  final effectAuraPeriod1Controller = IntFieldController();
  final effectAmplitude1Controller = DoubleFieldController();
  final implicitTargetA1Controller = SelectFieldController<int>(fallback: 0);
  final implicitTargetB1Controller = SelectFieldController<int>(fallback: 0);
  final effectMiscValue1Controller = IntFieldController();
  final effectMiscValueB1Controller = IntFieldController();
  final effectRadiusIndex1Controller = IntFieldController();
  final effectChainAmplitude1Controller = DoubleFieldController();
  final effectBonusCoefficient1Controller = DoubleFieldController();
  final effectItemType1Controller = SelectFieldController<int>(fallback: 0);
  final effectTriggerSpell1Controller = IntFieldController();
  final effectPointsPerCombo1Controller = DoubleFieldController();
  final effectSpellClassMaskA1Controller = FlagFieldController();
  final effectSpellClassMaskB1Controller = FlagFieldController();
  final effectSpellClassMaskC1Controller = FlagFieldController();

  // === 效果2 ===
  final effect2Controller = SelectFieldController<int>(fallback: 0);
  final effectBasePoints2Controller = IntFieldController();
  final effectDieSides2Controller = IntFieldController();
  final effectRealPointsPerLevel2Controller = DoubleFieldController();
  final effectMechanic2Controller = SelectFieldController<int>(fallback: 0);
  final effectChainTargets2Controller = IntFieldController();
  final effectAura2Controller = SelectFieldController<int>(fallback: 0);
  final effectAuraPeriod2Controller = IntFieldController();
  final effectAmplitude2Controller = DoubleFieldController();
  final implicitTargetA2Controller = SelectFieldController<int>(fallback: 0);
  final implicitTargetB2Controller = SelectFieldController<int>(fallback: 0);
  final effectMiscValue2Controller = IntFieldController();
  final effectMiscValueB2Controller = IntFieldController();
  final effectRadiusIndex2Controller = IntFieldController();
  final effectChainAmplitude2Controller = DoubleFieldController();
  final effectBonusCoefficient2Controller = DoubleFieldController();
  final effectItemType2Controller = SelectFieldController<int>(fallback: 0);
  final effectTriggerSpell2Controller = IntFieldController();
  final effectPointsPerCombo2Controller = DoubleFieldController();
  final effectSpellClassMaskA2Controller = FlagFieldController();
  final effectSpellClassMaskB2Controller = FlagFieldController();
  final effectSpellClassMaskC2Controller = FlagFieldController();

  // === 装备限制 ===
  final equippedItemClassController = SelectFieldController<int>(fallback: 0);
  final equippedItemSubclassController = IntFieldController();
  final equippedItemInvTypesController = FlagFieldController();

  // === 图腾/施法材料 ===
  final requiredTotemCategoryID0Controller = IntFieldController();
  final totem0Controller = IntFieldController();
  final requiredTotemCategoryID1Controller = IntFieldController();
  final totem1Controller = IntFieldController();
  final reagent0Controller = IntFieldController();
  final reagent1Controller = IntFieldController();
  final reagent2Controller = IntFieldController();
  final reagent3Controller = IntFieldController();
  final reagent4Controller = IntFieldController();
  final reagent5Controller = IntFieldController();
  final reagent6Controller = IntFieldController();
  final reagent7Controller = IntFieldController();
  final reagentCount0Controller = IntFieldController();
  final reagentCount1Controller = IntFieldController();
  final reagentCount2Controller = IntFieldController();
  final reagentCount3Controller = IntFieldController();
  final reagentCount4Controller = IntFieldController();
  final reagentCount5Controller = IntFieldController();
  final reagentCount6Controller = IntFieldController();
  final reagentCount7Controller = IntFieldController();

  // === 其他高级属性 ===
  final casterAuraSpellController = IntFieldController();
  final cumulativeAuraController = IntFieldController();
  final minFactionIDController = IntFieldController();
  final minReputationController = SelectFieldController<int>(fallback: 0);
  final excludeCasterAuraStateController = SelectFieldController<int>(
    fallback: 0,
  );
  final excludeCasterAuraSpellController = IntFieldController();
  final excludeTargetAuraSpellController = IntFieldController();
  final excludeTargetAuraStateController = SelectFieldController<int>(
    fallback: 0,
  );
  final spellPriorityController = IntFieldController();
  final modalNextSpellController = IntFieldController();
  final requiredAuraVisionController = IntFieldController();
  final targetAuraSpellController = IntFieldController();
  final stanceBarOrderController = IntFieldController();
  final shapeshiftMask0Controller = FlagFieldController();
  final shapeshiftExclude0Controller = FlagFieldController();

  late final _controllers = <FieldController>[
    idController,
    nameLangZhCNController,
    nameSubtextLangZhCNController,
    descriptionLangZhCNController,
    auraDescriptionLangZhCNController,
    nameLangFlagsController,
    nameSubtextLangFlagsController,
    descriptionLangFlagsController,
    auraDescriptionLangFlagsController,
    spellIconIDController,
    activeIconIDController,
    spellVisualID0Controller,
    spellVisualID1Controller,
    categoryController,
    schoolMaskController,
    schoolMaskFlagController,
    mechanicController,
    defenseTypeController,
    dispelTypeController,
    preventionTypeController,
    castingTimeIndexController,
    durationIndexController,
    rangeIndexController,
    spellDescriptionVariableIDController,
    baseLevelController,
    spellLevelController,
    maxLevelController,
    spellDifficultyIDController,
    startRecoveryCategoryController,
    startRecoveryTimeController,
    recoveryTimeController,
    categoryRecoveryTimeController,
    targetCreatureTypeController,
    targetsController,
    maxTargetsController,
    maxTargetLevelController,
    casterAuraStateController,
    targetAuraStateController,
    spellMissileIDController,
    speedController,
    requiredAreasIDController,
    requiresSpellFocusController,
    facingCasterFlagsController,
    powerDisplayIDController,
    powerTypeController,
    runeCostIDController,
    manaCostController,
    manaCostPctController,
    manaCostPerLevelController,
    manaPerSecondController,
    manaPerSecondPerLevelController,
    interruptFlagsController,
    auraInterruptFlagsController,
    channelInterruptFlagsController,
    attributesController,
    attributesExController,
    attributesExBController,
    attributesExCController,
    attributesExDController,
    attributesExEController,
    attributesExFController,
    attributesExGController,
    procTypeMaskController,
    procChanceController,
    procChargesController,
    spellClassSetController,
    spellClassMask0Controller,
    spellClassMask1Controller,
    spellClassMask2Controller,
    effect0Controller,
    effectBasePoints0Controller,
    effectDieSides0Controller,
    effectRealPointsPerLevel0Controller,
    effectMechanic0Controller,
    effectChainTargets0Controller,
    effectAura0Controller,
    effectAuraPeriod0Controller,
    effectAmplitude0Controller,
    implicitTargetA0Controller,
    implicitTargetB0Controller,
    effectMiscValue0Controller,
    effectMiscValueB0Controller,
    effectRadiusIndex0Controller,
    effectChainAmplitude0Controller,
    effectBonusCoefficient0Controller,
    effectItemType0Controller,
    effectTriggerSpell0Controller,
    effectPointsPerCombo0Controller,
    effectSpellClassMaskA0Controller,
    effectSpellClassMaskB0Controller,
    effectSpellClassMaskC0Controller,
    effect1Controller,
    effectBasePoints1Controller,
    effectDieSides1Controller,
    effectRealPointsPerLevel1Controller,
    effectMechanic1Controller,
    effectChainTargets1Controller,
    effectAura1Controller,
    effectAuraPeriod1Controller,
    effectAmplitude1Controller,
    implicitTargetA1Controller,
    implicitTargetB1Controller,
    effectMiscValue1Controller,
    effectMiscValueB1Controller,
    effectRadiusIndex1Controller,
    effectChainAmplitude1Controller,
    effectBonusCoefficient1Controller,
    effectItemType1Controller,
    effectTriggerSpell1Controller,
    effectPointsPerCombo1Controller,
    effectSpellClassMaskA1Controller,
    effectSpellClassMaskB1Controller,
    effectSpellClassMaskC1Controller,
    effect2Controller,
    effectBasePoints2Controller,
    effectDieSides2Controller,
    effectRealPointsPerLevel2Controller,
    effectMechanic2Controller,
    effectChainTargets2Controller,
    effectAura2Controller,
    effectAuraPeriod2Controller,
    effectAmplitude2Controller,
    implicitTargetA2Controller,
    implicitTargetB2Controller,
    effectMiscValue2Controller,
    effectMiscValueB2Controller,
    effectRadiusIndex2Controller,
    effectChainAmplitude2Controller,
    effectBonusCoefficient2Controller,
    effectItemType2Controller,
    effectTriggerSpell2Controller,
    effectPointsPerCombo2Controller,
    effectSpellClassMaskA2Controller,
    effectSpellClassMaskB2Controller,
    effectSpellClassMaskC2Controller,
    equippedItemClassController,
    equippedItemSubclassController,
    equippedItemInvTypesController,
    requiredTotemCategoryID0Controller,
    totem0Controller,
    requiredTotemCategoryID1Controller,
    totem1Controller,
    reagent0Controller,
    reagent1Controller,
    reagent2Controller,
    reagent3Controller,
    reagent4Controller,
    reagent5Controller,
    reagent6Controller,
    reagent7Controller,
    reagentCount0Controller,
    reagentCount1Controller,
    reagentCount2Controller,
    reagentCount3Controller,
    reagentCount4Controller,
    reagentCount5Controller,
    reagentCount6Controller,
    reagentCount7Controller,
    casterAuraSpellController,
    cumulativeAuraController,
    minFactionIDController,
    minReputationController,
    excludeCasterAuraStateController,
    excludeCasterAuraSpellController,
    excludeTargetAuraSpellController,
    excludeTargetAuraStateController,
    spellPriorityController,
    modalNextSpellController,
    requiredAuraVisionController,
    targetAuraSpellController,
    stanceBarOrderController,
    shapeshiftMask0Controller,
    shapeshiftExclude0Controller,
  ];

  final id = signal(0);
  final spell = signal(SpellEntity());

  // === 联动信号：跟踪当前选择的枚举值，用于控制子字段 readonly/enabled ===
  final effect0Signal = signal<int>(0);
  final effect1Signal = signal<int>(0);
  final effect2Signal = signal<int>(0);
  final effectAura0Signal = signal<int>(0);
  final effectAura1Signal = signal<int>(0);
  final effectAura2Signal = signal<int>(0);
  final spellClassSetSignal = signal<int>(0);

  bool _effectSignalsWired = false;

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      final isCreate = (await _repository.getSpell(t.id)) == null;
      if (isCreate) {
        final newId = await _repository.storeSpell(t);
        id.value = newId;
        idController.init(newId);
        t = t.copyWith(id: newId);
      } else {
        await _repository.updateSpell(t);
      }
      spell.value = t;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('法术数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void applyNameLocales(List<DbcLocaleFieldValue> values) {
    spell.value = spell.value.copyWith(
      nameLangEnUS: values.valueOf('enUS'),
      nameLangKoKR: values.valueOf('koKR'),
      nameLangFrFR: values.valueOf('frFR'),
      nameLangDeDE: values.valueOf('deDE'),
      nameLangZhCN: values.valueOf('zhCN'),
      nameLangZhTW: values.valueOf('zhTW'),
      nameLangEsES: values.valueOf('esES'),
      nameLangEsMX: values.valueOf('esMX'),
      nameLangRuRU: values.valueOf('ruRU'),
      nameLangJaJP: values.valueOf('jaJP'),
      nameLangPtPT: values.valueOf('ptPT'),
      nameLangPtBR: values.valueOf('ptBR'),
      nameLangItIT: values.valueOf('itIT'),
      nameLangUnk1: values.valueOf('unk1'),
      nameLangUnk2: values.valueOf('unk2'),
      nameLangUnk3: values.valueOf('unk3'),
    );
    nameLangZhCNController.init(values.zhCN);
  }

  void applyNameSubtextLocales(List<DbcLocaleFieldValue> values) {
    spell.value = spell.value.copyWith(
      nameSubtextLangEnUS: values.valueOf('enUS'),
      nameSubtextLangKoKR: values.valueOf('koKR'),
      nameSubtextLangFrFR: values.valueOf('frFR'),
      nameSubtextLangDeDE: values.valueOf('deDE'),
      nameSubtextLangZhCN: values.valueOf('zhCN'),
      nameSubtextLangZhTW: values.valueOf('zhTW'),
      nameSubtextLangEsES: values.valueOf('esES'),
      nameSubtextLangEsMX: values.valueOf('esMX'),
      nameSubtextLangRuRU: values.valueOf('ruRU'),
      nameSubtextLangJaJP: values.valueOf('jaJP'),
      nameSubtextLangPtPT: values.valueOf('ptPT'),
      nameSubtextLangPtBR: values.valueOf('ptBR'),
      nameSubtextLangItIT: values.valueOf('itIT'),
      nameSubtextLangUnk1: values.valueOf('unk1'),
      nameSubtextLangUnk2: values.valueOf('unk2'),
      nameSubtextLangUnk3: values.valueOf('unk3'),
    );
    nameSubtextLangZhCNController.init(values.zhCN);
  }

  void applyDescriptionLocales(List<DbcLocaleFieldValue> values) {
    spell.value = spell.value.copyWith(
      descriptionLangEnUS: values.valueOf('enUS'),
      descriptionLangKoKR: values.valueOf('koKR'),
      descriptionLangFrFR: values.valueOf('frFR'),
      descriptionLangDeDE: values.valueOf('deDE'),
      descriptionLangZhCN: values.valueOf('zhCN'),
      descriptionLangZhTW: values.valueOf('zhTW'),
      descriptionLangEsES: values.valueOf('esES'),
      descriptionLangEsMX: values.valueOf('esMX'),
      descriptionLangRuRU: values.valueOf('ruRU'),
      descriptionLangJaJP: values.valueOf('jaJP'),
      descriptionLangPtPT: values.valueOf('ptPT'),
      descriptionLangPtBR: values.valueOf('ptBR'),
      descriptionLangItIT: values.valueOf('itIT'),
      descriptionLangUnk1: values.valueOf('unk1'),
      descriptionLangUnk2: values.valueOf('unk2'),
      descriptionLangUnk3: values.valueOf('unk3'),
    );
    descriptionLangZhCNController.init(values.zhCN);
  }

  void applyAuraDescriptionLocales(List<DbcLocaleFieldValue> values) {
    spell.value = spell.value.copyWith(
      auraDescriptionLangEnUS: values.valueOf('enUS'),
      auraDescriptionLangKoKR: values.valueOf('koKR'),
      auraDescriptionLangFrFR: values.valueOf('frFR'),
      auraDescriptionLangDeDE: values.valueOf('deDE'),
      auraDescriptionLangZhCN: values.valueOf('zhCN'),
      auraDescriptionLangZhTW: values.valueOf('zhTW'),
      auraDescriptionLangEsES: values.valueOf('esES'),
      auraDescriptionLangEsMX: values.valueOf('esMX'),
      auraDescriptionLangRuRU: values.valueOf('ruRU'),
      auraDescriptionLangJaJP: values.valueOf('jaJP'),
      auraDescriptionLangPtPT: values.valueOf('ptPT'),
      auraDescriptionLangPtBR: values.valueOf('ptBR'),
      auraDescriptionLangItIT: values.valueOf('itIT'),
      auraDescriptionLangUnk1: values.valueOf('unk1'),
      auraDescriptionLangUnk2: values.valueOf('unk2'),
      auraDescriptionLangUnk3: values.valueOf('unk3'),
    );
    auraDescriptionLangZhCNController.init(values.zhCN);
  }

  void pop() {
    routerFacade.goBack();
  }

  SpellEntity _collectFromControllers() {
    // 基于已加载实体覆盖 UI 字段，避免把未展示的多语言/扩展字段写成默认空值。
    return spell.value.copyWith(
      id: id.value,
      // === 基础文本 ===
      nameLangZhCN: nameLangZhCNController.collect(),
      nameSubtextLangZhCN: nameSubtextLangZhCNController.collect(),
      descriptionLangZhCN: descriptionLangZhCNController.collect(),
      auraDescriptionLangZhCN: auraDescriptionLangZhCNController.collect(),
      nameLangFlags: nameLangFlagsController.collect(),
      nameSubtextLangFlags: nameSubtextLangFlagsController.collect(),
      descriptionLangFlags: descriptionLangFlagsController.collect(),
      auraDescriptionLangFlags: auraDescriptionLangFlagsController.collect(),

      // === 图标/视觉 ===
      spellIconID: spellIconIDController.collect(),
      activeIconID: activeIconIDController.collect(),
      spellVisualID0: spellVisualID0Controller.collect(),
      spellVisualID1: spellVisualID1Controller.collect(),

      // === 分类/类型 ===
      category: categoryController.collect(),
      // schoolMask 以 Flag UI 为准（schoolMaskController 仅冗余保留）
      schoolMask: schoolMaskFlagController.collect(),
      mechanic: mechanicController.collect(),
      defenseType: defenseTypeController.collect(),
      dispelType: dispelTypeController.collect(),
      preventionType: preventionTypeController.collect(),

      // === 施法参数 ===
      castingTimeIndex: castingTimeIndexController.collect(),
      durationIndex: durationIndexController.collect(),
      rangeIndex: rangeIndexController.collect(),
      spellDescriptionVariableID: spellDescriptionVariableIDController
          .collect(),

      // === 等级 ===
      baseLevel: baseLevelController.collect(),
      spellLevel: spellLevelController.collect(),
      maxLevel: maxLevelController.collect(),
      spellDifficultyID: spellDifficultyIDController.collect(),

      // === 冷却/恢复 ===
      startRecoveryCategory: startRecoveryCategoryController.collect(),
      startRecoveryTime: startRecoveryTimeController.collect(),
      recoveryTime: recoveryTimeController.collect(),
      categoryRecoveryTime: categoryRecoveryTimeController.collect(),

      // === 目标 ===
      targetCreatureType: targetCreatureTypeController.collect(),
      targets: targetsController.collect(),
      maxTargets: maxTargetsController.collect(),
      maxTargetLevel: maxTargetLevelController.collect(),

      // === 状态 ===
      casterAuraState: casterAuraStateController.collect(),
      targetAuraState: targetAuraStateController.collect(),
      spellMissileID: spellMissileIDController.collect(),
      speed: speedController.collect(),

      // === 需求 ===
      requiredAreasID: requiredAreasIDController.collect(),
      requiresSpellFocus: requiresSpellFocusController.collect(),
      facingCasterFlags: facingCasterFlagsController.collect(),

      // === 能量消耗 ===
      powerDisplayID: powerDisplayIDController.collect(),
      powerType: powerTypeController.collect(),
      runeCostID: runeCostIDController.collect(),
      manaCost: manaCostController.collect(),
      manaCostPct: manaCostPctController.collect(),
      manaCostPerLevel: manaCostPerLevelController.collect(),
      manaPerSecond: manaPerSecondController.collect(),
      manaPerSecondPerLevel: manaPerSecondPerLevelController.collect(),

      // === 标志位 ===
      interruptFlags: interruptFlagsController.collect(),
      auraInterruptFlags: auraInterruptFlagsController.collect(),
      channelInterruptFlags: channelInterruptFlagsController.collect(),
      attributes: attributesController.collect(),
      attributesEx: attributesExController.collect(),
      attributesExB: attributesExBController.collect(),
      attributesExC: attributesExCController.collect(),
      attributesExD: attributesExDController.collect(),
      attributesExE: attributesExEController.collect(),
      attributesExF: attributesExFController.collect(),
      attributesExG: attributesExGController.collect(),

      // === 触发 ===
      procTypeMask: procTypeMaskController.collect(),
      procChance: procChanceController.collect(),
      procCharges: procChargesController.collect(),

      // === 法术分类 ===
      spellClassSet: spellClassSetController.collect(),
      spellClassMask0: spellClassMask0Controller.collect(),
      spellClassMask1: spellClassMask1Controller.collect(),
      spellClassMask2: spellClassMask2Controller.collect(),

      // === 效果0 ===
      effect0: effect0Controller.collect(),
      effectBasePoints0: effectBasePoints0Controller.collect(),
      effectDieSides0: effectDieSides0Controller.collect(),
      effectRealPointsPerLevel0: effectRealPointsPerLevel0Controller.collect(),
      effectMechanic0: effectMechanic0Controller.collect(),
      effectChainTargets0: effectChainTargets0Controller.collect(),
      effectAura0: effectAura0Controller.collect(),
      effectAuraPeriod0: effectAuraPeriod0Controller.collect(),
      effectAmplitude0: effectAmplitude0Controller.collect(),
      implicitTargetA0: implicitTargetA0Controller.collect(),
      implicitTargetB0: implicitTargetB0Controller.collect(),
      effectMiscValue0: effectMiscValue0Controller.collect(),
      effectMiscValueB0: effectMiscValueB0Controller.collect(),
      effectRadiusIndex0: effectRadiusIndex0Controller.collect(),
      effectChainAmplitude0: effectChainAmplitude0Controller.collect(),
      effectBonusCoefficient0: effectBonusCoefficient0Controller.collect(),
      effectItemType0: effectItemType0Controller.collect(),
      effectTriggerSpell0: effectTriggerSpell0Controller.collect(),
      effectPointsPerCombo0: effectPointsPerCombo0Controller.collect(),
      effectSpellClassMaskA0: effectSpellClassMaskA0Controller.collect(),
      effectSpellClassMaskB0: effectSpellClassMaskB0Controller.collect(),
      effectSpellClassMaskC0: effectSpellClassMaskC0Controller.collect(),

      // === 效果1 ===
      effect1: effect1Controller.collect(),
      effectBasePoints1: effectBasePoints1Controller.collect(),
      effectDieSides1: effectDieSides1Controller.collect(),
      effectRealPointsPerLevel1: effectRealPointsPerLevel1Controller.collect(),
      effectMechanic1: effectMechanic1Controller.collect(),
      effectChainTargets1: effectChainTargets1Controller.collect(),
      effectAura1: effectAura1Controller.collect(),
      effectAuraPeriod1: effectAuraPeriod1Controller.collect(),
      effectAmplitude1: effectAmplitude1Controller.collect(),
      implicitTargetA1: implicitTargetA1Controller.collect(),
      implicitTargetB1: implicitTargetB1Controller.collect(),
      effectMiscValue1: effectMiscValue1Controller.collect(),
      effectMiscValueB1: effectMiscValueB1Controller.collect(),
      effectRadiusIndex1: effectRadiusIndex1Controller.collect(),
      effectChainAmplitude1: effectChainAmplitude1Controller.collect(),
      effectBonusCoefficient1: effectBonusCoefficient1Controller.collect(),
      effectItemType1: effectItemType1Controller.collect(),
      effectTriggerSpell1: effectTriggerSpell1Controller.collect(),
      effectPointsPerCombo1: effectPointsPerCombo1Controller.collect(),
      effectSpellClassMaskA1: effectSpellClassMaskA1Controller.collect(),
      effectSpellClassMaskB1: effectSpellClassMaskB1Controller.collect(),
      effectSpellClassMaskC1: effectSpellClassMaskC1Controller.collect(),

      // === 效果2 ===
      effect2: effect2Controller.collect(),
      effectBasePoints2: effectBasePoints2Controller.collect(),
      effectDieSides2: effectDieSides2Controller.collect(),
      effectRealPointsPerLevel2: effectRealPointsPerLevel2Controller.collect(),
      effectMechanic2: effectMechanic2Controller.collect(),
      effectChainTargets2: effectChainTargets2Controller.collect(),
      effectAura2: effectAura2Controller.collect(),
      effectAuraPeriod2: effectAuraPeriod2Controller.collect(),
      effectAmplitude2: effectAmplitude2Controller.collect(),
      implicitTargetA2: implicitTargetA2Controller.collect(),
      implicitTargetB2: implicitTargetB2Controller.collect(),
      effectMiscValue2: effectMiscValue2Controller.collect(),
      effectMiscValueB2: effectMiscValueB2Controller.collect(),
      effectRadiusIndex2: effectRadiusIndex2Controller.collect(),
      effectChainAmplitude2: effectChainAmplitude2Controller.collect(),
      effectBonusCoefficient2: effectBonusCoefficient2Controller.collect(),
      effectItemType2: effectItemType2Controller.collect(),
      effectTriggerSpell2: effectTriggerSpell2Controller.collect(),
      effectPointsPerCombo2: effectPointsPerCombo2Controller.collect(),
      effectSpellClassMaskA2: effectSpellClassMaskA2Controller.collect(),
      effectSpellClassMaskB2: effectSpellClassMaskB2Controller.collect(),
      effectSpellClassMaskC2: effectSpellClassMaskC2Controller.collect(),

      // === 装备限制 ===
      equippedItemClass: equippedItemClassController.collect(),
      equippedItemSubclass: equippedItemSubclassController.collect(),
      equippedItemInvTypes: equippedItemInvTypesController.collect(),

      // === 图腾/施法材料 ===
      requiredTotemCategoryID0: requiredTotemCategoryID0Controller.collect(),
      totem0: totem0Controller.collect(),
      requiredTotemCategoryID1: requiredTotemCategoryID1Controller.collect(),
      totem1: totem1Controller.collect(),
      reagent0: reagent0Controller.collect(),
      reagent1: reagent1Controller.collect(),
      reagent2: reagent2Controller.collect(),
      reagent3: reagent3Controller.collect(),
      reagent4: reagent4Controller.collect(),
      reagent5: reagent5Controller.collect(),
      reagent6: reagent6Controller.collect(),
      reagent7: reagent7Controller.collect(),
      reagentCount0: reagentCount0Controller.collect(),
      reagentCount1: reagentCount1Controller.collect(),
      reagentCount2: reagentCount2Controller.collect(),
      reagentCount3: reagentCount3Controller.collect(),
      reagentCount4: reagentCount4Controller.collect(),
      reagentCount5: reagentCount5Controller.collect(),
      reagentCount6: reagentCount6Controller.collect(),
      reagentCount7: reagentCount7Controller.collect(),

      // === 其他高级属性 ===
      casterAuraSpell: casterAuraSpellController.collect(),
      cumulativeAura: cumulativeAuraController.collect(),
      minFactionID: minFactionIDController.collect(),
      minReputation: minReputationController.collect(),
      excludeCasterAuraSpell: excludeCasterAuraSpellController.collect(),
      excludeCasterAuraState: excludeCasterAuraStateController.collect(),
      excludeTargetAuraSpell: excludeTargetAuraSpellController.collect(),
      excludeTargetAuraState: excludeTargetAuraStateController.collect(),
      spellPriority: spellPriorityController.collect(),
      modalNextSpell: modalNextSpellController.collect(),
      requiredAuraVision: requiredAuraVisionController.collect(),
      targetAuraSpell: targetAuraSpellController.collect(),
      stanceBarOrder: stanceBarOrderController.collect(),
      shapeshiftMask0: shapeshiftMask0Controller.collect(),
      shapeshiftExclude0: shapeshiftExclude0Controller.collect(),
    );
  }

  void _logActivity(ActivityActionType action, SpellEntity t) {
    final log = ActivityLogEntity(
      module: 'spell',
      actionType: action,
      entityId: t.id,
      entityName: t.nameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createSpell();
        this.id.value = blank.id;
        spell.value = blank;
        _initControllers(blank);
        _wireEffectSignals();
        return;
      }
      this.id.value = id;
      final result = await _repository.getSpell(id);
      if (result == null) return;
      spell.value = result;
      _initControllers(result);
      _wireEffectSignals();
    } catch (e, s) {
      LoggerUtil.instance.e('加载法术(id=$id)失败', error: e, stackTrace: s);
    }
  }

  /// 监听 SelectFieldController 变化，同步到 signal。
  ///
  /// 使用 `selectController.controller.addListener` 是 ViewModel 侧允许的
  /// 联动例外（见 FIELD_CONTROLLER_MIGRATION / 迁移任务说明）。
  void _wireEffectSignals() {
    if (_effectSignalsWired) return;
    _effectSignalsWired = true;

    void sync(SelectFieldController<int> ctrl, Signal<int> sig) {
      sig.value = ctrl.collect();
      ctrl.controller.addListener(() => sig.value = ctrl.collect());
    }

    sync(effect0Controller, effect0Signal);
    sync(effect1Controller, effect1Signal);
    sync(effect2Controller, effect2Signal);
    sync(effectAura0Controller, effectAura0Signal);
    sync(effectAura1Controller, effectAura1Signal);
    sync(effectAura2Controller, effectAura2Signal);
    sync(spellClassSetController, spellClassSetSignal);
  }

  void _initControllers(SpellEntity template) {
    idController.init(template.id);
    // === 基础文本 ===
    nameLangZhCNController.init(template.nameLangZhCN);
    nameSubtextLangZhCNController.init(template.nameSubtextLangZhCN);
    descriptionLangZhCNController.init(template.descriptionLangZhCN);
    auraDescriptionLangZhCNController.init(template.auraDescriptionLangZhCN);
    nameLangFlagsController.init(template.nameLangFlags);
    nameSubtextLangFlagsController.init(template.nameSubtextLangFlags);
    descriptionLangFlagsController.init(template.descriptionLangFlags);
    auraDescriptionLangFlagsController.init(template.auraDescriptionLangFlags);

    // === 图标/视觉 ===
    spellIconIDController.init(template.spellIconID);
    activeIconIDController.init(template.activeIconID);
    spellVisualID0Controller.init(template.spellVisualID0);
    spellVisualID1Controller.init(template.spellVisualID1);

    // === 分类/类型 ===
    categoryController.init(template.category);
    schoolMaskController.init(template.schoolMask);
    schoolMaskFlagController.init(template.schoolMask);
    mechanicController.init(template.mechanic);
    defenseTypeController.init(template.defenseType);
    dispelTypeController.init(template.dispelType);
    preventionTypeController.init(template.preventionType);

    // === 施法参数 ===
    castingTimeIndexController.init(template.castingTimeIndex);
    durationIndexController.init(template.durationIndex);
    rangeIndexController.init(template.rangeIndex);
    spellDescriptionVariableIDController.init(
      template.spellDescriptionVariableID,
    );

    // === 等级 ===
    baseLevelController.init(template.baseLevel);
    spellLevelController.init(template.spellLevel);
    maxLevelController.init(template.maxLevel);
    spellDifficultyIDController.init(template.spellDifficultyID);

    // === 冷却/恢复 ===
    startRecoveryCategoryController.init(template.startRecoveryCategory);
    startRecoveryTimeController.init(template.startRecoveryTime);
    recoveryTimeController.init(template.recoveryTime);
    categoryRecoveryTimeController.init(template.categoryRecoveryTime);

    // === 目标 ===
    targetCreatureTypeController.init(template.targetCreatureType);
    targetsController.init(template.targets);
    maxTargetsController.init(template.maxTargets);
    maxTargetLevelController.init(template.maxTargetLevel);

    // === 状态 ===
    casterAuraStateController.init(template.casterAuraState);
    targetAuraStateController.init(template.targetAuraState);
    spellMissileIDController.init(template.spellMissileID);
    speedController.init(template.speed);

    // === 需求 ===
    requiredAreasIDController.init(template.requiredAreasID);
    requiresSpellFocusController.init(template.requiresSpellFocus);
    facingCasterFlagsController.init(template.facingCasterFlags);

    // === 能量消耗 ===
    powerDisplayIDController.init(template.powerDisplayID);
    powerTypeController.init(template.powerType);
    runeCostIDController.init(template.runeCostID);
    manaCostController.init(template.manaCost);
    manaCostPctController.init(template.manaCostPct);
    manaCostPerLevelController.init(template.manaCostPerLevel);
    manaPerSecondController.init(template.manaPerSecond);
    manaPerSecondPerLevelController.init(template.manaPerSecondPerLevel);

    // === 标志位 ===
    interruptFlagsController.init(template.interruptFlags);
    auraInterruptFlagsController.init(template.auraInterruptFlags);
    channelInterruptFlagsController.init(template.channelInterruptFlags);
    attributesController.init(template.attributes);
    attributesExController.init(template.attributesEx);
    attributesExBController.init(template.attributesExB);
    attributesExCController.init(template.attributesExC);
    attributesExDController.init(template.attributesExD);
    attributesExEController.init(template.attributesExE);
    attributesExFController.init(template.attributesExF);
    attributesExGController.init(template.attributesExG);

    // === 触发 ===
    procTypeMaskController.init(template.procTypeMask);
    procChanceController.init(template.procChance);
    procChargesController.init(template.procCharges);

    // === 法术分类 ===
    spellClassSetController.init(template.spellClassSet);
    spellClassMask0Controller.init(template.spellClassMask0);
    spellClassMask1Controller.init(template.spellClassMask1);
    spellClassMask2Controller.init(template.spellClassMask2);

    // === 效果0 ===
    effect0Controller.init(template.effect0);
    effectBasePoints0Controller.init(template.effectBasePoints0);
    effectDieSides0Controller.init(template.effectDieSides0);
    effectRealPointsPerLevel0Controller.init(
      template.effectRealPointsPerLevel0,
    );
    effectMechanic0Controller.init(template.effectMechanic0);
    effectChainTargets0Controller.init(template.effectChainTargets0);
    effectAura0Controller.init(template.effectAura0);
    effectAuraPeriod0Controller.init(template.effectAuraPeriod0);
    effectAmplitude0Controller.init(template.effectAmplitude0);
    implicitTargetA0Controller.init(template.implicitTargetA0);
    implicitTargetB0Controller.init(template.implicitTargetB0);
    effectMiscValue0Controller.init(template.effectMiscValue0);
    effectMiscValueB0Controller.init(template.effectMiscValueB0);
    effectRadiusIndex0Controller.init(template.effectRadiusIndex0);
    effectChainAmplitude0Controller.init(template.effectChainAmplitude0);
    effectBonusCoefficient0Controller.init(template.effectBonusCoefficient0);
    effectItemType0Controller.init(template.effectItemType0);
    effectTriggerSpell0Controller.init(template.effectTriggerSpell0);
    effectPointsPerCombo0Controller.init(template.effectPointsPerCombo0);
    effectSpellClassMaskA0Controller.init(template.effectSpellClassMaskA0);
    effectSpellClassMaskB0Controller.init(template.effectSpellClassMaskB0);
    effectSpellClassMaskC0Controller.init(template.effectSpellClassMaskC0);

    // === 效果1 ===
    effect1Controller.init(template.effect1);
    effectBasePoints1Controller.init(template.effectBasePoints1);
    effectDieSides1Controller.init(template.effectDieSides1);
    effectRealPointsPerLevel1Controller.init(
      template.effectRealPointsPerLevel1,
    );
    effectMechanic1Controller.init(template.effectMechanic1);
    effectChainTargets1Controller.init(template.effectChainTargets1);
    effectAura1Controller.init(template.effectAura1);
    effectAuraPeriod1Controller.init(template.effectAuraPeriod1);
    effectAmplitude1Controller.init(template.effectAmplitude1);
    implicitTargetA1Controller.init(template.implicitTargetA1);
    implicitTargetB1Controller.init(template.implicitTargetB1);
    effectMiscValue1Controller.init(template.effectMiscValue1);
    effectMiscValueB1Controller.init(template.effectMiscValueB1);
    effectRadiusIndex1Controller.init(template.effectRadiusIndex1);
    effectChainAmplitude1Controller.init(template.effectChainAmplitude1);
    effectBonusCoefficient1Controller.init(template.effectBonusCoefficient1);
    effectItemType1Controller.init(template.effectItemType1);
    effectTriggerSpell1Controller.init(template.effectTriggerSpell1);
    effectPointsPerCombo1Controller.init(template.effectPointsPerCombo1);
    effectSpellClassMaskA1Controller.init(template.effectSpellClassMaskA1);
    effectSpellClassMaskB1Controller.init(template.effectSpellClassMaskB1);
    effectSpellClassMaskC1Controller.init(template.effectSpellClassMaskC1);

    // === 效果2 ===
    effect2Controller.init(template.effect2);
    effectBasePoints2Controller.init(template.effectBasePoints2);
    effectDieSides2Controller.init(template.effectDieSides2);
    effectRealPointsPerLevel2Controller.init(
      template.effectRealPointsPerLevel2,
    );
    effectMechanic2Controller.init(template.effectMechanic2);
    effectChainTargets2Controller.init(template.effectChainTargets2);
    effectAura2Controller.init(template.effectAura2);
    effectAuraPeriod2Controller.init(template.effectAuraPeriod2);
    effectAmplitude2Controller.init(template.effectAmplitude2);
    implicitTargetA2Controller.init(template.implicitTargetA2);
    implicitTargetB2Controller.init(template.implicitTargetB2);
    effectMiscValue2Controller.init(template.effectMiscValue2);
    effectMiscValueB2Controller.init(template.effectMiscValueB2);
    effectRadiusIndex2Controller.init(template.effectRadiusIndex2);
    effectChainAmplitude2Controller.init(template.effectChainAmplitude2);
    effectBonusCoefficient2Controller.init(template.effectBonusCoefficient2);
    effectItemType2Controller.init(template.effectItemType2);
    effectTriggerSpell2Controller.init(template.effectTriggerSpell2);
    effectPointsPerCombo2Controller.init(template.effectPointsPerCombo2);
    effectSpellClassMaskA2Controller.init(template.effectSpellClassMaskA2);
    effectSpellClassMaskB2Controller.init(template.effectSpellClassMaskB2);
    effectSpellClassMaskC2Controller.init(template.effectSpellClassMaskC2);

    // === 装备限制 ===
    equippedItemClassController.init(template.equippedItemClass);
    equippedItemSubclassController.init(template.equippedItemSubclass);
    equippedItemInvTypesController.init(template.equippedItemInvTypes);

    // === 图腾/施法材料 ===
    requiredTotemCategoryID0Controller.init(template.requiredTotemCategoryID0);
    totem0Controller.init(template.totem0);
    requiredTotemCategoryID1Controller.init(template.requiredTotemCategoryID1);
    totem1Controller.init(template.totem1);
    reagent0Controller.init(template.reagent0);
    reagent1Controller.init(template.reagent1);
    reagent2Controller.init(template.reagent2);
    reagent3Controller.init(template.reagent3);
    reagent4Controller.init(template.reagent4);
    reagent5Controller.init(template.reagent5);
    reagent6Controller.init(template.reagent6);
    reagent7Controller.init(template.reagent7);
    reagentCount0Controller.init(template.reagentCount0);
    reagentCount1Controller.init(template.reagentCount1);
    reagentCount2Controller.init(template.reagentCount2);
    reagentCount3Controller.init(template.reagentCount3);
    reagentCount4Controller.init(template.reagentCount4);
    reagentCount5Controller.init(template.reagentCount5);
    reagentCount6Controller.init(template.reagentCount6);
    reagentCount7Controller.init(template.reagentCount7);

    // === 其他高级属性 ===
    casterAuraSpellController.init(template.casterAuraSpell);
    cumulativeAuraController.init(template.cumulativeAura);
    minFactionIDController.init(template.minFactionID);
    minReputationController.init(template.minReputation);
    excludeCasterAuraSpellController.init(template.excludeCasterAuraSpell);
    excludeCasterAuraStateController.init(template.excludeCasterAuraState);
    excludeTargetAuraSpellController.init(template.excludeTargetAuraSpell);
    excludeTargetAuraStateController.init(template.excludeTargetAuraState);
    spellPriorityController.init(template.spellPriority);
    modalNextSpellController.init(template.modalNextSpell);
    requiredAuraVisionController.init(template.requiredAuraVision);
    targetAuraSpellController.init(template.targetAuraSpell);
    stanceBarOrderController.init(template.stanceBarOrder);
    shapeshiftMask0Controller.init(template.shapeshiftMask0);
    shapeshiftExclude0Controller.init(template.shapeshiftExclude0);
  }
}
