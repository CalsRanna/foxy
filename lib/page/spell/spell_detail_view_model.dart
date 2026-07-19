import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellDetailViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// 主键展示（只读）；新建时由 [createSpell] 预填 MAX+1。
  late final idController = registerController(IntFieldController());

  // === 基础文本 ===
  late final nameLangZhCNController = registerController(
    StringFieldController(),
  );
  late final nameSubtextLangZhCNController = registerController(
    StringFieldController(),
  );
  late final descriptionLangZhCNController = registerController(
    StringFieldController(),
  );
  late final auraDescriptionLangZhCNController = registerController(
    StringFieldController(),
  );
  late final nameLangFlagsController = registerController(IntFieldController());
  late final nameSubtextLangFlagsController = registerController(
    IntFieldController(),
  );
  late final descriptionLangFlagsController = registerController(
    IntFieldController(),
  );
  late final auraDescriptionLangFlagsController = registerController(
    IntFieldController(),
  );

  // === 图标/视觉 ===
  late final spellIconIDController = registerController(IntFieldController());
  late final activeIconIDController = registerController(IntFieldController());
  late final spellVisualID0Controller = registerController(
    IntFieldController(),
  );
  late final spellVisualID1Controller = registerController(
    IntFieldController(),
  );

  // === 分类/类型 ===
  late final categoryController = registerController(IntFieldController());

  late final schoolMaskFlagController = registerController(
    FlagFieldController(),
  );
  late final mechanicController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final defenseTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final dispelTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final preventionTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );

  // === 施法参数 ===
  late final castingTimeIndexController = registerController(
    IntFieldController(),
  );
  late final durationIndexController = registerController(IntFieldController());
  late final rangeIndexController = registerController(IntFieldController());
  late final spellDescriptionVariableIDController = registerController(
    IntFieldController(),
  );

  // === 等级 ===
  late final baseLevelController = registerController(IntFieldController());
  late final spellLevelController = registerController(IntFieldController());
  late final maxLevelController = registerController(IntFieldController());
  late final spellDifficultyIDController = registerController(
    IntFieldController(),
  );

  // === 冷却/恢复 ===
  late final startRecoveryCategoryController = registerController(
    IntFieldController(),
  );
  late final startRecoveryTimeController = registerController(
    IntFieldController(),
  );
  late final recoveryTimeController = registerController(IntFieldController());
  late final categoryRecoveryTimeController = registerController(
    IntFieldController(),
  );

  // === 目标 ===
  late final targetCreatureTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final targetsController = registerController(FlagFieldController());
  late final maxTargetsController = registerController(IntFieldController());
  late final maxTargetLevelController = registerController(
    IntFieldController(),
  );

  // === 状态 ===
  late final casterAuraStateController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final targetAuraStateController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellMissileIDController = registerController(
    IntFieldController(),
  );
  late final speedController = registerController(DoubleFieldController());

  // === 需求 ===
  late final requiredAreasIDController = registerController(
    IntFieldController(),
  );
  late final requiresSpellFocusController = registerController(
    IntFieldController(),
  );
  late final facingCasterFlagsController = registerController(
    FlagFieldController(),
  );

  // === 能量消耗 ===
  late final powerDisplayIDController = registerController(
    IntFieldController(),
  );
  late final powerTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final runeCostIDController = registerController(IntFieldController());
  late final manaCostController = registerController(IntFieldController());
  late final manaCostPctController = registerController(IntFieldController());
  late final manaCostPerLevelController = registerController(
    IntFieldController(),
  );
  late final manaPerSecondController = registerController(IntFieldController());
  late final manaPerSecondPerLevelController = registerController(
    IntFieldController(),
  );

  // === 标志位 ===
  late final interruptFlagsController = registerController(
    FlagFieldController(),
  );
  late final auraInterruptFlagsController = registerController(
    FlagFieldController(),
  );
  late final channelInterruptFlagsController = registerController(
    FlagFieldController(),
  );
  late final attributesController = registerController(FlagFieldController());
  late final attributesExController = registerController(FlagFieldController());
  late final attributesExBController = registerController(
    FlagFieldController(),
  );
  late final attributesExCController = registerController(
    FlagFieldController(),
  );
  late final attributesExDController = registerController(
    FlagFieldController(),
  );
  late final attributesExEController = registerController(
    FlagFieldController(),
  );
  late final attributesExFController = registerController(
    FlagFieldController(),
  );
  late final attributesExGController = registerController(
    FlagFieldController(),
  );

  // === 触发 ===
  late final procTypeMaskController = registerController(FlagFieldController());
  late final procChanceController = registerController(IntFieldController());
  late final procChargesController = registerController(IntFieldController());

  // === 法术分类 ===
  late final spellClassSetController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellClassMask0Controller = registerController(
    FlagFieldController(),
  );
  late final spellClassMask1Controller = registerController(
    FlagFieldController(),
  );
  late final spellClassMask2Controller = registerController(
    FlagFieldController(),
  );

  // === 效果0 ===
  late final effect0Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectBasePoints0Controller = registerController(
    IntFieldController(),
  );
  late final effectDieSides0Controller = registerController(
    IntFieldController(),
  );
  late final effectRealPointsPerLevel0Controller = registerController(
    DoubleFieldController(),
  );
  late final effectMechanic0Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectChainTargets0Controller = registerController(
    IntFieldController(),
  );
  late final effectAura0Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectAuraPeriod0Controller = registerController(
    IntFieldController(),
  );
  late final effectAmplitude0Controller = registerController(
    DoubleFieldController(),
  );
  late final implicitTargetA0Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final implicitTargetB0Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectMiscValue0Controller = registerController(
    IntFieldController(),
  );
  late final effectMiscValueB0Controller = registerController(
    IntFieldController(),
  );
  late final effectRadiusIndex0Controller = registerController(
    IntFieldController(),
  );
  late final effectChainAmplitude0Controller = registerController(
    DoubleFieldController(),
  );
  late final effectBonusCoefficient0Controller = registerController(
    DoubleFieldController(),
  );
  late final effectItemType0Controller = registerController(
    IntFieldController(),
  );
  late final effectTriggerSpell0Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsPerCombo0Controller = registerController(
    DoubleFieldController(),
  );
  late final effectSpellClassMaskA0Controller = registerController(
    FlagFieldController(),
  );
  late final effectSpellClassMaskB0Controller = registerController(
    FlagFieldController(),
  );
  late final effectSpellClassMaskC0Controller = registerController(
    FlagFieldController(),
  );

  // === 效果1 ===
  late final effect1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectBasePoints1Controller = registerController(
    IntFieldController(),
  );
  late final effectDieSides1Controller = registerController(
    IntFieldController(),
  );
  late final effectRealPointsPerLevel1Controller = registerController(
    DoubleFieldController(),
  );
  late final effectMechanic1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectChainTargets1Controller = registerController(
    IntFieldController(),
  );
  late final effectAura1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectAuraPeriod1Controller = registerController(
    IntFieldController(),
  );
  late final effectAmplitude1Controller = registerController(
    DoubleFieldController(),
  );
  late final implicitTargetA1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final implicitTargetB1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectMiscValue1Controller = registerController(
    IntFieldController(),
  );
  late final effectMiscValueB1Controller = registerController(
    IntFieldController(),
  );
  late final effectRadiusIndex1Controller = registerController(
    IntFieldController(),
  );
  late final effectChainAmplitude1Controller = registerController(
    DoubleFieldController(),
  );
  late final effectBonusCoefficient1Controller = registerController(
    DoubleFieldController(),
  );
  late final effectItemType1Controller = registerController(
    IntFieldController(),
  );
  late final effectTriggerSpell1Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsPerCombo1Controller = registerController(
    DoubleFieldController(),
  );
  late final effectSpellClassMaskA1Controller = registerController(
    FlagFieldController(),
  );
  late final effectSpellClassMaskB1Controller = registerController(
    FlagFieldController(),
  );
  late final effectSpellClassMaskC1Controller = registerController(
    FlagFieldController(),
  );

  // === 效果2 ===
  late final effect2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectBasePoints2Controller = registerController(
    IntFieldController(),
  );
  late final effectDieSides2Controller = registerController(
    IntFieldController(),
  );
  late final effectRealPointsPerLevel2Controller = registerController(
    DoubleFieldController(),
  );
  late final effectMechanic2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectChainTargets2Controller = registerController(
    IntFieldController(),
  );
  late final effectAura2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectAuraPeriod2Controller = registerController(
    IntFieldController(),
  );
  late final effectAmplitude2Controller = registerController(
    DoubleFieldController(),
  );
  late final implicitTargetA2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final implicitTargetB2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final effectMiscValue2Controller = registerController(
    IntFieldController(),
  );
  late final effectMiscValueB2Controller = registerController(
    IntFieldController(),
  );
  late final effectRadiusIndex2Controller = registerController(
    IntFieldController(),
  );
  late final effectChainAmplitude2Controller = registerController(
    DoubleFieldController(),
  );
  late final effectBonusCoefficient2Controller = registerController(
    DoubleFieldController(),
  );
  late final effectItemType2Controller = registerController(
    IntFieldController(),
  );
  late final effectTriggerSpell2Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsPerCombo2Controller = registerController(
    DoubleFieldController(),
  );
  late final effectSpellClassMaskA2Controller = registerController(
    FlagFieldController(),
  );
  late final effectSpellClassMaskB2Controller = registerController(
    FlagFieldController(),
  );
  late final effectSpellClassMaskC2Controller = registerController(
    FlagFieldController(),
  );

  // === 装备限制 ===
  late final equippedItemClassController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final equippedItemSubclassController = registerController(
    IntFieldController(),
  );
  late final equippedItemInvTypesController = registerController(
    FlagFieldController(),
  );

  // === 图腾/施法材料 ===
  late final requiredTotemCategoryID0Controller = registerController(
    IntFieldController(),
  );
  late final totem0Controller = registerController(IntFieldController());
  late final requiredTotemCategoryID1Controller = registerController(
    IntFieldController(),
  );
  late final totem1Controller = registerController(IntFieldController());
  late final reagent0Controller = registerController(IntFieldController());
  late final reagent1Controller = registerController(IntFieldController());
  late final reagent2Controller = registerController(IntFieldController());
  late final reagent3Controller = registerController(IntFieldController());
  late final reagent4Controller = registerController(IntFieldController());
  late final reagent5Controller = registerController(IntFieldController());
  late final reagent6Controller = registerController(IntFieldController());
  late final reagent7Controller = registerController(IntFieldController());
  late final reagentCount0Controller = registerController(IntFieldController());
  late final reagentCount1Controller = registerController(IntFieldController());
  late final reagentCount2Controller = registerController(IntFieldController());
  late final reagentCount3Controller = registerController(IntFieldController());
  late final reagentCount4Controller = registerController(IntFieldController());
  late final reagentCount5Controller = registerController(IntFieldController());
  late final reagentCount6Controller = registerController(IntFieldController());
  late final reagentCount7Controller = registerController(IntFieldController());

  // === 其他高级属性 ===
  late final casterAuraSpellController = registerController(
    IntFieldController(),
  );
  late final cumulativeAuraController = registerController(
    IntFieldController(),
  );
  late final minFactionIDController = registerController(IntFieldController());
  late final minReputationController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final excludeCasterAuraStateController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final excludeCasterAuraSpellController = registerController(
    IntFieldController(),
  );
  late final excludeTargetAuraSpellController = registerController(
    IntFieldController(),
  );
  late final excludeTargetAuraStateController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellPriorityController = registerController(IntFieldController());
  late final modalNextSpellController = registerController(
    IntFieldController(),
  );
  late final requiredAuraVisionController = registerController(
    IntFieldController(),
  );
  late final targetAuraSpellController = registerController(
    IntFieldController(),
  );
  late final stanceBarOrderController = registerController(
    IntFieldController(),
  );
  late final shapeshiftMask0Controller = registerController(
    FlagFieldController(),
  );
  late final shapeshiftMask1Controller = registerController(
    FlagFieldController(),
  );
  late final shapeshiftExclude0Controller = registerController(
    FlagFieldController(),
  );
  late final shapeshiftExclude1Controller = registerController(
    FlagFieldController(),
  );

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

  void dispose() {
    disposeControllers();
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

  void pop() {
    routerFacade.goBack();
  }

  Future<int?> save(BuildContext context) async {
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
      if (!context.mounted) return t.id;
      var toast = ShadToast(description: Text('法术数据已保存'));
      ShadSonner.of(context).show(toast);
      return t.id;
    } catch (e) {
      if (!context.mounted) return null;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
      return null;
    }
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
      shapeshiftMask1: shapeshiftMask1Controller.collect(),
      shapeshiftExclude0: shapeshiftExclude0Controller.collect(),
      shapeshiftExclude1: shapeshiftExclude1Controller.collect(),
    );
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
    shapeshiftMask1Controller.init(template.shapeshiftMask1);
    shapeshiftExclude0Controller.init(template.shapeshiftExclude0);
    shapeshiftExclude1Controller.init(template.shapeshiftExclude1);
  }

  void _logActivity(ActivityActionType action, SpellEntity t) {
    final log = ActivityLogEntity(
      module: 'spell',
      actionType: action,
      entityName: t.nameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  /// 监听 SelectFieldController 变化，同步到 signal。
  ///
  /// 使用 [SelectFieldController.addListener] 监听联动变化。
  void _wireEffectSignals() {
    if (_effectSignalsWired) return;
    _effectSignalsWired = true;

    void sync(SelectFieldController<int> ctrl, Signal<int> sig) {
      sig.value = ctrl.collect();
      ctrl.addListener(() => sig.value = ctrl.collect());
    }

    sync(effect0Controller, effect0Signal);
    sync(effect1Controller, effect1Signal);
    sync(effect2Controller, effect2Signal);
    sync(effectAura0Controller, effectAura0Signal);
    sync(effectAura1Controller, effectAura1Signal);
    sync(effectAura2Controller, effectAura2Signal);
    sync(spellClassSetController, spellClassSetSignal);
  }
}
