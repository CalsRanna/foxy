class QuestFactionRewardEntity {
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

  const QuestFactionRewardEntity({
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

  factory QuestFactionRewardEntity.fromJson(Map<String, dynamic> json) {
    return QuestFactionRewardEntity(
      id: json['ID'] ?? 0,
      difficulty0: json['Difficulty0'] ?? 0,
      difficulty1: json['Difficulty1'] ?? 0,
      difficulty2: json['Difficulty2'] ?? 0,
      difficulty3: json['Difficulty3'] ?? 0,
      difficulty4: json['Difficulty4'] ?? 0,
      difficulty5: json['Difficulty5'] ?? 0,
      difficulty6: json['Difficulty6'] ?? 0,
      difficulty7: json['Difficulty7'] ?? 0,
      difficulty8: json['Difficulty8'] ?? 0,
      difficulty9: json['Difficulty9'] ?? 0,
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
}
