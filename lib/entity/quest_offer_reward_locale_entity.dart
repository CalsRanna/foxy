import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'quest_offer_reward_locale_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'quest_offer_reward_locale')
class QuestOfferRewardLocaleEntity with _QuestOfferRewardLocaleEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('locale', key: true)
  final String locale;

  @FoxyBriefField()
  @FoxyFullField('RewardText')
  final String rewardText;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const QuestOfferRewardLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.rewardText = '',
    this.verifiedBuild = 0,
  });

  factory QuestOfferRewardLocaleEntity.fromJson(Map<String, dynamic> json) =>
      _QuestOfferRewardLocaleEntityMixin.fromJson(json);
}
