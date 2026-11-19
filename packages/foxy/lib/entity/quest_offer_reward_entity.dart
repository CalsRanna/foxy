import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'quest_offer_reward_entity.g.dart';

/// QuestOfferReward model
/// quest_offer_reward table, 1:1 with quest_template, sharing the ID
/// primary key.

@FoxyBriefEntity()
@FoxyFullEntity()
class QuestOfferRewardEntity with _QuestOfferRewardEntityMixin {
  @FoxyBriefField()
  @FoxyFieldMeaning.reference('任务', table: 'quest_template', column: 'ID')
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('表情1', table: 'foxy.dbc_emotes', column: 'ID')
  @FoxyFullField('Emote1')
  final int emote1;

  @FoxyFieldMeaning.reference('表情2', table: 'foxy.dbc_emotes', column: 'ID')
  @FoxyFullField('Emote2')
  final int emote2;

  @FoxyFieldMeaning.reference('表情3', table: 'foxy.dbc_emotes', column: 'ID')
  @FoxyFullField('Emote3')
  final int emote3;

  @FoxyFieldMeaning.reference('表情4', table: 'foxy.dbc_emotes', column: 'ID')
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
