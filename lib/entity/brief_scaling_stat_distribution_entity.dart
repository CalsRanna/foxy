class BriefScalingStatDistributionEntity {
  final int id;
  final int statId0;
  final int statId1;
  final int statId2;
  final int statId3;
  final int statId4;
  final int statId5;
  final int statId6;
  final int statId7;
  final int statId8;
  final int statId9;
  final int bonus0;
  final int bonus1;
  final int bonus2;
  final int bonus3;
  final int bonus4;
  final int bonus5;
  final int bonus6;
  final int bonus7;
  final int bonus8;
  final int bonus9;
  final int maxlevel;

  const BriefScalingStatDistributionEntity({
    this.id = 0,
    this.statId0 = -1,
    this.statId1 = -1,
    this.statId2 = -1,
    this.statId3 = -1,
    this.statId4 = -1,
    this.statId5 = -1,
    this.statId6 = -1,
    this.statId7 = -1,
    this.statId8 = -1,
    this.statId9 = -1,
    this.bonus0 = 0,
    this.bonus1 = 0,
    this.bonus2 = 0,
    this.bonus3 = 0,
    this.bonus4 = 0,
    this.bonus5 = 0,
    this.bonus6 = 0,
    this.bonus7 = 0,
    this.bonus8 = 0,
    this.bonus9 = 0,
    this.maxlevel = 80,
  });

  factory BriefScalingStatDistributionEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefScalingStatDistributionEntity(
      id: json['ID'] ?? 0,
      statId0: json['StatID0'] ?? 0,
      statId1: json['StatID1'] ?? 0,
      statId2: json['StatID2'] ?? 0,
      statId3: json['StatID3'] ?? 0,
      statId4: json['StatID4'] ?? 0,
      statId5: json['StatID5'] ?? 0,
      statId6: json['StatID6'] ?? 0,
      statId7: json['StatID7'] ?? 0,
      statId8: json['StatID8'] ?? 0,
      statId9: json['StatID9'] ?? 0,
      bonus0: json['Bonus0'] ?? 0,
      bonus1: json['Bonus1'] ?? 0,
      bonus2: json['Bonus2'] ?? 0,
      bonus3: json['Bonus3'] ?? 0,
      bonus4: json['Bonus4'] ?? 0,
      bonus5: json['Bonus5'] ?? 0,
      bonus6: json['Bonus6'] ?? 0,
      bonus7: json['Bonus7'] ?? 0,
      bonus8: json['Bonus8'] ?? 0,
      bonus9: json['Bonus9'] ?? 0,
      maxlevel: json['Maxlevel'] ?? 0,
    );
  }

  int get key => id;

  String get displayStats {
    final result = StringBuffer();
    void append(int statId, int bonus) {
      if (statId < 0) return;
      if (result.isNotEmpty) result.write(', ');
      result.write('$statId+$bonus');
    }

    append(statId0, bonus0);
    append(statId1, bonus1);
    append(statId2, bonus2);
    append(statId3, bonus3);
    append(statId4, bonus4);
    append(statId5, bonus5);
    append(statId6, bonus6);
    append(statId7, bonus7);
    append(statId8, bonus8);
    append(statId9, bonus9);
    return result.isEmpty ? '-' : result.toString();
  }
}
