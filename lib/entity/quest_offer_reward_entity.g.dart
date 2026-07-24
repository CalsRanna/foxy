// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_offer_reward_entity.dart';

mixin _QuestOfferRewardEntityMixin {
  int get id;
  int get emote1;
  int get emote2;
  int get emote3;
  int get emote4;
  int get emoteDelay1;
  int get emoteDelay2;
  int get emoteDelay3;
  int get emoteDelay4;
  String get rewardText;
  int get verifiedBuild;

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
    return QuestOfferRewardEntity(
      id: id ?? this.id,
      emote1: emote1 ?? this.emote1,
      emote2: emote2 ?? this.emote2,
      emote3: emote3 ?? this.emote3,
      emote4: emote4 ?? this.emote4,
      emoteDelay1: emoteDelay1 ?? this.emoteDelay1,
      emoteDelay2: emoteDelay2 ?? this.emoteDelay2,
      emoteDelay3: emoteDelay3 ?? this.emoteDelay3,
      emoteDelay4: emoteDelay4 ?? this.emoteDelay4,
      rewardText: rewardText ?? this.rewardText,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'VerifiedBuild': verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestOfferRewardEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            emote1 == other.emote1 &&
            emote2 == other.emote2 &&
            emote3 == other.emote3 &&
            emote4 == other.emote4 &&
            emoteDelay1 == other.emoteDelay1 &&
            emoteDelay2 == other.emoteDelay2 &&
            emoteDelay3 == other.emoteDelay3 &&
            emoteDelay4 == other.emoteDelay4 &&
            rewardText == other.rewardText &&
            verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      emote1,
      emote2,
      emote3,
      emote4,
      emoteDelay1,
      emoteDelay2,
      emoteDelay3,
      emoteDelay4,
      rewardText,
      verifiedBuild,
    ]);
  }

  @override
  String toString() {
    return 'QuestOfferRewardEntity('
        'id: $id, '
        'emote1: $emote1, '
        'emote2: $emote2, '
        'emote3: $emote3, '
        'emote4: $emote4, '
        'emoteDelay1: $emoteDelay1, '
        'emoteDelay2: $emoteDelay2, '
        'emoteDelay3: $emoteDelay3, '
        'emoteDelay4: $emoteDelay4, '
        'rewardText: $rewardText, '
        'verifiedBuild: $verifiedBuild'
        ')';
  }
}
