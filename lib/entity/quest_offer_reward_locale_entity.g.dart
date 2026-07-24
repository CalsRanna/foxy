// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_offer_reward_locale_entity.dart';

mixin _QuestOfferRewardLocaleEntityMixin {
  static QuestOfferRewardLocaleEntity fromJson(Map<String, dynamic> json) {
    return QuestOfferRewardLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? 'zhCN',
      rewardText: json['RewardText']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  QuestOfferRewardLocaleEntity copyWith({
    int? id,
    String? locale,
    String? rewardText,
    int? verifiedBuild,
  }) {
    final self = this as QuestOfferRewardLocaleEntity;
    return QuestOfferRewardLocaleEntity(
      id: id ?? self.id,
      locale: locale ?? self.locale,
      rewardText: rewardText ?? self.rewardText,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as QuestOfferRewardLocaleEntity;
    return {
      'ID': self.id,
      'locale': self.locale,
      'RewardText': self.rewardText,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as QuestOfferRewardLocaleEntity;
    return identical(self, other) ||
        other is QuestOfferRewardLocaleEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.locale == other.locale &&
            self.rewardText == other.rewardText &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as QuestOfferRewardLocaleEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.locale,
      self.rewardText,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as QuestOfferRewardLocaleEntity;
    return 'QuestOfferRewardLocaleEntity('
        'id: ${self.id}, '
        'locale: ${self.locale}, '
        'rewardText: ${self.rewardText}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class QuestOfferRewardLocaleKey {
  final int id;
  final String locale;

  const QuestOfferRewardLocaleKey({required this.id, required this.locale});

  factory QuestOfferRewardLocaleKey.fromEntity(
    QuestOfferRewardLocaleEntity entity,
  ) {
    return QuestOfferRewardLocaleKey(id: entity.id, locale: entity.locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestOfferRewardLocaleKey &&
            id == other.id &&
            locale == other.locale;
  }

  @override
  int get hashCode => Object.hashAll([id, locale]);

  @override
  String toString() {
    return 'QuestOfferRewardLocaleKey('
        'id: $id, '
        'locale: $locale'
        ')';
  }
}

final class BriefQuestOfferRewardLocaleEntity {
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

  QuestOfferRewardLocaleKey get key {
    return QuestOfferRewardLocaleKey(id: id, locale: locale);
  }
}
