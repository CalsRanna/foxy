// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_offer_reward_single_editor_view_model.dart';

mixin _QuestOfferRewardSingleEditorViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final emote1Controller = registerController(IntFieldController());
  late final emote2Controller = registerController(IntFieldController());
  late final emote3Controller = registerController(IntFieldController());
  late final emote4Controller = registerController(IntFieldController());
  late final emoteDelay1Controller = registerController(IntFieldController());
  late final emoteDelay2Controller = registerController(IntFieldController());
  late final emoteDelay3Controller = registerController(IntFieldController());
  late final emoteDelay4Controller = registerController(IntFieldController());
  late final rewardTextController = registerController(StringFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  void _afterApplyCandidate(QuestOfferRewardEntity questOfferReward) {}

  void _applyCandidate(QuestOfferRewardEntity questOfferReward) {
    idController.init(questOfferReward.id);
    emote1Controller.init(questOfferReward.emote1);
    emote2Controller.init(questOfferReward.emote2);
    emote3Controller.init(questOfferReward.emote3);
    emote4Controller.init(questOfferReward.emote4);
    emoteDelay1Controller.init(questOfferReward.emoteDelay1);
    emoteDelay2Controller.init(questOfferReward.emoteDelay2);
    emoteDelay3Controller.init(questOfferReward.emoteDelay3);
    emoteDelay4Controller.init(questOfferReward.emoteDelay4);
    rewardTextController.init(questOfferReward.rewardText);
    verifiedBuildController.init(questOfferReward.verifiedBuild);
    _afterApplyCandidate(questOfferReward);
  }

  QuestOfferRewardEntity _collectCandidate() {
    return QuestOfferRewardEntity(
      id: idController.collect(),
      emote1: emote1Controller.collect(),
      emote2: emote2Controller.collect(),
      emote3: emote3Controller.collect(),
      emote4: emote4Controller.collect(),
      emoteDelay1: emoteDelay1Controller.collect(),
      emoteDelay2: emoteDelay2Controller.collect(),
      emoteDelay3: emoteDelay3Controller.collect(),
      emoteDelay4: emoteDelay4Controller.collect(),
      rewardText: rewardTextController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }
}
