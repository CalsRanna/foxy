/// 生物击杀声望
class CreatureOnkillReputation {
  int creatureID = 0;
  int rewOnKillRepFaction1 = 0;
  int rewOnKillRepFaction2 = 0;
  int maxStanding1 = 0;
  int maxStanding2 = 0;
  bool isTeamAward1 = false;
  bool isTeamAward2 = false;
  int rewOnKillRepValue1 = 0;
  int rewOnKillRepValue2 = 0;
  int teamDependent = 0;

  CreatureOnkillReputation();

  CreatureOnkillReputation.fromJson(Map<String, dynamic> json) {
    creatureID = json['creature_id'] ?? json['creatureID'] ?? 0;
    rewOnKillRepFaction1 = json['RewOnKillRepFaction1'] ?? json['rewOnKillRepFaction1'] ?? 0;
    rewOnKillRepFaction2 = json['RewOnKillRepFaction2'] ?? json['rewOnKillRepFaction2'] ?? 0;
    maxStanding1 = json['MaxStanding1'] ?? json['maxStanding1'] ?? 0;
    maxStanding2 = json['MaxStanding2'] ?? json['maxStanding2'] ?? 0;
    isTeamAward1 = (json['IsTeamAward1'] ?? json['isTeamAward1'] ?? 0) == 1;
    isTeamAward2 = (json['IsTeamAward2'] ?? json['isTeamAward2'] ?? 0) == 1;
    rewOnKillRepValue1 = json['RewOnKillRepValue1'] ?? json['rewOnKillRepValue1'] ?? 0;
    rewOnKillRepValue2 = json['RewOnKillRepValue2'] ?? json['rewOnKillRepValue2'] ?? 0;
    teamDependent = json['TeamDependent'] ?? json['teamDependent'] ?? 0;
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
