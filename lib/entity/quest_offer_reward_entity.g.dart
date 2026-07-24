// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_offer_reward_entity.dart';

mixin _QuestOfferRewardEntityMixin {
  static QuestOfferRewardEntity fromJson(Map<String, dynamic> json) {
    return QuestOfferRewardEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      emote1: (json['Emote1'] as num?)?.toInt() ?? 0,
      emote2: (json['Emote2'] as num?)?.toInt() ?? 0,
      emote3: (json['Emote3'] as num?)?.toInt() ?? 0,
      emote4: (json['Emote4'] as num?)?.toInt() ?? 0,
      emoteDelay1: (json['EmoteDelay1'] as num?)?.toInt() ?? 0,
      emoteDelay2: (json['EmoteDelay2'] as num?)?.toInt() ?? 0,
      emoteDelay3: (json['EmoteDelay3'] as num?)?.toInt() ?? 0,
      emoteDelay4: (json['EmoteDelay4'] as num?)?.toInt() ?? 0,
      rewardText: json['RewardText']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  QuestOfferRewardEntity copyWith({
    int? id,
    int? emote1,
    int? emote2,
    int? emote3,
    int? emote4,
    int? emoteDelay1,
    int? emoteDelay2,
    int? emoteDelay3,
    int? emoteDelay4,
    String? rewardText,
    int? verifiedBuild,
  }) {
    final self = this as QuestOfferRewardEntity;
    return QuestOfferRewardEntity(
      id: id ?? self.id,
      emote1: emote1 ?? self.emote1,
      emote2: emote2 ?? self.emote2,
      emote3: emote3 ?? self.emote3,
      emote4: emote4 ?? self.emote4,
      emoteDelay1: emoteDelay1 ?? self.emoteDelay1,
      emoteDelay2: emoteDelay2 ?? self.emoteDelay2,
      emoteDelay3: emoteDelay3 ?? self.emoteDelay3,
      emoteDelay4: emoteDelay4 ?? self.emoteDelay4,
      rewardText: rewardText ?? self.rewardText,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as QuestOfferRewardEntity;
    return {
      'ID': self.id,
      'Emote1': self.emote1,
      'Emote2': self.emote2,
      'Emote3': self.emote3,
      'Emote4': self.emote4,
      'EmoteDelay1': self.emoteDelay1,
      'EmoteDelay2': self.emoteDelay2,
      'EmoteDelay3': self.emoteDelay3,
      'EmoteDelay4': self.emoteDelay4,
      'RewardText': self.rewardText,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as QuestOfferRewardEntity;
    return identical(self, other) ||
        other is QuestOfferRewardEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.emote1 == other.emote1 &&
            self.emote2 == other.emote2 &&
            self.emote3 == other.emote3 &&
            self.emote4 == other.emote4 &&
            self.emoteDelay1 == other.emoteDelay1 &&
            self.emoteDelay2 == other.emoteDelay2 &&
            self.emoteDelay3 == other.emoteDelay3 &&
            self.emoteDelay4 == other.emoteDelay4 &&
            self.rewardText == other.rewardText &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as QuestOfferRewardEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.emote1,
      self.emote2,
      self.emote3,
      self.emote4,
      self.emoteDelay1,
      self.emoteDelay2,
      self.emoteDelay3,
      self.emoteDelay4,
      self.rewardText,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as QuestOfferRewardEntity;
    return 'QuestOfferRewardEntity('
        'id: ${self.id}, '
        'emote1: ${self.emote1}, '
        'emote2: ${self.emote2}, '
        'emote3: ${self.emote3}, '
        'emote4: ${self.emote4}, '
        'emoteDelay1: ${self.emoteDelay1}, '
        'emoteDelay2: ${self.emoteDelay2}, '
        'emoteDelay3: ${self.emoteDelay3}, '
        'emoteDelay4: ${self.emoteDelay4}, '
        'rewardText: ${self.rewardText}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class BriefQuestOfferRewardEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      emote1: (json['Emote1'] as num?)?.toInt() ?? 0,
      rewardText: json['RewardText']?.toString() ?? '',
    );
  }

  int get key => id;
}
