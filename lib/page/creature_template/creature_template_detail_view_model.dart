import 'package:flutter/widgets.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final subNameController = TextEditingController();
  final iconNameController = TextEditingController();
  final minLevelController = TextEditingController();
  final maxLevelController = TextEditingController();
  final unitClassController = ShadSelectController<int>();
  final rankController = ShadSelectController<int>();
  final racialLeaderController = ShadSelectController<int>();
  final factionController = TextEditingController();
  final familyController = ShadSelectController<int>();
  final typeController = ShadSelectController<int>();
  final regenerateHealthController = ShadSelectController<int>();
  final petSpellDataIdController = TextEditingController();
  final vehicleIdController = TextEditingController();
  final gossipMenuIdController = TextEditingController();

  /// Flag
  final npcFlagController = TextEditingController();
  final typeFlagController = TextEditingController();
  final dynamicFlagController = TextEditingController();
  final extraFlagController = TextEditingController();
  final unitFlagController = TextEditingController();
  final unitFlag2Controller = TextEditingController();

  /// Immune
  final mechanicImmuneMaskController = TextEditingController();
  final spellSchoolImmuneMaskController = TextEditingController();

  /// Modifier
  final expController = ShadSelectController<int>();
  final damageSchoolController = ShadSelectController<int>();
  final damageModifierController = TextEditingController();
  final armorModifierController = TextEditingController();
  final baseAttackTimeController = TextEditingController();
  final baseVarianceController = TextEditingController();
  final rangeAttackTimeController = TextEditingController();
  final rangeVarianceController = TextEditingController();
  final healthModifierController = TextEditingController();
  final manaModifierController = TextEditingController();
  final experienceModifierController = TextEditingController();
  final speedWalkController = TextEditingController();
  final speedRunController = TextEditingController();

  /// Loot
  final minGoldController = TextEditingController();
  final maxGoldController = TextEditingController();
  final lootController = TextEditingController();
  final pickpocketLootController = TextEditingController();
  final skinLootController = TextEditingController();

  /// Difficulty
  final killCredit1Controller = TextEditingController();
  final killCredit2Controller = TextEditingController();
  final difficultyEntry1Controller = TextEditingController();
  final difficultyEntry2Controller = TextEditingController();
  final difficultyEntry3Controller = TextEditingController();

  /// Model
  final modelId1Controller = TextEditingController();
  final modelId2Controller = TextEditingController();
  final modelId3Controller = TextEditingController();
  final modelId4Controller = TextEditingController();
  final scaleController = TextEditingController();

  /// Movement
  final movementIdController = TextEditingController();
  final movementTypeController = ShadSelectController<int>();
  final hoverHeightController = TextEditingController();
  final inhabitTypeController = TextEditingController();

  /// Trainer
  final trainerTypeController = ShadSelectController<int>();
  final trainerSpellController = TextEditingController();
  final trainerClassController = ShadSelectController<int>();
  final trainerRaceController = ShadSelectController<int>();

  /// Other
  final aiNameController = TextEditingController();
  final scriptNameController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final entry = signal(0);
  final template = signal(CreatureTemplate());

  /// 保存模板到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = CreatureTemplateRepository();
      if (t.entry == 0) {
        // 新建
        await repository.storeCreatureTemplate(t);
      } else {
        // 更新
        await repository.updateCreatureTemplate(t);
      }
      template.value = t;
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

  /// 从所有 Controller 收集数据构建 CreatureTemplate
  CreatureTemplate _collectFromControllers() {
    final t = CreatureTemplate();

    /// Basic
    t.entry = _parseInt(entryController.text);
    t.name = nameController.text;
    t.subName = subNameController.text;
    t.iconName = iconNameController.text;
    t.minLevel = _parseInt(minLevelController.text);
    t.maxLevel = _parseInt(maxLevelController.text);
    t.unitClass = _getSelectValue(unitClassController);
    t.rank = _getSelectValue(rankController);
    t.racialLeader = _getSelectValue(racialLeaderController);
    t.faction = _parseInt(factionController.text);
    t.family = _getSelectValue(familyController);
    t.type = _getSelectValue(typeController);
    t.regenHealth = _getSelectValue(regenerateHealthController);
    t.petSpellDataId = _parseInt(petSpellDataIdController.text);
    t.vehicleId = _parseInt(vehicleIdController.text);
    t.gossipMenuId = _parseInt(gossipMenuIdController.text);

    /// Flag
    t.npcFlag = _parseInt(npcFlagController.text);
    t.typeFlags = _parseInt(typeFlagController.text);
    t.dynamicFlags = _parseInt(dynamicFlagController.text);
    t.flagsExtra = _parseInt(extraFlagController.text);
    t.unitFlags = _parseInt(unitFlagController.text);
    t.unitFlags2 = _parseInt(unitFlag2Controller.text);

    /// Immune
    t.mechanicImmuneMask = _parseInt(mechanicImmuneMaskController.text);
    t.spellSchoolImmuneMask = _parseInt(spellSchoolImmuneMaskController.text);

    /// Modifier
    t.exp = _getSelectValue(expController);
    t.damageSchool = _getSelectValue(damageSchoolController);
    t.damageModifier = _parseDouble(damageModifierController.text);
    t.armorModifier = _parseDouble(armorModifierController.text);
    t.baseAttackTime = _parseInt(baseAttackTimeController.text);
    t.baseVariance = _parseDouble(baseVarianceController.text);
    t.rangeAttackTime = _parseInt(rangeAttackTimeController.text);
    t.rangeVariance = _parseDouble(rangeVarianceController.text);
    t.healthModifier = _parseDouble(healthModifierController.text);
    t.manaModifier = _parseDouble(manaModifierController.text);
    t.experienceModifier = _parseDouble(experienceModifierController.text);
    t.speedWalk = _parseDouble(speedWalkController.text);
    t.speedRun = _parseDouble(speedRunController.text);

    /// Loot
    t.minGold = _parseInt(minGoldController.text);
    t.maxGold = _parseInt(maxGoldController.text);
    t.lootId = _parseInt(lootController.text);
    t.pickpocketLoot = _parseInt(pickpocketLootController.text);
    t.skinLoot = _parseInt(skinLootController.text);

    /// Difficulty
    t.killCredit1 = _parseInt(killCredit1Controller.text);
    t.killCredit2 = _parseInt(killCredit2Controller.text);
    t.difficultyEntry1 = _parseInt(difficultyEntry1Controller.text);
    t.difficultyEntry2 = _parseInt(difficultyEntry2Controller.text);
    t.difficultyEntry3 = _parseInt(difficultyEntry3Controller.text);

    /// Model
    t.modelId1 = _parseInt(modelId1Controller.text);
    t.modelId2 = _parseInt(modelId2Controller.text);
    t.modelId3 = _parseInt(modelId3Controller.text);
    t.modelId4 = _parseInt(modelId4Controller.text);
    t.scale = _parseDouble(scaleController.text);

    /// Movement
    t.movementId = _parseInt(movementIdController.text);
    t.movementType = _getSelectValue(movementTypeController);
    t.hoverHeight = _parseDouble(hoverHeightController.text);
    t.inhabitType = _parseInt(inhabitTypeController.text);

    /// Trainer
    t.trainerType = _getSelectValue(trainerTypeController);
    t.trainerSpell = _parseInt(trainerSpellController.text);
    t.trainerClass = _getSelectValue(trainerClassController);
    t.trainerRace = _getSelectValue(trainerRaceController);

    /// Other
    t.aiName = aiNameController.text;
    t.scriptName = scriptNameController.text;
    t.verifiedBuild = _parseInt(verifiedBuildController.text);

    return t;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);
  double _parseDouble(String text) => text.isEmpty ? 0.0 : double.parse(text);
  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;

  void dispose() {
    /// Basic
    entryController.dispose();
    nameController.dispose();
    subNameController.dispose();
    iconNameController.dispose();
    minLevelController.dispose();
    maxLevelController.dispose();
    unitClassController.dispose();
    rankController.dispose();
    racialLeaderController.dispose();
    factionController.dispose();
    familyController.dispose();
    typeController.dispose();
    regenerateHealthController.dispose();
    petSpellDataIdController.dispose();
    vehicleIdController.dispose();
    gossipMenuIdController.dispose();

    /// Flag
    npcFlagController.dispose();
    typeFlagController.dispose();
    dynamicFlagController.dispose();
    extraFlagController.dispose();
    unitFlagController.dispose();
    unitFlag2Controller.dispose();

    /// Immune
    mechanicImmuneMaskController.dispose();
    spellSchoolImmuneMaskController.dispose();

    /// Modifier
    expController.dispose();
    damageSchoolController.dispose();
    damageModifierController.dispose();
    armorModifierController.dispose();
    baseAttackTimeController.dispose();
    baseVarianceController.dispose();
    rangeAttackTimeController.dispose();
    rangeVarianceController.dispose();
    healthModifierController.dispose();
    manaModifierController.dispose();
    experienceModifierController.dispose();
    speedWalkController.dispose();
    speedRunController.dispose();

    /// Loot
    minGoldController.dispose();
    maxGoldController.dispose();
    lootController.dispose();
    pickpocketLootController.dispose();
    skinLootController.dispose();

    /// Difficulty
    killCredit1Controller.dispose();
    killCredit2Controller.dispose();
    difficultyEntry1Controller.dispose();
    difficultyEntry2Controller.dispose();
    difficultyEntry3Controller.dispose();

    /// Model
    modelId1Controller.dispose();
    modelId2Controller.dispose();
    modelId3Controller.dispose();
    modelId4Controller.dispose();
    scaleController.dispose();

    /// Movement
    movementIdController.dispose();
    movementTypeController.dispose();
    hoverHeightController.dispose();
    inhabitTypeController.dispose();

    /// Trainer
    trainerTypeController.dispose();
    trainerSpellController.dispose();
    trainerClassController.dispose();
    trainerRaceController.dispose();

    /// Other
    aiNameController.dispose();
    scriptNameController.dispose();
    verifiedBuildController.dispose();
  }

  Future<void> initSignals({int? entry}) async {
    if (entry == null) return;
    template.value = await CreatureTemplateRepository().getCreatureTemplate(
      entry,
    );
    _initControllers(template.value);
  }

  void _initControllers(CreatureTemplate template) {
    /// Basic
    entryController.text = template.entry.toString();
    nameController.text = template.name;
    subNameController.text = template.subName;
    iconNameController.text = template.iconName;
    minLevelController.text = template.minLevel.toString();
    maxLevelController.text = template.maxLevel.toString();
    unitClassController.value = {template.unitClass};
    rankController.value = {template.rank};
    racialLeaderController.value = {template.racialLeader};
    factionController.text = template.faction.toString();
    familyController.value = {template.family};
    typeController.value = {template.type};
    regenerateHealthController.value = {template.regenHealth};
    petSpellDataIdController.text = template.petSpellDataId.toString();
    vehicleIdController.text = template.vehicleId.toString();
    gossipMenuIdController.text = template.gossipMenuId.toString();

    /// Flag
    npcFlagController.text = template.npcFlag.toString();
    typeFlagController.text = template.typeFlags.toString();
    dynamicFlagController.text = template.dynamicFlags.toString();
    extraFlagController.text = template.flagsExtra.toString();
    unitFlagController.text = template.unitFlags.toString();
    unitFlag2Controller.text = template.unitFlags2.toString();

    /// Immune
    mechanicImmuneMaskController.text = template.mechanicImmuneMask.toString();
    spellSchoolImmuneMaskController.text = template.spellSchoolImmuneMask
        .toString();

    /// Modifier
    expController.value = {template.exp};
    damageSchoolController.value = {template.damageSchool};
    damageModifierController.text = template.damageModifier.toString();
    armorModifierController.text = template.armorModifier.toString();
    baseAttackTimeController.text = template.baseAttackTime.toString();
    baseVarianceController.text = template.baseVariance.toString();
    rangeAttackTimeController.text = template.rangeAttackTime.toString();
    rangeVarianceController.text = template.rangeVariance.toString();
    healthModifierController.text = template.healthModifier.toString();
    manaModifierController.text = template.manaModifier.toString();
    experienceModifierController.text = template.experienceModifier.toString();
    speedWalkController.text = template.speedWalk.toString();
    speedRunController.text = template.speedRun.toString();

    /// Loot
    minGoldController.text = template.minGold.toString();
    maxGoldController.text = template.maxGold.toString();
    lootController.text = template.lootId.toString();
    pickpocketLootController.text = template.pickpocketLoot.toString();
    skinLootController.text = template.skinLoot.toString();

    /// Difficulty
    killCredit1Controller.text = template.killCredit1.toString();
    killCredit2Controller.text = template.killCredit2.toString();
    difficultyEntry1Controller.text = template.difficultyEntry1.toString();
    difficultyEntry2Controller.text = template.difficultyEntry2.toString();
    difficultyEntry3Controller.text = template.difficultyEntry3.toString();

    /// Model
    modelId1Controller.text = template.modelId1.toString();
    modelId2Controller.text = template.modelId2.toString();
    modelId3Controller.text = template.modelId3.toString();
    modelId4Controller.text = template.modelId4.toString();
    scaleController.text = template.scale.toString();

    ///Movement
    movementIdController.text = template.movementId.toString();
    movementTypeController.value = {template.movementType};
    hoverHeightController.text = template.hoverHeight.toString();
    inhabitTypeController.text = template.inhabitType.toString();

    /// Trainer
    trainerTypeController.value = {template.trainerType};
    trainerSpellController.text = template.trainerSpell.toString();
    trainerClassController.value = {template.trainerClass};
    trainerRaceController.value = {template.trainerRace};

    /// Other
    aiNameController.text = template.aiName;
    scriptNameController.text = template.scriptName;
    verifiedBuildController.text = template.verifiedBuild.toString();
  }
}
