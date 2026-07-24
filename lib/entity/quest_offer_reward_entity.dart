// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'quest_offer_reward_entity.g.dart';

/// QuestOfferReward 模型
/// quest_offer_reward 表，1:1 关系与 quest_template，共享 ID 主键。

@FoxyBriefEntity()
@FoxyFullEntity(table: 'quest_offer_reward')
class QuestOfferRewardEntity with _QuestOfferRewardEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Emote1')
  final int emote1;

  @FoxyFullField('Emote2')
  final int emote2;

  @FoxyFullField('Emote3')
  final int emote3;

  @FoxyFullField('Emote4')
  final int emote4;

  @FoxyFullField('EmoteDelay1')
  final int emoteDelay1;

  @FoxyFullField('EmoteDelay2')
  final int emoteDelay2;

  @FoxyFullField('EmoteDelay3')
  final int emoteDelay3;

  @FoxyFullField('EmoteDelay4')
  final int emoteDelay4;

  @FoxyBriefField()
  @FoxyFullField('RewardText')
  final String rewardText;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const QuestOfferRewardEntity({
    this.id = 0,
    this.emote1 = 0,
    this.emote2 = 0,
    this.emote3 = 0,
    this.emote4 = 0,
    this.emoteDelay1 = 0,
    this.emoteDelay2 = 0,
    this.emoteDelay3 = 0,
    this.emoteDelay4 = 0,
    this.rewardText = '',
    this.verifiedBuild = 0,
  });

  factory QuestOfferRewardEntity.fromJson(Map<String, dynamic> json) =>
      _QuestOfferRewardEntityMixin.fromJson(json);
}
