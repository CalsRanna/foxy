/// 击杀声望列表与 Picker 展示模型。
class BriefCreatureOnKillReputationEntity {
  final int creatureID;
  final int rewOnKillRepFaction1;
  final int rewOnKillRepFaction2;
  final double rewOnKillRepValue1;
  final double rewOnKillRepValue2;
  final int teamDependent;

  const BriefCreatureOnKillReputationEntity({
    this.creatureID = 0,
    this.rewOnKillRepFaction1 = 0,
    this.rewOnKillRepFaction2 = 0,
    this.rewOnKillRepValue1 = 0.0,
    this.rewOnKillRepValue2 = 0.0,
    this.teamDependent = 0,
  });

  factory BriefCreatureOnKillReputationEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefCreatureOnKillReputationEntity(
      creatureID: json['creature_id'] ?? json['creatureID'] ?? 0,
      rewOnKillRepFaction1:
          json['RewOnKillRepFaction1'] ?? json['rewOnKillRepFaction1'] ?? 0,
      rewOnKillRepFaction2:
          json['RewOnKillRepFaction2'] ?? json['rewOnKillRepFaction2'] ?? 0,
      rewOnKillRepValue1:
          (json['RewOnKillRepValue1'] as num?)?.toDouble() ?? 0.0,
      rewOnKillRepValue2:
          (json['RewOnKillRepValue2'] as num?)?.toDouble() ?? 0.0,
      teamDependent: json['TeamDependent'] ?? json['teamDependent'] ?? 0,
    );
  }

  int get key => creatureID;
}
