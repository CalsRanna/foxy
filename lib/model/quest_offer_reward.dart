// QuestOfferReward 模型
// quest_offer_reward 表，1:1 关系与 quest_template，共享 ID 主键。

class QuestOfferReward {
  int id = 0;
  int emote1 = 0;
  int emote2 = 0;
  int emote3 = 0;
  int emote4 = 0;
  int emoteDelay1 = 0;
  int emoteDelay2 = 0;
  int emoteDelay3 = 0;
  int emoteDelay4 = 0;
  String rewardText = '';
  int? verifiedBuild;

  QuestOfferReward();

  QuestOfferReward.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    emote1 = json['Emote1'] ?? 0;
    emote2 = json['Emote2'] ?? 0;
    emote3 = json['Emote3'] ?? 0;
    emote4 = json['Emote4'] ?? 0;
    emoteDelay1 = json['EmoteDelay1'] ?? 0;
    emoteDelay2 = json['EmoteDelay2'] ?? 0;
    emoteDelay3 = json['EmoteDelay3'] ?? 0;
    emoteDelay4 = json['EmoteDelay4'] ?? 0;
    rewardText = json['RewardText']?.toString() ?? '';
    verifiedBuild = json['VerifiedBuild'];
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'ID': id,
      'Emote1': emote1,
      'Emote2': emote2,
      'Emote3': emote3,
      'Emote4': emote4,
      'EmoteDelay1': emoteDelay1,
      'EmoteDelay2': emoteDelay2,
      'EmoteDelay3': emoteDelay3,
      'EmoteDelay4': emoteDelay4,
      'RewardText': rewardText,
    };
    if (verifiedBuild != null) {
      result['VerifiedBuild'] = verifiedBuild!;
    }
    return result;
  }
}

/// quest_offer_reward_locale 本地化模型（复合键: ID + Locale）
class QuestOfferRewardLocale {
  int id = 0;
  String locale = 'zhCN';
  String rewardText = '';
  int? verifiedBuild;

  QuestOfferRewardLocale();

  QuestOfferRewardLocale.fromJson(Map<String, dynamic> json) {
    id = (json['ID'] ?? json['id'] ?? 0) as int;
    locale = json['Locale']?.toString() ?? 'zhCN';
    rewardText = json['RewardText']?.toString() ?? '';
    verifiedBuild = json['VerifiedBuild'];
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'ID': id,
      'Locale': locale,
      'RewardText': rewardText,
    };
    if (verifiedBuild != null) {
      result['VerifiedBuild'] = verifiedBuild!;
    }
    return result;
  }
}