// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_skill_linked_list_view_model.dart';

mixin _PlayerCreateInfoSkillLinkedListViewModelMixin on FieldControllerMixin {
  late final raceMaskController = registerController(FlagFieldController());
  late final classMaskController = registerController(FlagFieldController());
  late final skillController = registerController(IntFieldController());
  late final rankController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  void _afterApplyCandidate(
    PlayerCreateInfoSkillEntity playerCreateInfoSkill,
  ) {}

  void _applyCandidate(PlayerCreateInfoSkillEntity playerCreateInfoSkill) {
    raceMaskController.init(playerCreateInfoSkill.raceMask);
    classMaskController.init(playerCreateInfoSkill.classMask);
    skillController.init(playerCreateInfoSkill.skill);
    rankController.init(playerCreateInfoSkill.rank);
    commentController.init(playerCreateInfoSkill.comment);
    _afterApplyCandidate(playerCreateInfoSkill);
  }

  PlayerCreateInfoSkillEntity _collectCandidate() {
    return PlayerCreateInfoSkillEntity(
      raceMask: raceMaskController.collect(),
      classMask: classMaskController.collect(),
      skill: skillController.collect(),
      rank: rankController.collect(),
      comment: commentController.collect(),
    );
  }
}
