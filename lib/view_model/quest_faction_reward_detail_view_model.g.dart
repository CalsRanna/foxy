// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_faction_reward_detail_view_model.dart';

mixin _QuestFactionRewardDetailViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final difficulty0Controller = registerController(IntFieldController());
  late final difficulty1Controller = registerController(IntFieldController());
  late final difficulty2Controller = registerController(IntFieldController());
  late final difficulty3Controller = registerController(IntFieldController());
  late final difficulty4Controller = registerController(IntFieldController());
  late final difficulty5Controller = registerController(IntFieldController());
  late final difficulty6Controller = registerController(IntFieldController());
  late final difficulty7Controller = registerController(IntFieldController());
  late final difficulty8Controller = registerController(IntFieldController());
  late final difficulty9Controller = registerController(IntFieldController());

  void _afterApplyCandidate(QuestFactionRewardEntity questFactionReward) {}

  void _applyCandidate(QuestFactionRewardEntity questFactionReward) {
    idController.init(questFactionReward.id);
    difficulty0Controller.init(questFactionReward.difficulty0);
    difficulty1Controller.init(questFactionReward.difficulty1);
    difficulty2Controller.init(questFactionReward.difficulty2);
    difficulty3Controller.init(questFactionReward.difficulty3);
    difficulty4Controller.init(questFactionReward.difficulty4);
    difficulty5Controller.init(questFactionReward.difficulty5);
    difficulty6Controller.init(questFactionReward.difficulty6);
    difficulty7Controller.init(questFactionReward.difficulty7);
    difficulty8Controller.init(questFactionReward.difficulty8);
    difficulty9Controller.init(questFactionReward.difficulty9);
    _afterApplyCandidate(questFactionReward);
  }

  QuestFactionRewardEntity _collectCandidate() {
    return QuestFactionRewardEntity(
      id: idController.collect(),
      difficulty0: difficulty0Controller.collect(),
      difficulty1: difficulty1Controller.collect(),
      difficulty2: difficulty2Controller.collect(),
      difficulty3: difficulty3Controller.collect(),
      difficulty4: difficulty4Controller.collect(),
      difficulty5: difficulty5Controller.collect(),
      difficulty6: difficulty6Controller.collect(),
      difficulty7: difficulty7Controller.collect(),
      difficulty8: difficulty8Controller.collect(),
      difficulty9: difficulty9Controller.collect(),
    );
  }
}
