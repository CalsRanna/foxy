// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_trainer_collection_editor_view_model.dart';

mixin _NpcTrainerCollectionEditorViewModelMixin on FieldControllerMixin {
  late final trainerIdController = registerController(IntFieldController());
  late final spellIdController = registerController(IntFieldController());
  late final moneyCostController = registerController(IntFieldController());
  late final reqSkillLineController = registerController(IntFieldController());
  late final reqSkillRankController = registerController(IntFieldController());
  late final reqAbility1Controller = registerController(IntFieldController());
  late final reqAbility2Controller = registerController(IntFieldController());
  late final reqAbility3Controller = registerController(IntFieldController());
  late final reqLevelController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  NpcTrainerEntity _collectCandidate() {
    return NpcTrainerEntity(
      trainerId: trainerIdController.collect(),
      spellId: spellIdController.collect(),
      moneyCost: moneyCostController.collect(),
      reqSkillLine: reqSkillLineController.collect(),
      reqSkillRank: reqSkillRankController.collect(),
      reqAbility1: reqAbility1Controller.collect(),
      reqAbility2: reqAbility2Controller.collect(),
      reqAbility3: reqAbility3Controller.collect(),
      reqLevel: reqLevelController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void _applyCandidate(NpcTrainerEntity npcTrainer) {
    trainerIdController.init(npcTrainer.trainerId);
    spellIdController.init(npcTrainer.spellId);
    moneyCostController.init(npcTrainer.moneyCost);
    reqSkillLineController.init(npcTrainer.reqSkillLine);
    reqSkillRankController.init(npcTrainer.reqSkillRank);
    reqAbility1Controller.init(npcTrainer.reqAbility1);
    reqAbility2Controller.init(npcTrainer.reqAbility2);
    reqAbility3Controller.init(npcTrainer.reqAbility3);
    reqLevelController.init(npcTrainer.reqLevel);
    verifiedBuildController.init(npcTrainer.verifiedBuild);
    _afterApplyCandidate(npcTrainer);
  }

  void _afterApplyCandidate(NpcTrainerEntity npcTrainer) {}
}
