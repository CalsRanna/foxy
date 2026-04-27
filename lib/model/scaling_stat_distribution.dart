class ScalingStatDistribution {
  int id = 0;
  int statId0 = 0;
  int statId1 = 0;
  int statId2 = 0;
  int statId3 = 0;
  int statId4 = 0;
  int statId5 = 0;
  int statId6 = 0;
  int statId7 = 0;
  int statId8 = 0;
  int statId9 = 0;
  int bonus0 = 0;
  int bonus1 = 0;
  int bonus2 = 0;
  int bonus3 = 0;
  int bonus4 = 0;
  int bonus5 = 0;
  int bonus6 = 0;
  int bonus7 = 0;
  int bonus8 = 0;
  int bonus9 = 0;
  int maxlevel = 0;

  ScalingStatDistribution();

  ScalingStatDistribution.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    statId0 = json['StatID0'] ?? 0;
    statId1 = json['StatID1'] ?? 0;
    statId2 = json['StatID2'] ?? 0;
    statId3 = json['StatID3'] ?? 0;
    statId4 = json['StatID4'] ?? 0;
    statId5 = json['StatID5'] ?? 0;
    statId6 = json['StatID6'] ?? 0;
    statId7 = json['StatID7'] ?? 0;
    statId8 = json['StatID8'] ?? 0;
    statId9 = json['StatID9'] ?? 0;
    bonus0 = json['Bonus0'] ?? 0;
    bonus1 = json['Bonus1'] ?? 0;
    bonus2 = json['Bonus2'] ?? 0;
    bonus3 = json['Bonus3'] ?? 0;
    bonus4 = json['Bonus4'] ?? 0;
    bonus5 = json['Bonus5'] ?? 0;
    bonus6 = json['Bonus6'] ?? 0;
    bonus7 = json['Bonus7'] ?? 0;
    bonus8 = json['Bonus8'] ?? 0;
    bonus9 = json['Bonus9'] ?? 0;
    maxlevel = json['Maxlevel'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'StatID0': statId0,
      'StatID1': statId1,
      'StatID2': statId2,
      'StatID3': statId3,
      'StatID4': statId4,
      'StatID5': statId5,
      'StatID6': statId6,
      'StatID7': statId7,
      'StatID8': statId8,
      'StatID9': statId9,
      'Bonus0': bonus0,
      'Bonus1': bonus1,
      'Bonus2': bonus2,
      'Bonus3': bonus3,
      'Bonus4': bonus4,
      'Bonus5': bonus5,
      'Bonus6': bonus6,
      'Bonus7': bonus7,
      'Bonus8': bonus8,
      'Bonus9': bonus9,
      'Maxlevel': maxlevel,
    };
  }
}
