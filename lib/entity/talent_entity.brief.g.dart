// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefTalentEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      tabId: (json['TabID'] as num?)?.toInt() ?? 0,
      tierId: (json['TierID'] as num?)?.toInt() ?? 0,
      columnIndex: (json['ColumnIndex'] as num?)?.toInt() ?? 0,
      spellRank0: (json['SpellRank0'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
