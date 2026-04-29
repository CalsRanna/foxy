import 'package:flutter/widgets.dart';
import 'package:foxy/model/activity_log.dart';
import 'package:foxy/model/spell.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  // === 基础文本 ===
  final nameLangZhCNController = TextEditingController();
  final nameSubtextLangZhCNController = TextEditingController();
  final descriptionLangZhCNController = TextEditingController();
  final auraDescriptionLangZhCNController = TextEditingController();
  final nameLangFlagsController = TextEditingController();
  final nameSubtextLangFlagsController = TextEditingController();
  final descriptionLangFlagsController = TextEditingController();
  final auraDescriptionLangFlagsController = TextEditingController();

  // === 图标/视觉 ===
  final spellIconIDController = TextEditingController();
  final activeIconIDController = TextEditingController();
  final spellVisualID0Controller = TextEditingController();
  final spellVisualID1Controller = TextEditingController();

  // === 分类/类型 ===
  final categoryController = TextEditingController();
  final schoolMaskController = TextEditingController();
  final mechanicController = TextEditingController();
  final defenseTypeController = TextEditingController();
  final dispelTypeController = TextEditingController();
  final preventionTypeController = TextEditingController();

  // === 施法参数 ===
  final castingTimeIndexController = TextEditingController();
  final durationIndexController = TextEditingController();
  final rangeIndexController = TextEditingController();
  final spellDescriptionVariableIDController = TextEditingController();

  // === 等级 ===
  final baseLevelController = TextEditingController();
  final spellLevelController = TextEditingController();
  final maxLevelController = TextEditingController();
  final spellDifficultyIDController = TextEditingController();

  // === 冷却/恢复 ===
  final startRecoveryCategoryController = TextEditingController();
  final startRecoveryTimeController = TextEditingController();
  final recoveryTimeController = TextEditingController();
  final categoryRecoveryTimeController = TextEditingController();

  // === 目标 ===
  final targetCreatureTypeController = TextEditingController();
  final targetsController = TextEditingController();
  final maxTargetsController = TextEditingController();
  final maxTargetLevelController = TextEditingController();

  // === 状态 ===
  final casterAuraStateController = TextEditingController();
  final targetAuraStateController = TextEditingController();
  final spellMissileIDController = TextEditingController();
  final speedController = TextEditingController();

  // === 需求 ===
  final requiredAreasIDController = TextEditingController();
  final requiresSpellFocusController = TextEditingController();
  final facingCasterFlagsController = TextEditingController();

  // === 能量消耗 ===
  final powerDisplayIDController = TextEditingController();
  final powerTypeController = TextEditingController();
  final runeCostIDController = TextEditingController();
  final manaCostController = TextEditingController();
  final manaCostPctController = TextEditingController();
  final manaCostPerLevelController = TextEditingController();
  final manaPerSecondController = TextEditingController();
  final manaPerSecondPerLevelController = TextEditingController();

  // === 标志位 ===
  final interruptFlagsController = TextEditingController();
  final auraInterruptFlagsController = TextEditingController();
  final channelInterruptFlagsController = TextEditingController();
  final attributesController = TextEditingController();
  final attributesExController = TextEditingController();
  final attributesExBController = TextEditingController();
  final attributesExCController = TextEditingController();
  final attributesExDController = TextEditingController();
  final attributesExEController = TextEditingController();
  final attributesExFController = TextEditingController();
  final attributesExGController = TextEditingController();

  // === 触发 ===
  final procTypeMaskController = TextEditingController();
  final procChanceController = TextEditingController();
  final procChargesController = TextEditingController();

  // === 法术分类 ===
  final spellClassSetController = TextEditingController();
  final spellClassMask0Controller = TextEditingController();
  final spellClassMask1Controller = TextEditingController();
  final spellClassMask2Controller = TextEditingController();

  // === 效果0 ===
  final effect0Controller = TextEditingController();
  final effectBasePoints0Controller = TextEditingController();
  final effectDieSides0Controller = TextEditingController();
  final effectRealPointsPerLevel0Controller = TextEditingController();
  final effectMechanic0Controller = TextEditingController();
  final effectChainTargets0Controller = TextEditingController();
  final effectAura0Controller = TextEditingController();
  final effectAuraPeriod0Controller = TextEditingController();
  final effectAmplitude0Controller = TextEditingController();
  final implicitTargetA0Controller = TextEditingController();
  final implicitTargetB0Controller = TextEditingController();
  final effectMiscValue0Controller = TextEditingController();
  final effectMiscValueB0Controller = TextEditingController();
  final effectRadiusIndex0Controller = TextEditingController();
  final effectChainAmplitude0Controller = TextEditingController();
  final effectBonusCoefficient0Controller = TextEditingController();
  final effectItemType0Controller = TextEditingController();
  final effectTriggerSpell0Controller = TextEditingController();
  final effectPointsPerCombo0Controller = TextEditingController();
  final effectSpellClassMaskA0Controller = TextEditingController();
  final effectSpellClassMaskB0Controller = TextEditingController();
  final effectSpellClassMaskC0Controller = TextEditingController();

  // === 效果1 ===
  final effect1Controller = TextEditingController();
  final effectBasePoints1Controller = TextEditingController();
  final effectDieSides1Controller = TextEditingController();
  final effectRealPointsPerLevel1Controller = TextEditingController();
  final effectMechanic1Controller = TextEditingController();
  final effectChainTargets1Controller = TextEditingController();
  final effectAura1Controller = TextEditingController();
  final effectAuraPeriod1Controller = TextEditingController();
  final effectAmplitude1Controller = TextEditingController();
  final implicitTargetA1Controller = TextEditingController();
  final implicitTargetB1Controller = TextEditingController();
  final effectMiscValue1Controller = TextEditingController();
  final effectMiscValueB1Controller = TextEditingController();
  final effectRadiusIndex1Controller = TextEditingController();
  final effectChainAmplitude1Controller = TextEditingController();
  final effectBonusCoefficient1Controller = TextEditingController();
  final effectItemType1Controller = TextEditingController();
  final effectTriggerSpell1Controller = TextEditingController();
  final effectPointsPerCombo1Controller = TextEditingController();
  final effectSpellClassMaskA1Controller = TextEditingController();
  final effectSpellClassMaskB1Controller = TextEditingController();
  final effectSpellClassMaskC1Controller = TextEditingController();

  // === 效果2 ===
  final effect2Controller = TextEditingController();
  final effectBasePoints2Controller = TextEditingController();
  final effectDieSides2Controller = TextEditingController();
  final effectRealPointsPerLevel2Controller = TextEditingController();
  final effectMechanic2Controller = TextEditingController();
  final effectChainTargets2Controller = TextEditingController();
  final effectAura2Controller = TextEditingController();
  final effectAuraPeriod2Controller = TextEditingController();
  final effectAmplitude2Controller = TextEditingController();
  final implicitTargetA2Controller = TextEditingController();
  final implicitTargetB2Controller = TextEditingController();
  final effectMiscValue2Controller = TextEditingController();
  final effectMiscValueB2Controller = TextEditingController();
  final effectRadiusIndex2Controller = TextEditingController();
  final effectChainAmplitude2Controller = TextEditingController();
  final effectBonusCoefficient2Controller = TextEditingController();
  final effectItemType2Controller = TextEditingController();
  final effectTriggerSpell2Controller = TextEditingController();
  final effectPointsPerCombo2Controller = TextEditingController();
  final effectSpellClassMaskA2Controller = TextEditingController();
  final effectSpellClassMaskB2Controller = TextEditingController();
  final effectSpellClassMaskC2Controller = TextEditingController();

  // === 装备限制 ===
  final equippedItemClassController = TextEditingController();
  final equippedItemSubclassController = TextEditingController();
  final equippedItemInvTypesController = TextEditingController();

  // === 图腾/施法材料 ===
  final requiredTotemCategoryID0Controller = TextEditingController();
  final totem0Controller = TextEditingController();
  final requiredTotemCategoryID1Controller = TextEditingController();
  final totem1Controller = TextEditingController();
  final reagent0Controller = TextEditingController();
  final reagent1Controller = TextEditingController();
  final reagent2Controller = TextEditingController();
  final reagent3Controller = TextEditingController();
  final reagent4Controller = TextEditingController();
  final reagent5Controller = TextEditingController();
  final reagent6Controller = TextEditingController();
  final reagent7Controller = TextEditingController();
  final reagentCount0Controller = TextEditingController();
  final reagentCount1Controller = TextEditingController();
  final reagentCount2Controller = TextEditingController();
  final reagentCount3Controller = TextEditingController();
  final reagentCount4Controller = TextEditingController();
  final reagentCount5Controller = TextEditingController();
  final reagentCount6Controller = TextEditingController();
  final reagentCount7Controller = TextEditingController();

  // === 其他高级属性 ===
  final casterAuraSpellController = TextEditingController();
  final cumulativeAuraController = TextEditingController();
  final minFactionIDController = TextEditingController();
  final minReputationController = TextEditingController();
  final excludeCasterAuraSpellController = TextEditingController();
  final excludeCasterAuraStateController = TextEditingController();
  final excludeTargetAuraSpellController = TextEditingController();
  final excludeTargetAuraStateController = TextEditingController();
  final spellPriorityController = TextEditingController();
  final modalNextSpellController = TextEditingController();
  final requiredAuraVisionController = TextEditingController();
  final targetAuraSpellController = TextEditingController();
  final stanceBarOrderController = TextEditingController();
  final shapeshiftMask0Controller = TextEditingController();
  final shapeshiftExclude0Controller = TextEditingController();

  final id = signal(0);
  final spell = signal(Spell());
  final saving = signal(false);

  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final t = _collectFromControllers();
      final repository = SpellRepository();
      if (t.id == 0) {
        await repository.storeSpell(t);
      } else {
        await repository.updateSpell(t);
      }
      spell.value = t;
      _logActivity(t.id == 0 ? ActivityActionType.create : ActivityActionType.update, t);
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('法术数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    } finally {
      saving.value = false;
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Spell _collectFromControllers() {
    final t = Spell(

    // === 基础文本 ===
      nameLangZhCN: nameLangZhCNController.text,
      nameSubtextLangZhCN: nameSubtextLangZhCNController.text,
      descriptionLangZhCN: descriptionLangZhCNController.text,
      auraDescriptionLangZhCN: auraDescriptionLangZhCNController.text,
      nameLangFlags: _parseInt(nameLangFlagsController.text),
      nameSubtextLangFlags: _parseInt(nameSubtextLangFlagsController.text),
      descriptionLangFlags: _parseInt(descriptionLangFlagsController.text),
      auraDescriptionLangFlags: _parseInt(
      auraDescriptionLangFlagsController.text,
    ),

    // === 图标/视觉 ===
      spellIconID: _parseInt(spellIconIDController.text),
      activeIconID: _parseInt(activeIconIDController.text),
      spellVisualID0: _parseInt(spellVisualID0Controller.text),
      spellVisualID1: _parseInt(spellVisualID1Controller.text),

    // === 分类/类型 ===
      category: _parseInt(categoryController.text),
      schoolMask: _parseInt(schoolMaskController.text),
      mechanic: _parseInt(mechanicController.text),
      defenseType: _parseInt(defenseTypeController.text),
      dispelType: _parseInt(dispelTypeController.text),
      preventionType: _parseInt(preventionTypeController.text),

    // === 施法参数 ===
      castingTimeIndex: _parseInt(castingTimeIndexController.text),
      durationIndex: _parseInt(durationIndexController.text),
      rangeIndex: _parseInt(rangeIndexController.text),
      spellDescriptionVariableID: _parseInt(
      spellDescriptionVariableIDController.text,
    ),

    // === 等级 ===
      baseLevel: _parseInt(baseLevelController.text),
      spellLevel: _parseInt(spellLevelController.text),
      maxLevel: _parseInt(maxLevelController.text),
      spellDifficultyID: _parseInt(spellDifficultyIDController.text),

    // === 冷却/恢复 ===
      startRecoveryCategory: _parseInt(startRecoveryCategoryController.text),
      startRecoveryTime: _parseInt(startRecoveryTimeController.text),
      recoveryTime: _parseInt(recoveryTimeController.text),
      categoryRecoveryTime: _parseInt(categoryRecoveryTimeController.text),

    // === 目标 ===
      targetCreatureType: _parseInt(targetCreatureTypeController.text),
      targets: _parseInt(targetsController.text),
      maxTargets: _parseInt(maxTargetsController.text),
      maxTargetLevel: _parseInt(maxTargetLevelController.text),

    // === 状态 ===
      casterAuraState: _parseInt(casterAuraStateController.text),
      targetAuraState: _parseInt(targetAuraStateController.text),
      spellMissileID: _parseInt(spellMissileIDController.text),
      speed: _parseDouble(speedController.text),

    // === 需求 ===
      requiredAreasID: _parseInt(requiredAreasIDController.text),
      requiresSpellFocus: _parseInt(requiresSpellFocusController.text),
      facingCasterFlags: _parseInt(facingCasterFlagsController.text),

    // === 能量消耗 ===
      powerDisplayID: _parseInt(powerDisplayIDController.text),
      powerType: _parseInt(powerTypeController.text),
      runeCostID: _parseInt(runeCostIDController.text),
      manaCost: _parseInt(manaCostController.text),
      manaCostPct: _parseInt(manaCostPctController.text),
      manaCostPerLevel: _parseInt(manaCostPerLevelController.text),
      manaPerSecond: _parseInt(manaPerSecondController.text),
      manaPerSecondPerLevel: _parseInt(manaPerSecondPerLevelController.text),

    // === 标志位 ===
      interruptFlags: _parseInt(interruptFlagsController.text),
      auraInterruptFlags: _parseInt(auraInterruptFlagsController.text),
      channelInterruptFlags: _parseInt(channelInterruptFlagsController.text),
      attributes: _parseInt(attributesController.text),
      attributesEx: _parseInt(attributesExController.text),
      attributesExB: _parseInt(attributesExBController.text),
      attributesExC: _parseInt(attributesExCController.text),
      attributesExD: _parseInt(attributesExDController.text),
      attributesExE: _parseInt(attributesExEController.text),
      attributesExF: _parseInt(attributesExFController.text),
      attributesExG: _parseInt(attributesExGController.text),

    // === 触发 ===
      procTypeMask: _parseInt(procTypeMaskController.text),
      procChance: _parseInt(procChanceController.text),
      procCharges: _parseInt(procChargesController.text),

    // === 法术分类 ===
      spellClassSet: _parseInt(spellClassSetController.text),
      spellClassMask0: _parseInt(spellClassMask0Controller.text),
      spellClassMask1: _parseInt(spellClassMask1Controller.text),
      spellClassMask2: _parseInt(spellClassMask2Controller.text),

    // === 效果0 ===
      effect0: _parseInt(effect0Controller.text),
      effectBasePoints0: _parseInt(effectBasePoints0Controller.text),
      effectDieSides0: _parseInt(effectDieSides0Controller.text),
      effectRealPointsPerLevel0: _parseDouble(
      effectRealPointsPerLevel0Controller.text,
    ),
      effectMechanic0: _parseInt(effectMechanic0Controller.text),
      effectChainTargets0: _parseInt(effectChainTargets0Controller.text),
      effectAura0: _parseInt(effectAura0Controller.text),
      effectAuraPeriod0: _parseInt(effectAuraPeriod0Controller.text),
      effectAmplitude0: _parseDouble(effectAmplitude0Controller.text),
      implicitTargetA0: _parseInt(implicitTargetA0Controller.text),
      implicitTargetB0: _parseInt(implicitTargetB0Controller.text),
      effectMiscValue0: _parseInt(effectMiscValue0Controller.text),
      effectMiscValueB0: _parseInt(effectMiscValueB0Controller.text),
      effectRadiusIndex0: _parseInt(effectRadiusIndex0Controller.text),
      effectChainAmplitude0: _parseDouble(
      effectChainAmplitude0Controller.text,
    ),
      effectBonusCoefficient0: _parseDouble(
      effectBonusCoefficient0Controller.text,
    ),
      effectItemType0: _parseInt(effectItemType0Controller.text),
      effectTriggerSpell0: _parseInt(effectTriggerSpell0Controller.text),
      effectPointsPerCombo0: _parseDouble(
      effectPointsPerCombo0Controller.text,
    ),
      effectSpellClassMaskA0: _parseInt(effectSpellClassMaskA0Controller.text),
      effectSpellClassMaskB0: _parseInt(effectSpellClassMaskB0Controller.text),
      effectSpellClassMaskC0: _parseInt(effectSpellClassMaskC0Controller.text),

    // === 效果1 ===
      effect1: _parseInt(effect1Controller.text),
      effectBasePoints1: _parseInt(effectBasePoints1Controller.text),
      effectDieSides1: _parseInt(effectDieSides1Controller.text),
      effectRealPointsPerLevel1: _parseDouble(
      effectRealPointsPerLevel1Controller.text,
    ),
      effectMechanic1: _parseInt(effectMechanic1Controller.text),
      effectChainTargets1: _parseInt(effectChainTargets1Controller.text),
      effectAura1: _parseInt(effectAura1Controller.text),
      effectAuraPeriod1: _parseInt(effectAuraPeriod1Controller.text),
      effectAmplitude1: _parseDouble(effectAmplitude1Controller.text),
      implicitTargetA1: _parseInt(implicitTargetA1Controller.text),
      implicitTargetB1: _parseInt(implicitTargetB1Controller.text),
      effectMiscValue1: _parseInt(effectMiscValue1Controller.text),
      effectMiscValueB1: _parseInt(effectMiscValueB1Controller.text),
      effectRadiusIndex1: _parseInt(effectRadiusIndex1Controller.text),
      effectChainAmplitude1: _parseDouble(
      effectChainAmplitude1Controller.text,
    ),
      effectBonusCoefficient1: _parseDouble(
      effectBonusCoefficient1Controller.text,
    ),
      effectItemType1: _parseInt(effectItemType1Controller.text),
      effectTriggerSpell1: _parseInt(effectTriggerSpell1Controller.text),
      effectPointsPerCombo1: _parseDouble(
      effectPointsPerCombo1Controller.text,
    ),
      effectSpellClassMaskA1: _parseInt(effectSpellClassMaskA1Controller.text),
      effectSpellClassMaskB1: _parseInt(effectSpellClassMaskB1Controller.text),
      effectSpellClassMaskC1: _parseInt(effectSpellClassMaskC1Controller.text),

    // === 效果2 ===
      effect2: _parseInt(effect2Controller.text),
      effectBasePoints2: _parseInt(effectBasePoints2Controller.text),
      effectDieSides2: _parseInt(effectDieSides2Controller.text),
      effectRealPointsPerLevel2: _parseDouble(
      effectRealPointsPerLevel2Controller.text,
    ),
      effectMechanic2: _parseInt(effectMechanic2Controller.text),
      effectChainTargets2: _parseInt(effectChainTargets2Controller.text),
      effectAura2: _parseInt(effectAura2Controller.text),
      effectAuraPeriod2: _parseInt(effectAuraPeriod2Controller.text),
      effectAmplitude2: _parseDouble(effectAmplitude2Controller.text),
      implicitTargetA2: _parseInt(implicitTargetA2Controller.text),
      implicitTargetB2: _parseInt(implicitTargetB2Controller.text),
      effectMiscValue2: _parseInt(effectMiscValue2Controller.text),
      effectMiscValueB2: _parseInt(effectMiscValueB2Controller.text),
      effectRadiusIndex2: _parseInt(effectRadiusIndex2Controller.text),
      effectChainAmplitude2: _parseDouble(
      effectChainAmplitude2Controller.text,
    ),
      effectBonusCoefficient2: _parseDouble(
      effectBonusCoefficient2Controller.text,
    ),
      effectItemType2: _parseInt(effectItemType2Controller.text),
      effectTriggerSpell2: _parseInt(effectTriggerSpell2Controller.text),
      effectPointsPerCombo2: _parseDouble(
      effectPointsPerCombo2Controller.text,
    ),
      effectSpellClassMaskA2: _parseInt(effectSpellClassMaskA2Controller.text),
      effectSpellClassMaskB2: _parseInt(effectSpellClassMaskB2Controller.text),
      effectSpellClassMaskC2: _parseInt(effectSpellClassMaskC2Controller.text),

    // === 装备限制 ===
      equippedItemClass: _parseInt(equippedItemClassController.text),
      equippedItemSubclass: _parseInt(equippedItemSubclassController.text),
      equippedItemInvTypes: _parseInt(equippedItemInvTypesController.text),

    // === 图腾/施法材料 ===
      requiredTotemCategoryID0: _parseInt(
      requiredTotemCategoryID0Controller.text,
    ),
      totem0: _parseInt(totem0Controller.text),
      requiredTotemCategoryID1: _parseInt(
      requiredTotemCategoryID1Controller.text,
    ),
      totem1: _parseInt(totem1Controller.text),
      reagent0: _parseInt(reagent0Controller.text),
      reagent1: _parseInt(reagent1Controller.text),
      reagent2: _parseInt(reagent2Controller.text),
      reagent3: _parseInt(reagent3Controller.text),
      reagent4: _parseInt(reagent4Controller.text),
      reagent5: _parseInt(reagent5Controller.text),
      reagent6: _parseInt(reagent6Controller.text),
      reagent7: _parseInt(reagent7Controller.text),
      reagentCount0: _parseInt(reagentCount0Controller.text),
      reagentCount1: _parseInt(reagentCount1Controller.text),
      reagentCount2: _parseInt(reagentCount2Controller.text),
      reagentCount3: _parseInt(reagentCount3Controller.text),
      reagentCount4: _parseInt(reagentCount4Controller.text),
      reagentCount5: _parseInt(reagentCount5Controller.text),
      reagentCount6: _parseInt(reagentCount6Controller.text),
      reagentCount7: _parseInt(reagentCount7Controller.text),

    // === 其他高级属性 ===
      casterAuraSpell: _parseInt(casterAuraSpellController.text),
      cumulativeAura: _parseInt(cumulativeAuraController.text),
      minFactionID: _parseInt(minFactionIDController.text),
      minReputation: _parseInt(minReputationController.text),
      excludeCasterAuraSpell: _parseInt(excludeCasterAuraSpellController.text),
      excludeCasterAuraState: _parseInt(excludeCasterAuraStateController.text),
      excludeTargetAuraSpell: _parseInt(excludeTargetAuraSpellController.text),
      excludeTargetAuraState: _parseInt(excludeTargetAuraStateController.text),
      spellPriority: _parseInt(spellPriorityController.text),
      modalNextSpell: _parseInt(modalNextSpellController.text),
      requiredAuraVision: _parseInt(requiredAuraVisionController.text),
      targetAuraSpell: _parseInt(targetAuraSpellController.text),
      stanceBarOrder: _parseInt(stanceBarOrderController.text),
      shapeshiftMask0: _parseInt(shapeshiftMask0Controller.text),
      shapeshiftExclude0: _parseInt(shapeshiftExclude0Controller.text),

    );
    return t;

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

  void _logActivity(ActivityActionType action, Spell t) {
    final log = ActivityLog(
      module: 'spell',
      actionType: action,
      entityId: t.id,
      entityName: t.nameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    // === 基础文本 ===
    nameLangZhCNController.dispose();
    nameSubtextLangZhCNController.dispose();
    descriptionLangZhCNController.dispose();
    auraDescriptionLangZhCNController.dispose();
    nameLangFlagsController.dispose();
    nameSubtextLangFlagsController.dispose();
    descriptionLangFlagsController.dispose();
    auraDescriptionLangFlagsController.dispose();

    // === 图标/视觉 ===
    spellIconIDController.dispose();
    activeIconIDController.dispose();
    spellVisualID0Controller.dispose();
    spellVisualID1Controller.dispose();

    // === 分类/类型 ===
    categoryController.dispose();
    schoolMaskController.dispose();
    mechanicController.dispose();
    defenseTypeController.dispose();
    dispelTypeController.dispose();
    preventionTypeController.dispose();

    // === 施法参数 ===
    castingTimeIndexController.dispose();
    durationIndexController.dispose();
    rangeIndexController.dispose();
    spellDescriptionVariableIDController.dispose();

    // === 等级 ===
    baseLevelController.dispose();
    spellLevelController.dispose();
    maxLevelController.dispose();
    spellDifficultyIDController.dispose();

    // === 冷却/恢复 ===
    startRecoveryCategoryController.dispose();
    startRecoveryTimeController.dispose();
    recoveryTimeController.dispose();
    categoryRecoveryTimeController.dispose();

    // === 目标 ===
    targetCreatureTypeController.dispose();
    targetsController.dispose();
    maxTargetsController.dispose();
    maxTargetLevelController.dispose();

    // === 状态 ===
    casterAuraStateController.dispose();
    targetAuraStateController.dispose();
    spellMissileIDController.dispose();
    speedController.dispose();

    // === 需求 ===
    requiredAreasIDController.dispose();
    requiresSpellFocusController.dispose();
    facingCasterFlagsController.dispose();

    // === 能量消耗 ===
    powerDisplayIDController.dispose();
    powerTypeController.dispose();
    runeCostIDController.dispose();
    manaCostController.dispose();
    manaCostPctController.dispose();
    manaCostPerLevelController.dispose();
    manaPerSecondController.dispose();
    manaPerSecondPerLevelController.dispose();

    // === 标志位 ===
    interruptFlagsController.dispose();
    auraInterruptFlagsController.dispose();
    channelInterruptFlagsController.dispose();
    attributesController.dispose();
    attributesExController.dispose();
    attributesExBController.dispose();
    attributesExCController.dispose();
    attributesExDController.dispose();
    attributesExEController.dispose();
    attributesExFController.dispose();
    attributesExGController.dispose();

    // === 触发 ===
    procTypeMaskController.dispose();
    procChanceController.dispose();
    procChargesController.dispose();

    // === 法术分类 ===
    spellClassSetController.dispose();
    spellClassMask0Controller.dispose();
    spellClassMask1Controller.dispose();
    spellClassMask2Controller.dispose();

    // === 效果0 ===
    effect0Controller.dispose();
    effectBasePoints0Controller.dispose();
    effectDieSides0Controller.dispose();
    effectRealPointsPerLevel0Controller.dispose();
    effectMechanic0Controller.dispose();
    effectChainTargets0Controller.dispose();
    effectAura0Controller.dispose();
    effectAuraPeriod0Controller.dispose();
    effectAmplitude0Controller.dispose();
    implicitTargetA0Controller.dispose();
    implicitTargetB0Controller.dispose();
    effectMiscValue0Controller.dispose();
    effectMiscValueB0Controller.dispose();
    effectRadiusIndex0Controller.dispose();
    effectChainAmplitude0Controller.dispose();
    effectBonusCoefficient0Controller.dispose();
    effectItemType0Controller.dispose();
    effectTriggerSpell0Controller.dispose();
    effectPointsPerCombo0Controller.dispose();
    effectSpellClassMaskA0Controller.dispose();
    effectSpellClassMaskB0Controller.dispose();
    effectSpellClassMaskC0Controller.dispose();

    // === 效果1 ===
    effect1Controller.dispose();
    effectBasePoints1Controller.dispose();
    effectDieSides1Controller.dispose();
    effectRealPointsPerLevel1Controller.dispose();
    effectMechanic1Controller.dispose();
    effectChainTargets1Controller.dispose();
    effectAura1Controller.dispose();
    effectAuraPeriod1Controller.dispose();
    effectAmplitude1Controller.dispose();
    implicitTargetA1Controller.dispose();
    implicitTargetB1Controller.dispose();
    effectMiscValue1Controller.dispose();
    effectMiscValueB1Controller.dispose();
    effectRadiusIndex1Controller.dispose();
    effectChainAmplitude1Controller.dispose();
    effectBonusCoefficient1Controller.dispose();
    effectItemType1Controller.dispose();
    effectTriggerSpell1Controller.dispose();
    effectPointsPerCombo1Controller.dispose();
    effectSpellClassMaskA1Controller.dispose();
    effectSpellClassMaskB1Controller.dispose();
    effectSpellClassMaskC1Controller.dispose();

    // === 效果2 ===
    effect2Controller.dispose();
    effectBasePoints2Controller.dispose();
    effectDieSides2Controller.dispose();
    effectRealPointsPerLevel2Controller.dispose();
    effectMechanic2Controller.dispose();
    effectChainTargets2Controller.dispose();
    effectAura2Controller.dispose();
    effectAuraPeriod2Controller.dispose();
    effectAmplitude2Controller.dispose();
    implicitTargetA2Controller.dispose();
    implicitTargetB2Controller.dispose();
    effectMiscValue2Controller.dispose();
    effectMiscValueB2Controller.dispose();
    effectRadiusIndex2Controller.dispose();
    effectChainAmplitude2Controller.dispose();
    effectBonusCoefficient2Controller.dispose();
    effectItemType2Controller.dispose();
    effectTriggerSpell2Controller.dispose();
    effectPointsPerCombo2Controller.dispose();
    effectSpellClassMaskA2Controller.dispose();
    effectSpellClassMaskB2Controller.dispose();
    effectSpellClassMaskC2Controller.dispose();

    // === 装备限制 ===
    equippedItemClassController.dispose();
    equippedItemSubclassController.dispose();
    equippedItemInvTypesController.dispose();

    // === 图腾/施法材料 ===
    requiredTotemCategoryID0Controller.dispose();
    totem0Controller.dispose();
    requiredTotemCategoryID1Controller.dispose();
    totem1Controller.dispose();
    reagent0Controller.dispose();
    reagent1Controller.dispose();
    reagent2Controller.dispose();
    reagent3Controller.dispose();
    reagent4Controller.dispose();
    reagent5Controller.dispose();
    reagent6Controller.dispose();
    reagent7Controller.dispose();
    reagentCount0Controller.dispose();
    reagentCount1Controller.dispose();
    reagentCount2Controller.dispose();
    reagentCount3Controller.dispose();
    reagentCount4Controller.dispose();
    reagentCount5Controller.dispose();
    reagentCount6Controller.dispose();
    reagentCount7Controller.dispose();

    // === 其他高级属性 ===
    casterAuraSpellController.dispose();
    cumulativeAuraController.dispose();
    minFactionIDController.dispose();
    minReputationController.dispose();
    excludeCasterAuraSpellController.dispose();
    excludeCasterAuraStateController.dispose();
    excludeTargetAuraSpellController.dispose();
    excludeTargetAuraStateController.dispose();
    spellPriorityController.dispose();
    modalNextSpellController.dispose();
    requiredAuraVisionController.dispose();
    targetAuraSpellController.dispose();
    stanceBarOrderController.dispose();
    shapeshiftMask0Controller.dispose();
    shapeshiftExclude0Controller.dispose();
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      spell.value = await SpellRepository().getSpell(id);
      _initControllers(spell.value);
    } catch (e, s) {
      logger.e('加载法术(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(Spell template) {
    // === 基础文本 ===
    nameLangZhCNController.text = template.nameLangZhCN;
    nameSubtextLangZhCNController.text = template.nameSubtextLangZhCN;
    descriptionLangZhCNController.text = template.descriptionLangZhCN;
    auraDescriptionLangZhCNController.text = template.auraDescriptionLangZhCN;
    nameLangFlagsController.text = template.nameLangFlags.toString();
    nameSubtextLangFlagsController.text = template.nameSubtextLangFlags
        .toString();
    descriptionLangFlagsController.text = template.descriptionLangFlags
        .toString();
    auraDescriptionLangFlagsController.text = template.auraDescriptionLangFlags
        .toString();

    // === 图标/视觉 ===
    spellIconIDController.text = template.spellIconID.toString();
    activeIconIDController.text = template.activeIconID.toString();
    spellVisualID0Controller.text = template.spellVisualID0.toString();
    spellVisualID1Controller.text = template.spellVisualID1.toString();

    // === 分类/类型 ===
    categoryController.text = template.category.toString();
    schoolMaskController.text = template.schoolMask.toString();
    mechanicController.text = template.mechanic.toString();
    defenseTypeController.text = template.defenseType.toString();
    dispelTypeController.text = template.dispelType.toString();
    preventionTypeController.text = template.preventionType.toString();

    // === 施法参数 ===
    castingTimeIndexController.text = template.castingTimeIndex.toString();
    durationIndexController.text = template.durationIndex.toString();
    rangeIndexController.text = template.rangeIndex.toString();
    spellDescriptionVariableIDController.text = template
        .spellDescriptionVariableID
        .toString();

    // === 等级 ===
    baseLevelController.text = template.baseLevel.toString();
    spellLevelController.text = template.spellLevel.toString();
    maxLevelController.text = template.maxLevel.toString();
    spellDifficultyIDController.text = template.spellDifficultyID.toString();

    // === 冷却/恢复 ===
    startRecoveryCategoryController.text = template.startRecoveryCategory
        .toString();
    startRecoveryTimeController.text = template.startRecoveryTime.toString();
    recoveryTimeController.text = template.recoveryTime.toString();
    categoryRecoveryTimeController.text = template.categoryRecoveryTime
        .toString();

    // === 目标 ===
    targetCreatureTypeController.text = template.targetCreatureType.toString();
    targetsController.text = template.targets.toString();
    maxTargetsController.text = template.maxTargets.toString();
    maxTargetLevelController.text = template.maxTargetLevel.toString();

    // === 状态 ===
    casterAuraStateController.text = template.casterAuraState.toString();
    targetAuraStateController.text = template.targetAuraState.toString();
    spellMissileIDController.text = template.spellMissileID.toString();
    speedController.text = template.speed.toString();

    // === 需求 ===
    requiredAreasIDController.text = template.requiredAreasID.toString();
    requiresSpellFocusController.text = template.requiresSpellFocus.toString();
    facingCasterFlagsController.text = template.facingCasterFlags.toString();

    // === 能量消耗 ===
    powerDisplayIDController.text = template.powerDisplayID.toString();
    powerTypeController.text = template.powerType.toString();
    runeCostIDController.text = template.runeCostID.toString();
    manaCostController.text = template.manaCost.toString();
    manaCostPctController.text = template.manaCostPct.toString();
    manaCostPerLevelController.text = template.manaCostPerLevel.toString();
    manaPerSecondController.text = template.manaPerSecond.toString();
    manaPerSecondPerLevelController.text = template.manaPerSecondPerLevel
        .toString();

    // === 标志位 ===
    interruptFlagsController.text = template.interruptFlags.toString();
    auraInterruptFlagsController.text = template.auraInterruptFlags.toString();
    channelInterruptFlagsController.text = template.channelInterruptFlags
        .toString();
    attributesController.text = template.attributes.toString();
    attributesExController.text = template.attributesEx.toString();
    attributesExBController.text = template.attributesExB.toString();
    attributesExCController.text = template.attributesExC.toString();
    attributesExDController.text = template.attributesExD.toString();
    attributesExEController.text = template.attributesExE.toString();
    attributesExFController.text = template.attributesExF.toString();
    attributesExGController.text = template.attributesExG.toString();

    // === 触发 ===
    procTypeMaskController.text = template.procTypeMask.toString();
    procChanceController.text = template.procChance.toString();
    procChargesController.text = template.procCharges.toString();

    // === 法术分类 ===
    spellClassSetController.text = template.spellClassSet.toString();
    spellClassMask0Controller.text = template.spellClassMask0.toString();
    spellClassMask1Controller.text = template.spellClassMask1.toString();
    spellClassMask2Controller.text = template.spellClassMask2.toString();

    // === 效果0 ===
    effect0Controller.text = template.effect0.toString();
    effectBasePoints0Controller.text = template.effectBasePoints0.toString();
    effectDieSides0Controller.text = template.effectDieSides0.toString();
    effectRealPointsPerLevel0Controller.text = template
        .effectRealPointsPerLevel0
        .toString();
    effectMechanic0Controller.text = template.effectMechanic0.toString();
    effectChainTargets0Controller.text = template.effectChainTargets0
        .toString();
    effectAura0Controller.text = template.effectAura0.toString();
    effectAuraPeriod0Controller.text = template.effectAuraPeriod0.toString();
    effectAmplitude0Controller.text = template.effectAmplitude0.toString();
    implicitTargetA0Controller.text = template.implicitTargetA0.toString();
    implicitTargetB0Controller.text = template.implicitTargetB0.toString();
    effectMiscValue0Controller.text = template.effectMiscValue0.toString();
    effectMiscValueB0Controller.text = template.effectMiscValueB0.toString();
    effectRadiusIndex0Controller.text = template.effectRadiusIndex0.toString();
    effectChainAmplitude0Controller.text = template.effectChainAmplitude0
        .toString();
    effectBonusCoefficient0Controller.text = template.effectBonusCoefficient0
        .toString();
    effectItemType0Controller.text = template.effectItemType0.toString();
    effectTriggerSpell0Controller.text = template.effectTriggerSpell0
        .toString();
    effectPointsPerCombo0Controller.text = template.effectPointsPerCombo0
        .toString();
    effectSpellClassMaskA0Controller.text = template.effectSpellClassMaskA0
        .toString();
    effectSpellClassMaskB0Controller.text = template.effectSpellClassMaskB0
        .toString();
    effectSpellClassMaskC0Controller.text = template.effectSpellClassMaskC0
        .toString();

    // === 效果1 ===
    effect1Controller.text = template.effect1.toString();
    effectBasePoints1Controller.text = template.effectBasePoints1.toString();
    effectDieSides1Controller.text = template.effectDieSides1.toString();
    effectRealPointsPerLevel1Controller.text = template
        .effectRealPointsPerLevel1
        .toString();
    effectMechanic1Controller.text = template.effectMechanic1.toString();
    effectChainTargets1Controller.text = template.effectChainTargets1
        .toString();
    effectAura1Controller.text = template.effectAura1.toString();
    effectAuraPeriod1Controller.text = template.effectAuraPeriod1.toString();
    effectAmplitude1Controller.text = template.effectAmplitude1.toString();
    implicitTargetA1Controller.text = template.implicitTargetA1.toString();
    implicitTargetB1Controller.text = template.implicitTargetB1.toString();
    effectMiscValue1Controller.text = template.effectMiscValue1.toString();
    effectMiscValueB1Controller.text = template.effectMiscValueB1.toString();
    effectRadiusIndex1Controller.text = template.effectRadiusIndex1.toString();
    effectChainAmplitude1Controller.text = template.effectChainAmplitude1
        .toString();
    effectBonusCoefficient1Controller.text = template.effectBonusCoefficient1
        .toString();
    effectItemType1Controller.text = template.effectItemType1.toString();
    effectTriggerSpell1Controller.text = template.effectTriggerSpell1
        .toString();
    effectPointsPerCombo1Controller.text = template.effectPointsPerCombo1
        .toString();
    effectSpellClassMaskA1Controller.text = template.effectSpellClassMaskA1
        .toString();
    effectSpellClassMaskB1Controller.text = template.effectSpellClassMaskB1
        .toString();
    effectSpellClassMaskC1Controller.text = template.effectSpellClassMaskC1
        .toString();

    // === 效果2 ===
    effect2Controller.text = template.effect2.toString();
    effectBasePoints2Controller.text = template.effectBasePoints2.toString();
    effectDieSides2Controller.text = template.effectDieSides2.toString();
    effectRealPointsPerLevel2Controller.text = template
        .effectRealPointsPerLevel2
        .toString();
    effectMechanic2Controller.text = template.effectMechanic2.toString();
    effectChainTargets2Controller.text = template.effectChainTargets2
        .toString();
    effectAura2Controller.text = template.effectAura2.toString();
    effectAuraPeriod2Controller.text = template.effectAuraPeriod2.toString();
    effectAmplitude2Controller.text = template.effectAmplitude2.toString();
    implicitTargetA2Controller.text = template.implicitTargetA2.toString();
    implicitTargetB2Controller.text = template.implicitTargetB2.toString();
    effectMiscValue2Controller.text = template.effectMiscValue2.toString();
    effectMiscValueB2Controller.text = template.effectMiscValueB2.toString();
    effectRadiusIndex2Controller.text = template.effectRadiusIndex2.toString();
    effectChainAmplitude2Controller.text = template.effectChainAmplitude2
        .toString();
    effectBonusCoefficient2Controller.text = template.effectBonusCoefficient2
        .toString();
    effectItemType2Controller.text = template.effectItemType2.toString();
    effectTriggerSpell2Controller.text = template.effectTriggerSpell2
        .toString();
    effectPointsPerCombo2Controller.text = template.effectPointsPerCombo2
        .toString();
    effectSpellClassMaskA2Controller.text = template.effectSpellClassMaskA2
        .toString();
    effectSpellClassMaskB2Controller.text = template.effectSpellClassMaskB2
        .toString();
    effectSpellClassMaskC2Controller.text = template.effectSpellClassMaskC2
        .toString();

    // === 装备限制 ===
    equippedItemClassController.text = template.equippedItemClass.toString();
    equippedItemSubclassController.text = template.equippedItemSubclass
        .toString();
    equippedItemInvTypesController.text = template.equippedItemInvTypes
        .toString();

    // === 图腾/施法材料 ===
    requiredTotemCategoryID0Controller.text = template.requiredTotemCategoryID0
        .toString();
    totem0Controller.text = template.totem0.toString();
    requiredTotemCategoryID1Controller.text = template.requiredTotemCategoryID1
        .toString();
    totem1Controller.text = template.totem1.toString();
    reagent0Controller.text = template.reagent0.toString();
    reagent1Controller.text = template.reagent1.toString();
    reagent2Controller.text = template.reagent2.toString();
    reagent3Controller.text = template.reagent3.toString();
    reagent4Controller.text = template.reagent4.toString();
    reagent5Controller.text = template.reagent5.toString();
    reagent6Controller.text = template.reagent6.toString();
    reagent7Controller.text = template.reagent7.toString();
    reagentCount0Controller.text = template.reagentCount0.toString();
    reagentCount1Controller.text = template.reagentCount1.toString();
    reagentCount2Controller.text = template.reagentCount2.toString();
    reagentCount3Controller.text = template.reagentCount3.toString();
    reagentCount4Controller.text = template.reagentCount4.toString();
    reagentCount5Controller.text = template.reagentCount5.toString();
    reagentCount6Controller.text = template.reagentCount6.toString();
    reagentCount7Controller.text = template.reagentCount7.toString();

    // === 其他高级属性 ===
    casterAuraSpellController.text = template.casterAuraSpell.toString();
    cumulativeAuraController.text = template.cumulativeAura.toString();
    minFactionIDController.text = template.minFactionID.toString();
    minReputationController.text = template.minReputation.toString();
    excludeCasterAuraSpellController.text = template.excludeCasterAuraSpell
        .toString();
    excludeCasterAuraStateController.text = template.excludeCasterAuraState
        .toString();
    excludeTargetAuraSpellController.text = template.excludeTargetAuraSpell
        .toString();
    excludeTargetAuraStateController.text = template.excludeTargetAuraState
        .toString();
    spellPriorityController.text = template.spellPriority.toString();
    modalNextSpellController.text = template.modalNextSpell.toString();
    requiredAuraVisionController.text = template.requiredAuraVision.toString();
    targetAuraSpellController.text = template.targetAuraSpell.toString();
    stanceBarOrderController.text = template.stanceBarOrder.toString();
    shapeshiftMask0Controller.text = template.shapeshiftMask0.toString();
    shapeshiftExclude0Controller.text = template.shapeshiftExclude0.toString();
  }
}
