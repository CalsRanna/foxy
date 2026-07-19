class BriefTalentEntity {
  final int id;
  final int tabId;
  final int tierId;
  final int columnIndex;
  final int spellRank0;

  const BriefTalentEntity({
    this.id = 0,
    this.tabId = 0,
    this.tierId = 0,
    this.columnIndex = 0,
    this.spellRank0 = 0,
  });

  factory BriefTalentEntity.fromJson(Map<String, dynamic> json) {
    return BriefTalentEntity(
      id: json['ID'] ?? 0,
      tabId: json['TabID'] ?? 0,
      tierId: json['TierID'] ?? 0,
      columnIndex: json['ColumnIndex'] ?? 0,
      spellRank0: json['SpellRank0'] ?? 0,
    );
  }

  int get key => id;
}
