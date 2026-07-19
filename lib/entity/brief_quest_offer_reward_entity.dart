class BriefQuestOfferRewardEntity {
  final int id;
  final int emote1;
  final String rewardText;

  const BriefQuestOfferRewardEntity({
    this.id = 0,
    this.emote1 = 0,
    this.rewardText = '',
  });

  factory BriefQuestOfferRewardEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestOfferRewardEntity(
      id: json['ID'] ?? 0,
      emote1: json['Emote1'] ?? 0,
      rewardText: json['RewardText']?.toString() ?? '',
    );
  }

  int get key => id;
}
