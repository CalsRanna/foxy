import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/spell_entity.dart';
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
  final nameLangFlags = signal<int>(0);
  final nameSubtextLangFlags = signal<int>(0);
  final descriptionLangFlags = signal<int>(0);
  final auraDescriptionLangFlags = signal<int>(0);

  // === 图标/视觉 ===
  final spellIconIDController = TextEditingController();
  final activeIconIDController = TextEditingController();
  final spellVisualID0 = signal<int>(0);
  final spellVisualID1 = signal<int>(0);

  // === 分类/类型 ===
  final category = signal<int>(0);
  final schoolMask = signal<int>(0);
  final mechanic = signal<int>(0);
  final defenseType = signal<int>(0);
  final dispelType = signal<int>(0);
  final preventionType = signal<int>(0);

  // === 施法参数 ===
  final castingTimeIndex = signal<int>(0);
  final durationIndexController = TextEditingController();
  final rangeIndexController = TextEditingController();
  final spellDescriptionVariableID = signal<int>(0);

  // === 等级 ===
  final baseLevel = signal<int>(0);
  final spellLevel = signal<int>(0);
  final maxLevel = signal<int>(0);
  final spellDifficultyID = signal<int>(0);

  // === 冷却/恢复 ===
  final startRecoveryCategory = signal<int>(0);
  final startRecoveryTime = signal<int>(0);
  final recoveryTime = signal<int>(0);
  final categoryRecoveryTime = signal<int>(0);

  // === 目标 ===
  final targetCreatureType = signal<int>(0);
  final targets = signal<int>(0);
  final maxTargets = signal<int>(0);
  final maxTargetLevel = signal<int>(0);

  // === 状态 ===
  final casterAuraState = signal<int>(0);
  final targetAuraState = signal<int>(0);
  final spellMissileID = signal<int>(0);
  final speed = signal<double>(0.0);

  // === 需求 ===
  final requiredAreasIDController = TextEditingController();
  final requiresSpellFocus = signal<int>(0);
  final facingCasterFlags = signal<int>(0);

  // === 能量消耗 ===
  final powerDisplayID = signal<int>(0);
  final powerType = signal<int>(0);
  final runeCostID = signal<int>(0);
  final manaCost = signal<int>(0);
  final manaCostPct = signal<int>(0);
  final manaCostPerLevel = signal<int>(0);
  final manaPerSecond = signal<int>(0);
  final manaPerSecondPerLevel = signal<int>(0);

  // === 标志位 ===
  final interruptFlags = signal<int>(0);
  final auraInterruptFlags = signal<int>(0);
  final channelInterruptFlags = signal<int>(0);
  final attributes = signal<int>(0);
  final attributesEx = signal<int>(0);
  final attributesExB = signal<int>(0);
  final attributesExC = signal<int>(0);
  final attributesExD = signal<int>(0);
  final attributesExE = signal<int>(0);
  final attributesExF = signal<int>(0);
  final attributesExG = signal<int>(0);

  // === 触发 ===
  final procTypeMask = signal<int>(0);
  final procChance = signal<int>(0);
  final procCharges = signal<int>(0);

  // === 法术分类 ===
  final spellClassSet = signal<int>(0);
  final spellClassMask0 = signal<int>(0);
  final spellClassMask1 = signal<int>(0);
  final spellClassMask2 = signal<int>(0);

  // === 效果0 ===
  final effect0 = signal<int>(0);
  final effectBasePoints0 = signal<int>(0);
  final effectDieSides0 = signal<int>(0);
  final effectRealPointsPerLevel0 = signal<double>(0.0);
  final effectMechanic0 = signal<int>(0);
  final effectChainTargets0 = signal<int>(0);
  final effectAura0 = signal<int>(0);
  final effectAuraPeriod0 = signal<int>(0);
  final effectAmplitude0 = signal<double>(0.0);
  final implicitTargetA0 = signal<int>(0);
  final implicitTargetB0 = signal<int>(0);
  final effectMiscValue0 = signal<int>(0);
  final effectMiscValueB0 = signal<int>(0);
  final effectRadiusIndex0 = signal<int>(0);
  final effectChainAmplitude0 = signal<double>(0.0);
  final effectBonusCoefficient0 = signal<double>(0.0);
  final effectItemType0 = signal<int>(0);
  final effectTriggerSpell0 = signal<int>(0);
  final effectPointsPerCombo0 = signal<double>(0.0);
  final effectSpellClassMaskA0 = signal<int>(0);
  final effectSpellClassMaskB0 = signal<int>(0);
  final effectSpellClassMaskC0 = signal<int>(0);

  // === 效果1 ===
  final effect1 = signal<int>(0);
  final effectBasePoints1 = signal<int>(0);
  final effectDieSides1 = signal<int>(0);
  final effectRealPointsPerLevel1 = signal<double>(0.0);
  final effectMechanic1 = signal<int>(0);
  final effectChainTargets1 = signal<int>(0);
  final effectAura1 = signal<int>(0);
  final effectAuraPeriod1 = signal<int>(0);
  final effectAmplitude1 = signal<double>(0.0);
  final implicitTargetA1 = signal<int>(0);
  final implicitTargetB1 = signal<int>(0);
  final effectMiscValue1 = signal<int>(0);
  final effectMiscValueB1 = signal<int>(0);
  final effectRadiusIndex1 = signal<int>(0);
  final effectChainAmplitude1 = signal<double>(0.0);
  final effectBonusCoefficient1 = signal<double>(0.0);
  final effectItemType1 = signal<int>(0);
  final effectTriggerSpell1 = signal<int>(0);
  final effectPointsPerCombo1 = signal<double>(0.0);
  final effectSpellClassMaskA1 = signal<int>(0);
  final effectSpellClassMaskB1 = signal<int>(0);
  final effectSpellClassMaskC1 = signal<int>(0);

  // === 效果2 ===
  final effect2 = signal<int>(0);
  final effectBasePoints2 = signal<int>(0);
  final effectDieSides2 = signal<int>(0);
  final effectRealPointsPerLevel2 = signal<double>(0.0);
  final effectMechanic2 = signal<int>(0);
  final effectChainTargets2 = signal<int>(0);
  final effectAura2 = signal<int>(0);
  final effectAuraPeriod2 = signal<int>(0);
  final effectAmplitude2 = signal<double>(0.0);
  final implicitTargetA2 = signal<int>(0);
  final implicitTargetB2 = signal<int>(0);
  final effectMiscValue2 = signal<int>(0);
  final effectMiscValueB2 = signal<int>(0);
  final effectRadiusIndex2 = signal<int>(0);
  final effectChainAmplitude2 = signal<double>(0.0);
  final effectBonusCoefficient2 = signal<double>(0.0);
  final effectItemType2 = signal<int>(0);
  final effectTriggerSpell2 = signal<int>(0);
  final effectPointsPerCombo2 = signal<double>(0.0);
  final effectSpellClassMaskA2 = signal<int>(0);
  final effectSpellClassMaskB2 = signal<int>(0);
  final effectSpellClassMaskC2 = signal<int>(0);

  // === 装备限制 ===
  final equippedItemClass = signal<int>(0);
  final equippedItemSubclass = signal<int>(0);
  final equippedItemInvTypes = signal<int>(0);

  // === 图腾/施法材料 ===
  final requiredTotemCategoryID0 = signal<int>(0);
  final totem0 = signal<int>(0);
  final requiredTotemCategoryID1 = signal<int>(0);
  final totem1 = signal<int>(0);
  final reagent0 = signal<int>(0);
  final reagent1 = signal<int>(0);
  final reagent2 = signal<int>(0);
  final reagent3 = signal<int>(0);
  final reagent4 = signal<int>(0);
  final reagent5 = signal<int>(0);
  final reagent6 = signal<int>(0);
  final reagent7 = signal<int>(0);
  final reagentCount0 = signal<int>(0);
  final reagentCount1 = signal<int>(0);
  final reagentCount2 = signal<int>(0);
  final reagentCount3 = signal<int>(0);
  final reagentCount4 = signal<int>(0);
  final reagentCount5 = signal<int>(0);
  final reagentCount6 = signal<int>(0);
  final reagentCount7 = signal<int>(0);

  // === 其他高级属性 ===
  final casterAuraSpell = signal<int>(0);
  final cumulativeAura = signal<int>(0);
  final minFactionID = signal<int>(0);
  final minReputation = signal<int>(0);
  final excludeCasterAuraSpell = signal<int>(0);
  final excludeCasterAuraState = signal<int>(0);
  final excludeTargetAuraSpell = signal<int>(0);
  final excludeTargetAuraState = signal<int>(0);
  final spellPriority = signal<int>(0);
  final modalNextSpell = signal<int>(0);
  final requiredAuraVision = signal<int>(0);
  final targetAuraSpell = signal<int>(0);
  final stanceBarOrder = signal<int>(0);
  final shapeshiftMask0 = signal<int>(0);
  final shapeshiftExclude0 = signal<int>(0);

  final id = signal(0);
  final spell = signal(SpellEntity());
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = SpellRepository();
      if (t.id == 0) {
        await repository.storeSpell(t);
      } else {
        await repository.updateSpell(t);
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
    final t = SpellEntity(
      // === 基础文本 ===
      nameLangZhCN: nameLangZhCNController.text,
      nameSubtextLangZhCN: nameSubtextLangZhCNController.text,
      descriptionLangZhCN: descriptionLangZhCNController.text,
      auraDescriptionLangZhCN: auraDescriptionLangZhCNController.text,
      nameLangFlags: nameLangFlags.value,
      nameSubtextLangFlags: nameSubtextLangFlags.value,
      descriptionLangFlags: descriptionLangFlags.value,
      auraDescriptionLangFlags: auraDescriptionLangFlags.value,

      // === 图标/视觉 ===
      spellIconID: _parseInt(spellIconIDController.text),
      activeIconID: _parseInt(activeIconIDController.text),
      spellVisualID0: spellVisualID0.value,
      spellVisualID1: spellVisualID1.value,

      // === 分类/类型 ===
      category: category.value,
      schoolMask: schoolMask.value,
      mechanic: mechanic.value,
      defenseType: defenseType.value,
      dispelType: dispelType.value,
      preventionType: preventionType.value,

      // === 施法参数 ===
      castingTimeIndex: castingTimeIndex.value,
      durationIndex: _parseInt(durationIndexController.text),
      rangeIndex: _parseInt(rangeIndexController.text),
      spellDescriptionVariableID: spellDescriptionVariableID.value,

      // === 等级 ===
      baseLevel: baseLevel.value,
      spellLevel: spellLevel.value,
      maxLevel: maxLevel.value,
      spellDifficultyID: spellDifficultyID.value,

      // === 冷却/恢复 ===
      startRecoveryCategory: startRecoveryCategory.value,
      startRecoveryTime: startRecoveryTime.value,
      recoveryTime: recoveryTime.value,
      categoryRecoveryTime: categoryRecoveryTime.value,

      // === 目标 ===
      targetCreatureType: targetCreatureType.value,
      targets: targets.value,
      maxTargets: maxTargets.value,
      maxTargetLevel: maxTargetLevel.value,

      // === 状态 ===
      casterAuraState: casterAuraState.value,
      targetAuraState: targetAuraState.value,
      spellMissileID: spellMissileID.value,
      speed: speed.value,

      // === 需求 ===
      requiredAreasID: _parseInt(requiredAreasIDController.text),
      requiresSpellFocus: requiresSpellFocus.value,
      facingCasterFlags: facingCasterFlags.value,

      // === 能量消耗 ===
      powerDisplayID: powerDisplayID.value,
      powerType: powerType.value,
      runeCostID: runeCostID.value,
      manaCost: manaCost.value,
      manaCostPct: manaCostPct.value,
      manaCostPerLevel: manaCostPerLevel.value,
      manaPerSecond: manaPerSecond.value,
      manaPerSecondPerLevel: manaPerSecondPerLevel.value,

      // === 标志位 ===
      interruptFlags: interruptFlags.value,
      auraInterruptFlags: auraInterruptFlags.value,
      channelInterruptFlags: channelInterruptFlags.value,
      attributes: attributes.value,
      attributesEx: attributesEx.value,
      attributesExB: attributesExB.value,
      attributesExC: attributesExC.value,
      attributesExD: attributesExD.value,
      attributesExE: attributesExE.value,
      attributesExF: attributesExF.value,
      attributesExG: attributesExG.value,

      // === 触发 ===
      procTypeMask: procTypeMask.value,
      procChance: procChance.value,
      procCharges: procCharges.value,

      // === 法术分类 ===
      spellClassSet: spellClassSet.value,
      spellClassMask0: spellClassMask0.value,
      spellClassMask1: spellClassMask1.value,
      spellClassMask2: spellClassMask2.value,

      // === 效果0 ===
      effect0: effect0.value,
      effectBasePoints0: effectBasePoints0.value,
      effectDieSides0: effectDieSides0.value,
      effectRealPointsPerLevel0: effectRealPointsPerLevel0.value,
      effectMechanic0: effectMechanic0.value,
      effectChainTargets0: effectChainTargets0.value,
      effectAura0: effectAura0.value,
      effectAuraPeriod0: effectAuraPeriod0.value,
      effectAmplitude0: effectAmplitude0.value,
      implicitTargetA0: implicitTargetA0.value,
      implicitTargetB0: implicitTargetB0.value,
      effectMiscValue0: effectMiscValue0.value,
      effectMiscValueB0: effectMiscValueB0.value,
      effectRadiusIndex0: effectRadiusIndex0.value,
      effectChainAmplitude0: effectChainAmplitude0.value,
      effectBonusCoefficient0: effectBonusCoefficient0.value,
      effectItemType0: effectItemType0.value,
      effectTriggerSpell0: effectTriggerSpell0.value,
      effectPointsPerCombo0: effectPointsPerCombo0.value,
      effectSpellClassMaskA0: effectSpellClassMaskA0.value,
      effectSpellClassMaskB0: effectSpellClassMaskB0.value,
      effectSpellClassMaskC0: effectSpellClassMaskC0.value,

      // === 效果1 ===
      effect1: effect1.value,
      effectBasePoints1: effectBasePoints1.value,
      effectDieSides1: effectDieSides1.value,
      effectRealPointsPerLevel1: effectRealPointsPerLevel1.value,
      effectMechanic1: effectMechanic1.value,
      effectChainTargets1: effectChainTargets1.value,
      effectAura1: effectAura1.value,
      effectAuraPeriod1: effectAuraPeriod1.value,
      effectAmplitude1: effectAmplitude1.value,
      implicitTargetA1: implicitTargetA1.value,
      implicitTargetB1: implicitTargetB1.value,
      effectMiscValue1: effectMiscValue1.value,
      effectMiscValueB1: effectMiscValueB1.value,
      effectRadiusIndex1: effectRadiusIndex1.value,
      effectChainAmplitude1: effectChainAmplitude1.value,
      effectBonusCoefficient1: effectBonusCoefficient1.value,
      effectItemType1: effectItemType1.value,
      effectTriggerSpell1: effectTriggerSpell1.value,
      effectPointsPerCombo1: effectPointsPerCombo1.value,
      effectSpellClassMaskA1: effectSpellClassMaskA1.value,
      effectSpellClassMaskB1: effectSpellClassMaskB1.value,
      effectSpellClassMaskC1: effectSpellClassMaskC1.value,

      // === 效果2 ===
      effect2: effect2.value,
      effectBasePoints2: effectBasePoints2.value,
      effectDieSides2: effectDieSides2.value,
      effectRealPointsPerLevel2: effectRealPointsPerLevel2.value,
      effectMechanic2: effectMechanic2.value,
      effectChainTargets2: effectChainTargets2.value,
      effectAura2: effectAura2.value,
      effectAuraPeriod2: effectAuraPeriod2.value,
      effectAmplitude2: effectAmplitude2.value,
      implicitTargetA2: implicitTargetA2.value,
      implicitTargetB2: implicitTargetB2.value,
      effectMiscValue2: effectMiscValue2.value,
      effectMiscValueB2: effectMiscValueB2.value,
      effectRadiusIndex2: effectRadiusIndex2.value,
      effectChainAmplitude2: effectChainAmplitude2.value,
      effectBonusCoefficient2: effectBonusCoefficient2.value,
      effectItemType2: effectItemType2.value,
      effectTriggerSpell2: effectTriggerSpell2.value,
      effectPointsPerCombo2: effectPointsPerCombo2.value,
      effectSpellClassMaskA2: effectSpellClassMaskA2.value,
      effectSpellClassMaskB2: effectSpellClassMaskB2.value,
      effectSpellClassMaskC2: effectSpellClassMaskC2.value,

      // === 装备限制 ===
      equippedItemClass: equippedItemClass.value,
      equippedItemSubclass: equippedItemSubclass.value,
      equippedItemInvTypes: equippedItemInvTypes.value,

      // === 图腾/施法材料 ===
      requiredTotemCategoryID0: requiredTotemCategoryID0.value,
      totem0: totem0.value,
      requiredTotemCategoryID1: requiredTotemCategoryID1.value,
      totem1: totem1.value,
      reagent0: reagent0.value,
      reagent1: reagent1.value,
      reagent2: reagent2.value,
      reagent3: reagent3.value,
      reagent4: reagent4.value,
      reagent5: reagent5.value,
      reagent6: reagent6.value,
      reagent7: reagent7.value,
      reagentCount0: reagentCount0.value,
      reagentCount1: reagentCount1.value,
      reagentCount2: reagentCount2.value,
      reagentCount3: reagentCount3.value,
      reagentCount4: reagentCount4.value,
      reagentCount5: reagentCount5.value,
      reagentCount6: reagentCount6.value,
      reagentCount7: reagentCount7.value,

      // === 其他高级属性 ===
      casterAuraSpell: casterAuraSpell.value,
      cumulativeAura: cumulativeAura.value,
      minFactionID: minFactionID.value,
      minReputation: minReputation.value,
      excludeCasterAuraSpell: excludeCasterAuraSpell.value,
      excludeCasterAuraState: excludeCasterAuraState.value,
      excludeTargetAuraSpell: excludeTargetAuraSpell.value,
      excludeTargetAuraState: excludeTargetAuraState.value,
      spellPriority: spellPriority.value,
      modalNextSpell: modalNextSpell.value,
      requiredAuraVision: requiredAuraVision.value,
      targetAuraSpell: targetAuraSpell.value,
      stanceBarOrder: stanceBarOrder.value,
      shapeshiftMask0: shapeshiftMask0.value,
      shapeshiftExclude0: shapeshiftExclude0.value,
    );
    return t;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
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
    // === 基础文本 ===
    nameLangZhCNController.dispose();
    nameSubtextLangZhCNController.dispose();
    descriptionLangZhCNController.dispose();
    auraDescriptionLangZhCNController.dispose();

    // === 图标/视觉 ===
    spellIconIDController.dispose();
    activeIconIDController.dispose();

    // === 分类/类型 ===

    // === 施法参数 ===
    durationIndexController.dispose();
    rangeIndexController.dispose();

    // === 等级 ===

    // === 冷却/恢复 ===

    // === 目标 ===

    // === 状态 ===

    // === 需求 ===
    requiredAreasIDController.dispose();

    // === 能量消耗 ===

    // === 标志位 ===

    // === 触发 ===

    // === 法术分类 ===

    // === 效果0 ===

    // === 效果1 ===

    // === 效果2 ===

    // === 装备限制 ===

    // === 图腾/施法材料 ===

    // === 其他高级属性 ===
  }

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      spell.value = await SpellRepository().getSpell(id);
      _initControllers(spell.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载法术(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(SpellEntity template) {
    // === 基础文本 ===
    nameLangZhCNController.text = template.nameLangZhCN;
    nameSubtextLangZhCNController.text = template.nameSubtextLangZhCN;
    descriptionLangZhCNController.text = template.descriptionLangZhCN;
    auraDescriptionLangZhCNController.text = template.auraDescriptionLangZhCN;
    nameLangFlags.value = template.nameLangFlags;
    nameSubtextLangFlags.value = template.nameSubtextLangFlags;
    descriptionLangFlags.value = template.descriptionLangFlags;
    auraDescriptionLangFlags.value = template.auraDescriptionLangFlags;

    // === 图标/视觉 ===
    spellIconIDController.text = template.spellIconID.toString();
    activeIconIDController.text = template.activeIconID.toString();
    spellVisualID0.value = template.spellVisualID0;
    spellVisualID1.value = template.spellVisualID1;

    // === 分类/类型 ===
    category.value = template.category;
    schoolMask.value = template.schoolMask;
    mechanic.value = template.mechanic;
    defenseType.value = template.defenseType;
    dispelType.value = template.dispelType;
    preventionType.value = template.preventionType;

    // === 施法参数 ===
    castingTimeIndex.value = template.castingTimeIndex;
    durationIndexController.text = template.durationIndex.toString();
    rangeIndexController.text = template.rangeIndex.toString();
    spellDescriptionVariableID.value = template.spellDescriptionVariableID;

    // === 等级 ===
    baseLevel.value = template.baseLevel;
    spellLevel.value = template.spellLevel;
    maxLevel.value = template.maxLevel;
    spellDifficultyID.value = template.spellDifficultyID;

    // === 冷却/恢复 ===
    startRecoveryCategory.value = template.startRecoveryCategory;
    startRecoveryTime.value = template.startRecoveryTime;
    recoveryTime.value = template.recoveryTime;
    categoryRecoveryTime.value = template.categoryRecoveryTime;

    // === 目标 ===
    targetCreatureType.value = template.targetCreatureType;
    targets.value = template.targets;
    maxTargets.value = template.maxTargets;
    maxTargetLevel.value = template.maxTargetLevel;

    // === 状态 ===
    casterAuraState.value = template.casterAuraState;
    targetAuraState.value = template.targetAuraState;
    spellMissileID.value = template.spellMissileID;
    speed.value = template.speed;

    // === 需求 ===
    requiredAreasIDController.text = template.requiredAreasID.toString();
    requiresSpellFocus.value = template.requiresSpellFocus;
    facingCasterFlags.value = template.facingCasterFlags;

    // === 能量消耗 ===
    powerDisplayID.value = template.powerDisplayID;
    powerType.value = template.powerType;
    runeCostID.value = template.runeCostID;
    manaCost.value = template.manaCost;
    manaCostPct.value = template.manaCostPct;
    manaCostPerLevel.value = template.manaCostPerLevel;
    manaPerSecond.value = template.manaPerSecond;
    manaPerSecondPerLevel.value = template.manaPerSecondPerLevel;

    // === 标志位 ===
    interruptFlags.value = template.interruptFlags;
    auraInterruptFlags.value = template.auraInterruptFlags;
    channelInterruptFlags.value = template.channelInterruptFlags;
    attributes.value = template.attributes;
    attributesEx.value = template.attributesEx;
    attributesExB.value = template.attributesExB;
    attributesExC.value = template.attributesExC;
    attributesExD.value = template.attributesExD;
    attributesExE.value = template.attributesExE;
    attributesExF.value = template.attributesExF;
    attributesExG.value = template.attributesExG;

    // === 触发 ===
    procTypeMask.value = template.procTypeMask;
    procChance.value = template.procChance;
    procCharges.value = template.procCharges;

    // === 法术分类 ===
    spellClassSet.value = template.spellClassSet;
    spellClassMask0.value = template.spellClassMask0;
    spellClassMask1.value = template.spellClassMask1;
    spellClassMask2.value = template.spellClassMask2;

    // === 效果0 ===
    effect0.value = template.effect0;
    effectBasePoints0.value = template.effectBasePoints0;
    effectDieSides0.value = template.effectDieSides0;
    effectRealPointsPerLevel0.value = template.effectRealPointsPerLevel0;
    effectMechanic0.value = template.effectMechanic0;
    effectChainTargets0.value = template.effectChainTargets0;
    effectAura0.value = template.effectAura0;
    effectAuraPeriod0.value = template.effectAuraPeriod0;
    effectAmplitude0.value = template.effectAmplitude0;
    implicitTargetA0.value = template.implicitTargetA0;
    implicitTargetB0.value = template.implicitTargetB0;
    effectMiscValue0.value = template.effectMiscValue0;
    effectMiscValueB0.value = template.effectMiscValueB0;
    effectRadiusIndex0.value = template.effectRadiusIndex0;
    effectChainAmplitude0.value = template.effectChainAmplitude0;
    effectBonusCoefficient0.value = template.effectBonusCoefficient0;
    effectItemType0.value = template.effectItemType0;
    effectTriggerSpell0.value = template.effectTriggerSpell0;
    effectPointsPerCombo0.value = template.effectPointsPerCombo0;
    effectSpellClassMaskA0.value = template.effectSpellClassMaskA0;
    effectSpellClassMaskB0.value = template.effectSpellClassMaskB0;
    effectSpellClassMaskC0.value = template.effectSpellClassMaskC0;

    // === 效果1 ===
    effect1.value = template.effect1;
    effectBasePoints1.value = template.effectBasePoints1;
    effectDieSides1.value = template.effectDieSides1;
    effectRealPointsPerLevel1.value = template.effectRealPointsPerLevel1;
    effectMechanic1.value = template.effectMechanic1;
    effectChainTargets1.value = template.effectChainTargets1;
    effectAura1.value = template.effectAura1;
    effectAuraPeriod1.value = template.effectAuraPeriod1;
    effectAmplitude1.value = template.effectAmplitude1;
    implicitTargetA1.value = template.implicitTargetA1;
    implicitTargetB1.value = template.implicitTargetB1;
    effectMiscValue1.value = template.effectMiscValue1;
    effectMiscValueB1.value = template.effectMiscValueB1;
    effectRadiusIndex1.value = template.effectRadiusIndex1;
    effectChainAmplitude1.value = template.effectChainAmplitude1;
    effectBonusCoefficient1.value = template.effectBonusCoefficient1;
    effectItemType1.value = template.effectItemType1;
    effectTriggerSpell1.value = template.effectTriggerSpell1;
    effectPointsPerCombo1.value = template.effectPointsPerCombo1;
    effectSpellClassMaskA1.value = template.effectSpellClassMaskA1;
    effectSpellClassMaskB1.value = template.effectSpellClassMaskB1;
    effectSpellClassMaskC1.value = template.effectSpellClassMaskC1;

    // === 效果2 ===
    effect2.value = template.effect2;
    effectBasePoints2.value = template.effectBasePoints2;
    effectDieSides2.value = template.effectDieSides2;
    effectRealPointsPerLevel2.value = template.effectRealPointsPerLevel2;
    effectMechanic2.value = template.effectMechanic2;
    effectChainTargets2.value = template.effectChainTargets2;
    effectAura2.value = template.effectAura2;
    effectAuraPeriod2.value = template.effectAuraPeriod2;
    effectAmplitude2.value = template.effectAmplitude2;
    implicitTargetA2.value = template.implicitTargetA2;
    implicitTargetB2.value = template.implicitTargetB2;
    effectMiscValue2.value = template.effectMiscValue2;
    effectMiscValueB2.value = template.effectMiscValueB2;
    effectRadiusIndex2.value = template.effectRadiusIndex2;
    effectChainAmplitude2.value = template.effectChainAmplitude2;
    effectBonusCoefficient2.value = template.effectBonusCoefficient2;
    effectItemType2.value = template.effectItemType2;
    effectTriggerSpell2.value = template.effectTriggerSpell2;
    effectPointsPerCombo2.value = template.effectPointsPerCombo2;
    effectSpellClassMaskA2.value = template.effectSpellClassMaskA2;
    effectSpellClassMaskB2.value = template.effectSpellClassMaskB2;
    effectSpellClassMaskC2.value = template.effectSpellClassMaskC2;

    // === 装备限制 ===
    equippedItemClass.value = template.equippedItemClass;
    equippedItemSubclass.value = template.equippedItemSubclass;
    equippedItemInvTypes.value = template.equippedItemInvTypes;

    // === 图腾/施法材料 ===
    requiredTotemCategoryID0.value = template.requiredTotemCategoryID0;
    totem0.value = template.totem0;
    requiredTotemCategoryID1.value = template.requiredTotemCategoryID1;
    totem1.value = template.totem1;
    reagent0.value = template.reagent0;
    reagent1.value = template.reagent1;
    reagent2.value = template.reagent2;
    reagent3.value = template.reagent3;
    reagent4.value = template.reagent4;
    reagent5.value = template.reagent5;
    reagent6.value = template.reagent6;
    reagent7.value = template.reagent7;
    reagentCount0.value = template.reagentCount0;
    reagentCount1.value = template.reagentCount1;
    reagentCount2.value = template.reagentCount2;
    reagentCount3.value = template.reagentCount3;
    reagentCount4.value = template.reagentCount4;
    reagentCount5.value = template.reagentCount5;
    reagentCount6.value = template.reagentCount6;
    reagentCount7.value = template.reagentCount7;

    // === 其他高级属性 ===
    casterAuraSpell.value = template.casterAuraSpell;
    cumulativeAura.value = template.cumulativeAura;
    minFactionID.value = template.minFactionID;
    minReputation.value = template.minReputation;
    excludeCasterAuraSpell.value = template.excludeCasterAuraSpell;
    excludeCasterAuraState.value = template.excludeCasterAuraState;
    excludeTargetAuraSpell.value = template.excludeTargetAuraSpell;
    excludeTargetAuraState.value = template.excludeTargetAuraState;
    spellPriority.value = template.spellPriority;
    modalNextSpell.value = template.modalNextSpell;
    requiredAuraVision.value = template.requiredAuraVision;
    targetAuraSpell.value = template.targetAuraSpell;
    stanceBarOrder.value = template.stanceBarOrder;
    shapeshiftMask0.value = template.shapeshiftMask0;
    shapeshiftExclude0.value = template.shapeshiftExclude0;
  }
}
