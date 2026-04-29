class CreatureOnKillReputationEntity {
  final int creatureID;
  final int rewOnKillRepFaction1;
  final int rewOnKillRepFaction2;
  final int maxStanding1;
  final int maxStanding2;
  final bool isTeamAward1;
  final bool isTeamAward2;
  final double rewOnKillRepValue1;
  final double rewOnKillRepValue2;
  final int teamDependent;

  const CreatureOnKillReputationEntity({
    this.creatureID = 0,
    this.rewOnKillRepFaction1 = 0,
    this.rewOnKillRepFaction2 = 0,
    this.maxStanding1 = 0,
    this.maxStanding2 = 0,
    this.isTeamAward1 = false,
    this.isTeamAward2 = false,
    this.rewOnKillRepValue1 = 0.0,
    this.rewOnKillRepValue2 = 0.0,
    this.teamDependent = 0,
  });

  factory CreatureOnKillReputationEntity.fromJson(Map<String, dynamic> json) {
    return CreatureOnKillReputationEntity(
      creatureID: json['creature_id'] ?? json['creatureID'] ?? 0,
      rewOnKillRepFaction1:
          json['RewOnKillRepFaction1'] ?? json['rewOnKillRepFaction1'] ?? 0,
      rewOnKillRepFaction2:
          json['RewOnKillRepFaction2'] ?? json['rewOnKillRepFaction2'] ?? 0,
      maxStanding1: json['MaxStanding1'] ?? json['maxStanding1'] ?? 0,
      maxStanding2: json['MaxStanding2'] ?? json['maxStanding2'] ?? 0,
      isTeamAward1: (json['IsTeamAward1'] ?? json['isTeamAward1'] ?? 0) == 1,
      isTeamAward2: (json['IsTeamAward2'] ?? json['isTeamAward2'] ?? 0) == 1,
      rewOnKillRepValue1:
          (json['RewOnKillRepValue1'] ?? json['rewOnKillRepValue1'] ?? 0.0)
              .toDouble(),
      rewOnKillRepValue2:
          (json['RewOnKillRepValue2'] ?? json['rewOnKillRepValue2'] ?? 0.0)
              .toDouble(),
      teamDependent: json['TeamDependent'] ?? json['teamDependent'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'creature_id': creatureID,
      'RewOnKillRepFaction1': rewOnKillRepFaction1,
      'RewOnKillRepFaction2': rewOnKillRepFaction2,
      'MaxStanding1': maxStanding1,
      'MaxStanding2': maxStanding2,
      'IsTeamAward1': isTeamAward1 ? 1 : 0,
      'IsTeamAward2': isTeamAward2 ? 1 : 0,
      'RewOnKillRepValue1': rewOnKillRepValue1,
      'RewOnKillRepValue2': rewOnKillRepValue2,
      'TeamDependent': teamDependent,
    };
  }
}
