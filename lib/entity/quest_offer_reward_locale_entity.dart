class QuestOfferRewardLocaleEntity {
  final int id;
  final String locale;
  final String rewardText;
  final int verifiedBuild;

  const QuestOfferRewardLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.rewardText = '',
    this.verifiedBuild = 0,
  });

  factory QuestOfferRewardLocaleEntity.fromJson(Map<String, dynamic> json) {
    return QuestOfferRewardLocaleEntity(
      id: (json['ID'] ?? json['id'] ?? 0) as int,
      locale: json['locale']?.toString() ?? 'zhCN',
      rewardText: json['RewardText']?.toString() ?? '',
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  QuestOfferRewardLocaleEntity copyWith({
    int? id,
    String? locale,
    String? rewardText,
    int? verifiedBuild,
  }) {
    return QuestOfferRewardLocaleEntity(
      id: id ?? this.id,
      locale: locale ?? this.locale,
      rewardText: rewardText ?? this.rewardText,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'ID': id,
      'locale': locale,
      'RewardText': rewardText,
      'VerifiedBuild': verifiedBuild,
    };
    return result;
  }
}
