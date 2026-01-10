import 'package:flutter/widgets.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateDetailViewModel {
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
  final familyController = TextEditingController();
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

  /// Other
  final aiNameController = TextEditingController();
  final scriptNameController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final entry = signal(0);
  final template = signal(CreatureTemplate());

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
    familyController.text = template.family.toString();
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
    spellSchoolImmuneMaskController.text =
        template.spellSchoolImmuneMask.toString();

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

    /// Other
    aiNameController.text = template.aiName;
    scriptNameController.text = template.scriptName;
    verifiedBuildController.text = template.verifiedBuild.toString();
  }
}
