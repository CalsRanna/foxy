// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_faction_reward_entity.dart';

mixin _QuestFactionRewardEntityMixin {
  int get id;
  int get difficulty0;
  int get difficulty1;
  int get difficulty2;
  int get difficulty3;
  int get difficulty4;
  int get difficulty5;
  int get difficulty6;
  int get difficulty7;
  int get difficulty8;
  int get difficulty9;

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
    return QuestFactionRewardEntity(
      id: id ?? this.id,
      difficulty0: difficulty0 ?? this.difficulty0,
      difficulty1: difficulty1 ?? this.difficulty1,
      difficulty2: difficulty2 ?? this.difficulty2,
      difficulty3: difficulty3 ?? this.difficulty3,
      difficulty4: difficulty4 ?? this.difficulty4,
      difficulty5: difficulty5 ?? this.difficulty5,
      difficulty6: difficulty6 ?? this.difficulty6,
      difficulty7: difficulty7 ?? this.difficulty7,
      difficulty8: difficulty8 ?? this.difficulty8,
      difficulty9: difficulty9 ?? this.difficulty9,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Difficulty0': difficulty0,
      'Difficulty1': difficulty1,
      'Difficulty2': difficulty2,
      'Difficulty3': difficulty3,
      'Difficulty4': difficulty4,
      'Difficulty5': difficulty5,
      'Difficulty6': difficulty6,
      'Difficulty7': difficulty7,
      'Difficulty8': difficulty8,
      'Difficulty9': difficulty9,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestFactionRewardEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            difficulty0 == other.difficulty0 &&
            difficulty1 == other.difficulty1 &&
            difficulty2 == other.difficulty2 &&
            difficulty3 == other.difficulty3 &&
            difficulty4 == other.difficulty4 &&
            difficulty5 == other.difficulty5 &&
            difficulty6 == other.difficulty6 &&
            difficulty7 == other.difficulty7 &&
            difficulty8 == other.difficulty8 &&
            difficulty9 == other.difficulty9;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      difficulty0,
      difficulty1,
      difficulty2,
      difficulty3,
      difficulty4,
      difficulty5,
      difficulty6,
      difficulty7,
      difficulty8,
      difficulty9,
    ]);
  }

  @override
  String toString() {
    return 'QuestFactionRewardEntity('
        'id: $id, '
        'difficulty0: $difficulty0, '
        'difficulty1: $difficulty1, '
        'difficulty2: $difficulty2, '
        'difficulty3: $difficulty3, '
        'difficulty4: $difficulty4, '
        'difficulty5: $difficulty5, '
        'difficulty6: $difficulty6, '
        'difficulty7: $difficulty7, '
        'difficulty8: $difficulty8, '
        'difficulty9: $difficulty9'
        ')';
  }
}
