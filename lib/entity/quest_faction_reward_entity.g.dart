// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_faction_reward_entity.dart';

mixin _QuestFactionRewardEntityMixin {
  static QuestFactionRewardEntity fromJson(Map<String, dynamic> json) {
    return QuestFactionRewardEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      difficulty0: (json['Difficulty0'] as num?)?.toInt() ?? 0,
      difficulty1: (json['Difficulty1'] as num?)?.toInt() ?? 0,
      difficulty2: (json['Difficulty2'] as num?)?.toInt() ?? 0,
      difficulty3: (json['Difficulty3'] as num?)?.toInt() ?? 0,
      difficulty4: (json['Difficulty4'] as num?)?.toInt() ?? 0,
      difficulty5: (json['Difficulty5'] as num?)?.toInt() ?? 0,
      difficulty6: (json['Difficulty6'] as num?)?.toInt() ?? 0,
      difficulty7: (json['Difficulty7'] as num?)?.toInt() ?? 0,
      difficulty8: (json['Difficulty8'] as num?)?.toInt() ?? 0,
      difficulty9: (json['Difficulty9'] as num?)?.toInt() ?? 0,
    );
  }

  QuestFactionRewardEntity copyWith({
    int? id,
    int? difficulty0,
    int? difficulty1,
    int? difficulty2,
    int? difficulty3,
    int? difficulty4,
    int? difficulty5,
    int? difficulty6,
    int? difficulty7,
    int? difficulty8,
    int? difficulty9,
  }) {
    final self = this as QuestFactionRewardEntity;
    return QuestFactionRewardEntity(
      id: id ?? self.id,
      difficulty0: difficulty0 ?? self.difficulty0,
      difficulty1: difficulty1 ?? self.difficulty1,
      difficulty2: difficulty2 ?? self.difficulty2,
      difficulty3: difficulty3 ?? self.difficulty3,
      difficulty4: difficulty4 ?? self.difficulty4,
      difficulty5: difficulty5 ?? self.difficulty5,
      difficulty6: difficulty6 ?? self.difficulty6,
      difficulty7: difficulty7 ?? self.difficulty7,
      difficulty8: difficulty8 ?? self.difficulty8,
      difficulty9: difficulty9 ?? self.difficulty9,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as QuestFactionRewardEntity;
    return {
      'ID': self.id,
      'Difficulty0': self.difficulty0,
      'Difficulty1': self.difficulty1,
      'Difficulty2': self.difficulty2,
      'Difficulty3': self.difficulty3,
      'Difficulty4': self.difficulty4,
      'Difficulty5': self.difficulty5,
      'Difficulty6': self.difficulty6,
      'Difficulty7': self.difficulty7,
      'Difficulty8': self.difficulty8,
      'Difficulty9': self.difficulty9,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as QuestFactionRewardEntity;
    return identical(self, other) ||
        other is QuestFactionRewardEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.difficulty0 == other.difficulty0 &&
            self.difficulty1 == other.difficulty1 &&
            self.difficulty2 == other.difficulty2 &&
            self.difficulty3 == other.difficulty3 &&
            self.difficulty4 == other.difficulty4 &&
            self.difficulty5 == other.difficulty5 &&
            self.difficulty6 == other.difficulty6 &&
            self.difficulty7 == other.difficulty7 &&
            self.difficulty8 == other.difficulty8 &&
            self.difficulty9 == other.difficulty9;
  }

  @override
  int get hashCode {
    final self = this as QuestFactionRewardEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.difficulty0,
      self.difficulty1,
      self.difficulty2,
      self.difficulty3,
      self.difficulty4,
      self.difficulty5,
      self.difficulty6,
      self.difficulty7,
      self.difficulty8,
      self.difficulty9,
    ]);
  }

  @override
  String toString() {
    final self = this as QuestFactionRewardEntity;
    return 'QuestFactionRewardEntity('
        'id: ${self.id}, '
        'difficulty0: ${self.difficulty0}, '
        'difficulty1: ${self.difficulty1}, '
        'difficulty2: ${self.difficulty2}, '
        'difficulty3: ${self.difficulty3}, '
        'difficulty4: ${self.difficulty4}, '
        'difficulty5: ${self.difficulty5}, '
        'difficulty6: ${self.difficulty6}, '
        'difficulty7: ${self.difficulty7}, '
        'difficulty8: ${self.difficulty8}, '
        'difficulty9: ${self.difficulty9}'
        ')';
  }
}

final class BriefQuestFactionRewardEntity {
  final int id;
  final int difficulty0;
  final int difficulty1;
  final int difficulty2;
  final int difficulty3;
  final int difficulty4;
  final int difficulty5;
  final int difficulty6;
  final int difficulty7;
  final int difficulty8;
  final int difficulty9;

  const BriefQuestFactionRewardEntity({
    this.id = 0,
    this.difficulty0 = 0,
    this.difficulty1 = 0,
    this.difficulty2 = 0,
    this.difficulty3 = 0,
    this.difficulty4 = 0,
    this.difficulty5 = 0,
    this.difficulty6 = 0,
    this.difficulty7 = 0,
    this.difficulty8 = 0,
    this.difficulty9 = 0,
  });

  factory BriefQuestFactionRewardEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestFactionRewardEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      difficulty0: (json['Difficulty0'] as num?)?.toInt() ?? 0,
      difficulty1: (json['Difficulty1'] as num?)?.toInt() ?? 0,
      difficulty2: (json['Difficulty2'] as num?)?.toInt() ?? 0,
      difficulty3: (json['Difficulty3'] as num?)?.toInt() ?? 0,
      difficulty4: (json['Difficulty4'] as num?)?.toInt() ?? 0,
      difficulty5: (json['Difficulty5'] as num?)?.toInt() ?? 0,
      difficulty6: (json['Difficulty6'] as num?)?.toInt() ?? 0,
      difficulty7: (json['Difficulty7'] as num?)?.toInt() ?? 0,
      difficulty8: (json['Difficulty8'] as num?)?.toInt() ?? 0,
      difficulty9: (json['Difficulty9'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
