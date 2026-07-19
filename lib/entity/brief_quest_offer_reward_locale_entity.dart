import 'package:foxy/entity/quest_offer_reward_locale_key.dart';

/// 任务完成奖励本地化列表展示模型。
class BriefQuestOfferRewardLocaleEntity {
  final int id;
  final String locale;
  final String rewardText;

  const BriefQuestOfferRewardLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.rewardText = '',
  });

  factory BriefQuestOfferRewardLocaleEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefQuestOfferRewardLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? 'zhCN',
      rewardText: json['RewardText']?.toString() ?? '',
    );
  }

  QuestOfferRewardLocaleKey get key =>
      QuestOfferRewardLocaleKey(id: id, locale: locale);
}
