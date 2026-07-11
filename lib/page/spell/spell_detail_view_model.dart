import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellDetailViewModel {
  final _repository = GetIt.instance.get<SpellRepository>();
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
  final schoolMaskFlagController = TextEditingController();
  final mechanicController = ShadSelectController<int>();
  final defenseTypeController = ShadSelectController<int>();
  final dispelTypeController = ShadSelectController<int>();
  final preventionTypeController = ShadSelectController<int>();

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
  final targetCreatureTypeController = ShadSelectController<int>();
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
  final powerTypeController = ShadSelectController<int>();
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
  final spellClassSetController = ShadSelectController<int>();
  final spellClassMask0Controller = TextEditingController();
  final spellClassMask1Controller = TextEditingController();
  final spellClassMask2Controller = TextEditingController();

  // === 效果0 ===
  final effect0Controller = ShadSelectController<int>();
  final effectBasePoints0Controller = TextEditingController();
  final effectDieSides0Controller = TextEditingController();
  final effectRealPointsPerLevel0Controller = TextEditingController();
  final effectMechanic0Controller = ShadSelectController<int>();
  final effectChainTargets0Controller = TextEditingController();
  final effectAura0Controller = ShadSelectController<int>();
  final effectAuraPeriod0Controller = TextEditingController();
  final effectAmplitude0Controller = TextEditingController();
  final implicitTargetA0Controller = ShadSelectController<int>();
  final implicitTargetB0Controller = ShadSelectController<int>();
  final effectMiscValue0Controller = TextEditingController();
  final effectMiscValueB0Controller = TextEditingController();
  final effectRadiusIndex0Controller = TextEditingController();
  final effectChainAmplitude0Controller = TextEditingController();
  final effectBonusCoefficient0Controller = TextEditingController();
  final effectItemType0Controller = ShadSelectController<int>();
  final effectTriggerSpell0Controller = TextEditingController();
  final effectPointsPerCombo0Controller = TextEditingController();
  final effectSpellClassMaskA0Controller = TextEditingController();
  final effectSpellClassMaskB0Controller = TextEditingController();
  final effectSpellClassMaskC0Controller = TextEditingController();

  // === 效果1 ===
  final effect1Controller = ShadSelectController<int>();
  final effectBasePoints1Controller = TextEditingController();
  final effectDieSides1Controller = TextEditingController();
  final effectRealPointsPerLevel1Controller = TextEditingController();
  final effectMechanic1Controller = ShadSelectController<int>();
  final effectChainTargets1Controller = TextEditingController();
  final effectAura1Controller = ShadSelectController<int>();
  final effectAuraPeriod1Controller = TextEditingController();
  final effectAmplitude1Controller = TextEditingController();
  final implicitTargetA1Controller = ShadSelectController<int>();
  final implicitTargetB1Controller = ShadSelectController<int>();
  final effectMiscValue1Controller = TextEditingController();
  final effectMiscValueB1Controller = TextEditingController();
  final effectRadiusIndex1Controller = TextEditingController();
  final effectChainAmplitude1Controller = TextEditingController();
  final effectBonusCoefficient1Controller = TextEditingController();
  final effectItemType1Controller = ShadSelectController<int>();
  final effectTriggerSpell1Controller = TextEditingController();
  final effectPointsPerCombo1Controller = TextEditingController();
  final effectSpellClassMaskA1Controller = TextEditingController();
  final effectSpellClassMaskB1Controller = TextEditingController();
  final effectSpellClassMaskC1Controller = TextEditingController();

  // === 效果2 ===
  final effect2Controller = ShadSelectController<int>();
  final effectBasePoints2Controller = TextEditingController();
  final effectDieSides2Controller = TextEditingController();
  final effectRealPointsPerLevel2Controller = TextEditingController();
  final effectMechanic2Controller = ShadSelectController<int>();
  final effectChainTargets2Controller = TextEditingController();
  final effectAura2Controller = ShadSelectController<int>();
  final effectAuraPeriod2Controller = TextEditingController();
  final effectAmplitude2Controller = TextEditingController();
  final implicitTargetA2Controller = ShadSelectController<int>();
  final implicitTargetB2Controller = ShadSelectController<int>();
  final effectMiscValue2Controller = TextEditingController();
  final effectMiscValueB2Controller = TextEditingController();
  final effectRadiusIndex2Controller = TextEditingController();
  final effectChainAmplitude2Controller = TextEditingController();
  final effectBonusCoefficient2Controller = TextEditingController();
  final effectItemType2Controller = ShadSelectController<int>();
  final effectTriggerSpell2Controller = TextEditingController();
  final effectPointsPerCombo2Controller = TextEditingController();
  final effectSpellClassMaskA2Controller = TextEditingController();
  final effectSpellClassMaskB2Controller = TextEditingController();
  final effectSpellClassMaskC2Controller = TextEditingController();

  // === 装备限制 ===
  final equippedItemClassController = ShadSelectController<int>();
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
  final minReputationController = ShadSelectController<int>();
  final excludeCasterAuraStateController = ShadSelectController<int>();
  final excludeCasterAuraSpellController = TextEditingController();
  final excludeTargetAuraSpellController = TextEditingController();
  final excludeTargetAuraStateController = ShadSelectController<int>();
  final spellPriorityController = TextEditingController();
  final modalNextSpellController = TextEditingController();
  final requiredAuraVisionController = TextEditingController();
  final targetAuraSpellController = TextEditingController();
  final stanceBarOrderController = TextEditingController();
  final shapeshiftMask0Controller = TextEditingController();
  final shapeshiftExclude0Controller = TextEditingController();

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
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      if (t.id == 0) {
        final newId = await _repository.storeSpell(t);
        id.value = newId;
      } else {
        await _repository.updateSpell(t);
      }
      spell.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
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

  void pop() {
    routerFacade.goBack();
  }

  SpellEntity _collectFromControllers() {
    // 基于已加载实体覆盖 UI 字段，避免把未展示的多语言/扩展字段写成默认空值。
    final t = spell.value.copyWith(
      id: id.value,
      // === 基础文本 ===
      nameLangZhCN: nameLangZhCNController.text,
      nameSubtextLangZhCN: nameSubtextLangZhCNController.text,
      descriptionLangZhCN: descriptionLangZhCNController.text,
      auraDescriptionLangZhCN: auraDescriptionLangZhCNController.text,
      nameLangFlags: _pi(nameLangFlagsController.text),
      nameSubtextLangFlags: _pi(nameSubtextLangFlagsController.text),
      descriptionLangFlags: _pi(descriptionLangFlagsController.text),
      auraDescriptionLangFlags: _pi(auraDescriptionLangFlagsController.text),

      // === 图标/视觉 ===
      spellIconID: _pi(spellIconIDController.text),
      activeIconID: _pi(activeIconIDController.text),
      spellVisualID0: _pi(spellVisualID0Controller.text),
      spellVisualID1: _pi(spellVisualID1Controller.text),

      // === 分类/类型 ===
      category: _pi(categoryController.text),
      schoolMask: _pi(schoolMaskController.text),
      mechanic: _getSelectValue(mechanicController),
      defenseType: _getSelectValue(defenseTypeController),
      dispelType: _getSelectValue(dispelTypeController),
      preventionType: _getSelectValue(preventionTypeController),

      // === 施法参数 ===
      castingTimeIndex: _pi(castingTimeIndexController.text),
      durationIndex: _pi(durationIndexController.text),
      rangeIndex: _pi(rangeIndexController.text),
      spellDescriptionVariableID: _pi(
        spellDescriptionVariableIDController.text,
      ),

      // === 等级 ===
      baseLevel: _pi(baseLevelController.text),
      spellLevel: _pi(spellLevelController.text),
      maxLevel: _pi(maxLevelController.text),
      spellDifficultyID: _pi(spellDifficultyIDController.text),

      // === 冷却/恢复 ===
      startRecoveryCategory: _pi(startRecoveryCategoryController.text),
      startRecoveryTime: _pi(startRecoveryTimeController.text),
      recoveryTime: _pi(recoveryTimeController.text),
      categoryRecoveryTime: _pi(categoryRecoveryTimeController.text),

      // === 目标 ===
      targetCreatureType: _getSelectValue(targetCreatureTypeController),
      targets: parseFlagValue(targetsController.text),
      maxTargets: _pi(maxTargetsController.text),
      maxTargetLevel: _pi(maxTargetLevelController.text),

      // === 状态 ===
      casterAuraState: _pi(casterAuraStateController.text),
      targetAuraState: _pi(targetAuraStateController.text),
      spellMissileID: _pi(spellMissileIDController.text),
      speed: _pd(speedController.text),

      // === 需求 ===
      requiredAreasID: _pi(requiredAreasIDController.text),
      requiresSpellFocus: _pi(requiresSpellFocusController.text),
      facingCasterFlags: parseFlagValue(facingCasterFlagsController.text),

      // === 能量消耗 ===
      powerDisplayID: _pi(powerDisplayIDController.text),
      powerType: _getSelectValue(powerTypeController),
      runeCostID: _pi(runeCostIDController.text),
      manaCost: _pi(manaCostController.text),
      manaCostPct: _pi(manaCostPctController.text),
      manaCostPerLevel: _pi(manaCostPerLevelController.text),
      manaPerSecond: _pi(manaPerSecondController.text),
      manaPerSecondPerLevel: _pi(manaPerSecondPerLevelController.text),

      // === 标志位 ===
      interruptFlags: parseFlagValue(interruptFlagsController.text),
      auraInterruptFlags: parseFlagValue(auraInterruptFlagsController.text),
      channelInterruptFlags: parseFlagValue(channelInterruptFlagsController.text),
      attributes: parseFlagValue(attributesController.text),
      attributesEx: parseFlagValue(attributesExController.text),
      attributesExB: parseFlagValue(attributesExBController.text),
      attributesExC: parseFlagValue(attributesExCController.text),
      attributesExD: parseFlagValue(attributesExDController.text),
      attributesExE: parseFlagValue(attributesExEController.text),
      attributesExF: parseFlagValue(attributesExFController.text),
      attributesExG: parseFlagValue(attributesExGController.text),

      // === 触发 ===
      procTypeMask: parseFlagValue(procTypeMaskController.text),
      procChance: _pi(procChanceController.text),
      procCharges: _pi(procChargesController.text),

      // === 法术分类 ===
      spellClassSet: _getSelectValue(spellClassSetController),
      spellClassMask0: parseFlagValue(spellClassMask0Controller.text),
      spellClassMask1: parseFlagValue(spellClassMask1Controller.text),
      spellClassMask2: parseFlagValue(spellClassMask2Controller.text),

      // === 效果0 ===
      effect0: _getSelectValue(effect0Controller),
      effectBasePoints0: _pi(effectBasePoints0Controller.text),
      effectDieSides0: _pi(effectDieSides0Controller.text),
      effectRealPointsPerLevel0: _pd(effectRealPointsPerLevel0Controller.text),
      effectMechanic0: _getSelectValue(effectMechanic0Controller),
      effectChainTargets0: _pi(effectChainTargets0Controller.text),
      effectAura0: _getSelectValue(effectAura0Controller),
      effectAuraPeriod0: _pi(effectAuraPeriod0Controller.text),
      effectAmplitude0: _pd(effectAmplitude0Controller.text),
      implicitTargetA0: _getSelectValue(implicitTargetA0Controller),
      implicitTargetB0: _getSelectValue(implicitTargetB0Controller),
      effectMiscValue0: _pi(effectMiscValue0Controller.text),
      effectMiscValueB0: _pi(effectMiscValueB0Controller.text),
      effectRadiusIndex0: _pi(effectRadiusIndex0Controller.text),
      effectChainAmplitude0: _pd(effectChainAmplitude0Controller.text),
      effectBonusCoefficient0: _pd(effectBonusCoefficient0Controller.text),
      effectItemType0: _getSelectValue(effectItemType0Controller),
      effectTriggerSpell0: _pi(effectTriggerSpell0Controller.text),
      effectPointsPerCombo0: _pd(effectPointsPerCombo0Controller.text),
      effectSpellClassMaskA0: parseFlagValue(effectSpellClassMaskA0Controller.text),
      effectSpellClassMaskB0: parseFlagValue(effectSpellClassMaskB0Controller.text),
      effectSpellClassMaskC0: parseFlagValue(effectSpellClassMaskC0Controller.text),

      // === 效果1 ===
      effect1: _getSelectValue(effect1Controller),
      effectBasePoints1: _pi(effectBasePoints1Controller.text),
      effectDieSides1: _pi(effectDieSides1Controller.text),
      effectRealPointsPerLevel1: _pd(effectRealPointsPerLevel1Controller.text),
      effectMechanic1: _getSelectValue(effectMechanic1Controller),
      effectChainTargets1: _pi(effectChainTargets1Controller.text),
      effectAura1: _getSelectValue(effectAura1Controller),
      effectAuraPeriod1: _pi(effectAuraPeriod1Controller.text),
      effectAmplitude1: _pd(effectAmplitude1Controller.text),
      implicitTargetA1: _getSelectValue(implicitTargetA1Controller),
      implicitTargetB1: _getSelectValue(implicitTargetB1Controller),
      effectMiscValue1: _pi(effectMiscValue1Controller.text),
      effectMiscValueB1: _pi(effectMiscValueB1Controller.text),
      effectRadiusIndex1: _pi(effectRadiusIndex1Controller.text),
      effectChainAmplitude1: _pd(effectChainAmplitude1Controller.text),
      effectBonusCoefficient1: _pd(effectBonusCoefficient1Controller.text),
      effectItemType1: _getSelectValue(effectItemType1Controller),
      effectTriggerSpell1: _pi(effectTriggerSpell1Controller.text),
      effectPointsPerCombo1: _pd(effectPointsPerCombo1Controller.text),
      effectSpellClassMaskA1: parseFlagValue(effectSpellClassMaskA1Controller.text),
      effectSpellClassMaskB1: parseFlagValue(effectSpellClassMaskB1Controller.text),
      effectSpellClassMaskC1: parseFlagValue(effectSpellClassMaskC1Controller.text),

      // === 效果2 ===
      effect2: _getSelectValue(effect2Controller),
      effectBasePoints2: _pi(effectBasePoints2Controller.text),
      effectDieSides2: _pi(effectDieSides2Controller.text),
      effectRealPointsPerLevel2: _pd(effectRealPointsPerLevel2Controller.text),
      effectMechanic2: _getSelectValue(effectMechanic2Controller),
      effectChainTargets2: _pi(effectChainTargets2Controller.text),
      effectAura2: _getSelectValue(effectAura2Controller),
      effectAuraPeriod2: _pi(effectAuraPeriod2Controller.text),
      effectAmplitude2: _pd(effectAmplitude2Controller.text),
      implicitTargetA2: _getSelectValue(implicitTargetA2Controller),
      implicitTargetB2: _getSelectValue(implicitTargetB2Controller),
      effectMiscValue2: _pi(effectMiscValue2Controller.text),
      effectMiscValueB2: _pi(effectMiscValueB2Controller.text),
      effectRadiusIndex2: _pi(effectRadiusIndex2Controller.text),
      effectChainAmplitude2: _pd(effectChainAmplitude2Controller.text),
      effectBonusCoefficient2: _pd(effectBonusCoefficient2Controller.text),
      effectItemType2: _getSelectValue(effectItemType2Controller),
      effectTriggerSpell2: _pi(effectTriggerSpell2Controller.text),
      effectPointsPerCombo2: _pd(effectPointsPerCombo2Controller.text),
      effectSpellClassMaskA2: parseFlagValue(effectSpellClassMaskA2Controller.text),
      effectSpellClassMaskB2: parseFlagValue(effectSpellClassMaskB2Controller.text),
      effectSpellClassMaskC2: parseFlagValue(effectSpellClassMaskC2Controller.text),

      // === 装备限制 ===
      equippedItemClass: _getSelectValue(equippedItemClassController),
      equippedItemSubclass: _pi(equippedItemSubclassController.text),
      equippedItemInvTypes: parseFlagValue(equippedItemInvTypesController.text),

      // === 图腾/施法材料 ===
      requiredTotemCategoryID0: _pi(requiredTotemCategoryID0Controller.text),
      totem0: _pi(totem0Controller.text),
      requiredTotemCategoryID1: _pi(requiredTotemCategoryID1Controller.text),
      totem1: _pi(totem1Controller.text),
      reagent0: _pi(reagent0Controller.text),
      reagent1: _pi(reagent1Controller.text),
      reagent2: _pi(reagent2Controller.text),
      reagent3: _pi(reagent3Controller.text),
      reagent4: _pi(reagent4Controller.text),
      reagent5: _pi(reagent5Controller.text),
      reagent6: _pi(reagent6Controller.text),
      reagent7: _pi(reagent7Controller.text),
      reagentCount0: _pi(reagentCount0Controller.text),
      reagentCount1: _pi(reagentCount1Controller.text),
      reagentCount2: _pi(reagentCount2Controller.text),
      reagentCount3: _pi(reagentCount3Controller.text),
      reagentCount4: _pi(reagentCount4Controller.text),
      reagentCount5: _pi(reagentCount5Controller.text),
      reagentCount6: _pi(reagentCount6Controller.text),
      reagentCount7: _pi(reagentCount7Controller.text),

      // === 其他高级属性 ===
      casterAuraSpell: _pi(casterAuraSpellController.text),
      cumulativeAura: _pi(cumulativeAuraController.text),
      minFactionID: _pi(minFactionIDController.text),
      minReputation: _getSelectValue(minReputationController),
      excludeCasterAuraSpell: _pi(excludeCasterAuraSpellController.text),
      excludeCasterAuraState: _getSelectValue(excludeCasterAuraStateController),
      excludeTargetAuraSpell: _pi(excludeTargetAuraSpellController.text),
      excludeTargetAuraState: _getSelectValue(excludeTargetAuraStateController),
      spellPriority: _pi(spellPriorityController.text),
      modalNextSpell: _pi(modalNextSpellController.text),
      requiredAuraVision: _pi(requiredAuraVisionController.text),
      targetAuraSpell: _pi(targetAuraSpellController.text),
      stanceBarOrder: _pi(stanceBarOrderController.text),
      shapeshiftMask0: parseFlagValue(shapeshiftMask0Controller.text),
      shapeshiftExclude0: parseFlagValue(shapeshiftExclude0Controller.text),
    );
    return t;
  }

  void _logActivity(ActivityActionType action, SpellEntity t) {
    final log = ActivityLogEntity(
      module: 'spell',
      actionType: action,
      entityId: t.id,
      entityName: t.nameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    activeIconIDController.dispose();
    attributesController.dispose();
    attributesExController.dispose();
    attributesExBController.dispose();
    attributesExCController.dispose();
    attributesExDController.dispose();
    attributesExEController.dispose();
    attributesExFController.dispose();
    attributesExGController.dispose();
    auraDescriptionLangFlagsController.dispose();
    auraDescriptionLangZhCNController.dispose();
    auraInterruptFlagsController.dispose();
    baseLevelController.dispose();
    casterAuraSpellController.dispose();
    casterAuraStateController.dispose();
    castingTimeIndexController.dispose();
    categoryController.dispose();
    categoryRecoveryTimeController.dispose();
    channelInterruptFlagsController.dispose();
    cumulativeAuraController.dispose();
    defenseTypeController.dispose();
    descriptionLangFlagsController.dispose();
    descriptionLangZhCNController.dispose();
    dispelTypeController.dispose();
    durationIndexController.dispose();
    effect0Controller.dispose();
    effect1Controller.dispose();
    effect2Controller.dispose();
    effectAmplitude0Controller.dispose();
    effectAmplitude1Controller.dispose();
    effectAmplitude2Controller.dispose();
    effectAura0Controller.dispose();
    effectAura1Controller.dispose();
    effectAura2Controller.dispose();
    effectAuraPeriod0Controller.dispose();
    effectAuraPeriod1Controller.dispose();
    effectAuraPeriod2Controller.dispose();
    effectBasePoints0Controller.dispose();
    effectBasePoints1Controller.dispose();
    effectBasePoints2Controller.dispose();
    effectBonusCoefficient0Controller.dispose();
    effectBonusCoefficient1Controller.dispose();
    effectBonusCoefficient2Controller.dispose();
    effectChainAmplitude0Controller.dispose();
    effectChainAmplitude1Controller.dispose();
    effectChainAmplitude2Controller.dispose();
    effectChainTargets0Controller.dispose();
    effectChainTargets1Controller.dispose();
    effectChainTargets2Controller.dispose();
    effectDieSides0Controller.dispose();
    effectDieSides1Controller.dispose();
    effectDieSides2Controller.dispose();
    effectItemType0Controller.dispose();
    effectItemType1Controller.dispose();
    effectItemType2Controller.dispose();
    effectMechanic0Controller.dispose();
    effectMechanic1Controller.dispose();
    effectMechanic2Controller.dispose();
    effectMiscValue0Controller.dispose();
    effectMiscValue1Controller.dispose();
    effectMiscValue2Controller.dispose();
    effectMiscValueB0Controller.dispose();
    effectMiscValueB1Controller.dispose();
    effectMiscValueB2Controller.dispose();
    effectPointsPerCombo0Controller.dispose();
    effectPointsPerCombo1Controller.dispose();
    effectPointsPerCombo2Controller.dispose();
    effectRadiusIndex0Controller.dispose();
    effectRadiusIndex1Controller.dispose();
    effectRadiusIndex2Controller.dispose();
    effectRealPointsPerLevel0Controller.dispose();
    effectRealPointsPerLevel1Controller.dispose();
    effectRealPointsPerLevel2Controller.dispose();
    effectSpellClassMaskA0Controller.dispose();
    effectSpellClassMaskA1Controller.dispose();
    effectSpellClassMaskA2Controller.dispose();
    effectSpellClassMaskB0Controller.dispose();
    effectSpellClassMaskB1Controller.dispose();
    effectSpellClassMaskB2Controller.dispose();
    effectSpellClassMaskC0Controller.dispose();
    effectSpellClassMaskC1Controller.dispose();
    effectSpellClassMaskC2Controller.dispose();
    effectTriggerSpell0Controller.dispose();
    effectTriggerSpell1Controller.dispose();
    effectTriggerSpell2Controller.dispose();
    equippedItemClassController.dispose();
    equippedItemInvTypesController.dispose();
    equippedItemSubclassController.dispose();
    excludeCasterAuraSpellController.dispose();
    excludeCasterAuraStateController.dispose();
    excludeTargetAuraSpellController.dispose();
    excludeTargetAuraStateController.dispose();
    facingCasterFlagsController.dispose();
    implicitTargetA0Controller.dispose();
    implicitTargetA1Controller.dispose();
    implicitTargetA2Controller.dispose();
    implicitTargetB0Controller.dispose();
    implicitTargetB1Controller.dispose();
    implicitTargetB2Controller.dispose();
    interruptFlagsController.dispose();
    manaCostController.dispose();
    manaCostPctController.dispose();
    manaCostPerLevelController.dispose();
    manaPerSecondController.dispose();
    manaPerSecondPerLevelController.dispose();
    maxLevelController.dispose();
    maxTargetLevelController.dispose();
    maxTargetsController.dispose();
    mechanicController.dispose();
    minFactionIDController.dispose();
    minReputationController.dispose();
    modalNextSpellController.dispose();
    nameLangFlagsController.dispose();
    nameLangZhCNController.dispose();
    nameSubtextLangFlagsController.dispose();
    nameSubtextLangZhCNController.dispose();
    powerDisplayIDController.dispose();
    powerTypeController.dispose();
    preventionTypeController.dispose();
    procChanceController.dispose();
    procChargesController.dispose();
    procTypeMaskController.dispose();
    rangeIndexController.dispose();
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
    recoveryTimeController.dispose();
    requiredAreasIDController.dispose();
    requiredAuraVisionController.dispose();
    requiredTotemCategoryID0Controller.dispose();
    requiredTotemCategoryID1Controller.dispose();
    requiresSpellFocusController.dispose();
    runeCostIDController.dispose();
    schoolMaskController.dispose();
    schoolMaskFlagController.dispose();
    shapeshiftExclude0Controller.dispose();
    shapeshiftMask0Controller.dispose();
    speedController.dispose();
    spellClassMask0Controller.dispose();
    spellClassMask1Controller.dispose();
    spellClassMask2Controller.dispose();
    spellClassSetController.dispose();
    spellDescriptionVariableIDController.dispose();
    spellDifficultyIDController.dispose();
    spellIconIDController.dispose();
    spellLevelController.dispose();
    spellMissileIDController.dispose();
    spellPriorityController.dispose();
    spellVisualID0Controller.dispose();
    spellVisualID1Controller.dispose();
    stanceBarOrderController.dispose();
    startRecoveryCategoryController.dispose();
    startRecoveryTimeController.dispose();
    targetAuraSpellController.dispose();
    targetAuraStateController.dispose();
    targetCreatureTypeController.dispose();
    targetsController.dispose();
    totem0Controller.dispose();
    totem1Controller.dispose();
  }

  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;
  double _pd(String t) => double.tryParse(t) ?? 0.0;

  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
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

  /// 监听 ShadSelectController 变化，同步到 signal
  void _wireEffectSignals() {
    void sync(ShadSelectController<int> ctrl, Signal<int> sig) {
      sig.value = _getSelectValue(ctrl);
      ctrl.addListener(() => sig.value = _getSelectValue(ctrl));
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
    // === 基础文本 ===
    nameLangZhCNController.text = template.nameLangZhCN;
    nameSubtextLangZhCNController.text = template.nameSubtextLangZhCN;
    descriptionLangZhCNController.text = template.descriptionLangZhCN;
    auraDescriptionLangZhCNController.text = template.auraDescriptionLangZhCN;
    nameLangFlagsController.text = _fmt(template.nameLangFlags);
    nameSubtextLangFlagsController.text = _fmt(template.nameSubtextLangFlags);
    descriptionLangFlagsController.text = _fmt(template.descriptionLangFlags);
    auraDescriptionLangFlagsController.text = _fmt(
      template.auraDescriptionLangFlags,
    );

    // === 图标/视觉 ===
    spellIconIDController.text = _fmt(template.spellIconID);
    activeIconIDController.text = _fmt(template.activeIconID);
    spellVisualID0Controller.text = _fmt(template.spellVisualID0);
    spellVisualID1Controller.text = _fmt(template.spellVisualID1);

    // === 分类/类型 ===
    categoryController.text = _fmt(template.category);
    schoolMaskController.text = _fmt(template.schoolMask);
    schoolMaskFlagController.text = formatFlagValue(template.schoolMask);
    mechanicController.value = {template.mechanic};
    defenseTypeController.value = {template.defenseType};
    dispelTypeController.value = {template.dispelType};
    preventionTypeController.value = {template.preventionType};

    // === 施法参数 ===
    castingTimeIndexController.text = _fmt(template.castingTimeIndex);
    durationIndexController.text = _fmt(template.durationIndex);
    rangeIndexController.text = _fmt(template.rangeIndex);
    spellDescriptionVariableIDController.text = _fmt(
      template.spellDescriptionVariableID,
    );

    // === 等级 ===
    baseLevelController.text = _fmt(template.baseLevel);
    spellLevelController.text = _fmt(template.spellLevel);
    maxLevelController.text = _fmt(template.maxLevel);
    spellDifficultyIDController.text = _fmt(template.spellDifficultyID);

    // === 冷却/恢复 ===
    startRecoveryCategoryController.text = _fmt(template.startRecoveryCategory);
    startRecoveryTimeController.text = _fmt(template.startRecoveryTime);
    recoveryTimeController.text = _fmt(template.recoveryTime);
    categoryRecoveryTimeController.text = _fmt(template.categoryRecoveryTime);

    // === 目标 ===
    targetCreatureTypeController.value = {template.targetCreatureType};
    targetsController.text = formatFlagValue(template.targets);
    maxTargetsController.text = _fmt(template.maxTargets);
    maxTargetLevelController.text = _fmt(template.maxTargetLevel);

    // === 状态 ===
    casterAuraStateController.text = _fmt(template.casterAuraState);
    targetAuraStateController.text = _fmt(template.targetAuraState);
    spellMissileIDController.text = _fmt(template.spellMissileID);
    speedController.text = _fmt(template.speed);

    // === 需求 ===
    requiredAreasIDController.text = _fmt(template.requiredAreasID);
    requiresSpellFocusController.text = _fmt(template.requiresSpellFocus);
    facingCasterFlagsController.text = formatFlagValue(
      template.facingCasterFlags,
    );

    // === 能量消耗 ===
    powerDisplayIDController.text = _fmt(template.powerDisplayID);
    powerTypeController.value = {template.powerType};
    runeCostIDController.text = _fmt(template.runeCostID);
    manaCostController.text = _fmt(template.manaCost);
    manaCostPctController.text = _fmt(template.manaCostPct);
    manaCostPerLevelController.text = _fmt(template.manaCostPerLevel);
    manaPerSecondController.text = _fmt(template.manaPerSecond);
    manaPerSecondPerLevelController.text = _fmt(template.manaPerSecondPerLevel);

    // === 标志位 ===
    interruptFlagsController.text = formatFlagValue(template.interruptFlags);
    auraInterruptFlagsController.text = formatFlagValue(
      template.auraInterruptFlags,
    );
    channelInterruptFlagsController.text = formatFlagValue(
      template.channelInterruptFlags,
    );
    attributesController.text = formatFlagValue(template.attributes);
    attributesExController.text = formatFlagValue(template.attributesEx);
    attributesExBController.text = formatFlagValue(template.attributesExB);
    attributesExCController.text = formatFlagValue(template.attributesExC);
    attributesExDController.text = formatFlagValue(template.attributesExD);
    attributesExEController.text = formatFlagValue(template.attributesExE);
    attributesExFController.text = formatFlagValue(template.attributesExF);
    attributesExGController.text = formatFlagValue(template.attributesExG);

    // === 触发 ===
    procTypeMaskController.text = formatFlagValue(template.procTypeMask);
    procChanceController.text = _fmt(template.procChance);
    procChargesController.text = _fmt(template.procCharges);

    // === 法术分类 ===
    spellClassSetController.value = {template.spellClassSet};
    spellClassMask0Controller.text = formatFlagValue(template.spellClassMask0);
    spellClassMask1Controller.text = formatFlagValue(template.spellClassMask1);
    spellClassMask2Controller.text = formatFlagValue(template.spellClassMask2);

    // === 效果0 ===
    effect0Controller.value = {template.effect0};
    effectBasePoints0Controller.text = _fmt(template.effectBasePoints0);
    effectDieSides0Controller.text = _fmt(template.effectDieSides0);
    effectRealPointsPerLevel0Controller.text = _fmt(
      template.effectRealPointsPerLevel0,
    );
    effectMechanic0Controller.value = {template.effectMechanic0};
    effectChainTargets0Controller.text = _fmt(template.effectChainTargets0);
    effectAura0Controller.value = {template.effectAura0};
    effectAuraPeriod0Controller.text = _fmt(template.effectAuraPeriod0);
    effectAmplitude0Controller.text = _fmt(template.effectAmplitude0);
    implicitTargetA0Controller.value = {template.implicitTargetA0};
    implicitTargetB0Controller.value = {template.implicitTargetB0};
    effectMiscValue0Controller.text = _fmt(template.effectMiscValue0);
    effectMiscValueB0Controller.text = _fmt(template.effectMiscValueB0);
    effectRadiusIndex0Controller.text = _fmt(template.effectRadiusIndex0);
    effectChainAmplitude0Controller.text = _fmt(template.effectChainAmplitude0);
    effectBonusCoefficient0Controller.text = _fmt(
      template.effectBonusCoefficient0,
    );
    effectItemType0Controller.value = {template.effectItemType0};
    effectTriggerSpell0Controller.text = _fmt(template.effectTriggerSpell0);
    effectPointsPerCombo0Controller.text = _fmt(template.effectPointsPerCombo0);
    effectSpellClassMaskA0Controller.text = formatFlagValue(
      template.effectSpellClassMaskA0,
    );
    effectSpellClassMaskB0Controller.text = formatFlagValue(
      template.effectSpellClassMaskB0,
    );
    effectSpellClassMaskC0Controller.text = formatFlagValue(
      template.effectSpellClassMaskC0,
    );

    // === 效果1 ===
    effect1Controller.value = {template.effect1};
    effectBasePoints1Controller.text = _fmt(template.effectBasePoints1);
    effectDieSides1Controller.text = _fmt(template.effectDieSides1);
    effectRealPointsPerLevel1Controller.text = _fmt(
      template.effectRealPointsPerLevel1,
    );
    effectMechanic1Controller.value = {template.effectMechanic1};
    effectChainTargets1Controller.text = _fmt(template.effectChainTargets1);
    effectAura1Controller.value = {template.effectAura1};
    effectAuraPeriod1Controller.text = _fmt(template.effectAuraPeriod1);
    effectAmplitude1Controller.text = _fmt(template.effectAmplitude1);
    implicitTargetA1Controller.value = {template.implicitTargetA1};
    implicitTargetB1Controller.value = {template.implicitTargetB1};
    effectMiscValue1Controller.text = _fmt(template.effectMiscValue1);
    effectMiscValueB1Controller.text = _fmt(template.effectMiscValueB1);
    effectRadiusIndex1Controller.text = _fmt(template.effectRadiusIndex1);
    effectChainAmplitude1Controller.text = _fmt(template.effectChainAmplitude1);
    effectBonusCoefficient1Controller.text = _fmt(
      template.effectBonusCoefficient1,
    );
    effectItemType1Controller.value = {template.effectItemType1};
    effectTriggerSpell1Controller.text = _fmt(template.effectTriggerSpell1);
    effectPointsPerCombo1Controller.text = _fmt(template.effectPointsPerCombo1);
    effectSpellClassMaskA1Controller.text = formatFlagValue(
      template.effectSpellClassMaskA1,
    );
    effectSpellClassMaskB1Controller.text = formatFlagValue(
      template.effectSpellClassMaskB1,
    );
    effectSpellClassMaskC1Controller.text = formatFlagValue(
      template.effectSpellClassMaskC1,
    );

    // === 效果2 ===
    effect2Controller.value = {template.effect2};
    effectBasePoints2Controller.text = _fmt(template.effectBasePoints2);
    effectDieSides2Controller.text = _fmt(template.effectDieSides2);
    effectRealPointsPerLevel2Controller.text = _fmt(
      template.effectRealPointsPerLevel2,
    );
    effectMechanic2Controller.value = {template.effectMechanic2};
    effectChainTargets2Controller.text = _fmt(template.effectChainTargets2);
    effectAura2Controller.value = {template.effectAura2};
    effectAuraPeriod2Controller.text = _fmt(template.effectAuraPeriod2);
    effectAmplitude2Controller.text = _fmt(template.effectAmplitude2);
    implicitTargetA2Controller.value = {template.implicitTargetA2};
    implicitTargetB2Controller.value = {template.implicitTargetB2};
    effectMiscValue2Controller.text = _fmt(template.effectMiscValue2);
    effectMiscValueB2Controller.text = _fmt(template.effectMiscValueB2);
    effectRadiusIndex2Controller.text = _fmt(template.effectRadiusIndex2);
    effectChainAmplitude2Controller.text = _fmt(template.effectChainAmplitude2);
    effectBonusCoefficient2Controller.text = _fmt(
      template.effectBonusCoefficient2,
    );
    effectItemType2Controller.value = {template.effectItemType2};
    effectTriggerSpell2Controller.text = _fmt(template.effectTriggerSpell2);
    effectPointsPerCombo2Controller.text = _fmt(template.effectPointsPerCombo2);
    effectSpellClassMaskA2Controller.text = formatFlagValue(
      template.effectSpellClassMaskA2,
    );
    effectSpellClassMaskB2Controller.text = formatFlagValue(
      template.effectSpellClassMaskB2,
    );
    effectSpellClassMaskC2Controller.text = formatFlagValue(
      template.effectSpellClassMaskC2,
    );

    // === 装备限制 ===
    equippedItemClassController.value = {template.equippedItemClass};
    equippedItemSubclassController.text = _fmt(template.equippedItemSubclass);
    equippedItemInvTypesController.text = formatFlagValue(
      template.equippedItemInvTypes,
    );

    // === 图腾/施法材料 ===
    requiredTotemCategoryID0Controller.text = _fmt(
      template.requiredTotemCategoryID0,
    );
    totem0Controller.text = _fmt(template.totem0);
    requiredTotemCategoryID1Controller.text = _fmt(
      template.requiredTotemCategoryID1,
    );
    totem1Controller.text = _fmt(template.totem1);
    reagent0Controller.text = _fmt(template.reagent0);
    reagent1Controller.text = _fmt(template.reagent1);
    reagent2Controller.text = _fmt(template.reagent2);
    reagent3Controller.text = _fmt(template.reagent3);
    reagent4Controller.text = _fmt(template.reagent4);
    reagent5Controller.text = _fmt(template.reagent5);
    reagent6Controller.text = _fmt(template.reagent6);
    reagent7Controller.text = _fmt(template.reagent7);
    reagentCount0Controller.text = _fmt(template.reagentCount0);
    reagentCount1Controller.text = _fmt(template.reagentCount1);
    reagentCount2Controller.text = _fmt(template.reagentCount2);
    reagentCount3Controller.text = _fmt(template.reagentCount3);
    reagentCount4Controller.text = _fmt(template.reagentCount4);
    reagentCount5Controller.text = _fmt(template.reagentCount5);
    reagentCount6Controller.text = _fmt(template.reagentCount6);
    reagentCount7Controller.text = _fmt(template.reagentCount7);

    // === 其他高级属性 ===
    casterAuraSpellController.text = _fmt(template.casterAuraSpell);
    cumulativeAuraController.text = _fmt(template.cumulativeAura);
    minFactionIDController.text = _fmt(template.minFactionID);
    minReputationController.value = {template.minReputation};
    excludeCasterAuraSpellController.text = _fmt(
      template.excludeCasterAuraSpell,
    );
    excludeCasterAuraStateController.value = {template.excludeCasterAuraState};
    excludeTargetAuraSpellController.text = _fmt(
      template.excludeTargetAuraSpell,
    );
    excludeTargetAuraStateController.value = {template.excludeTargetAuraState};
    spellPriorityController.text = _fmt(template.spellPriority);
    modalNextSpellController.text = _fmt(template.modalNextSpell);
    requiredAuraVisionController.text = _fmt(template.requiredAuraVision);
    targetAuraSpellController.text = _fmt(template.targetAuraSpell);
    stanceBarOrderController.text = _fmt(template.stanceBarOrder);
    shapeshiftMask0Controller.text = formatFlagValue(template.shapeshiftMask0);
    shapeshiftExclude0Controller.text = formatFlagValue(
      template.shapeshiftExclude0,
    );
  }
}
