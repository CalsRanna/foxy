// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefQuestTemplateAddonEntity {
  final int id;
  final int maxLevel;
  final int prevQuestId;
  final int nextQuestId;
  final int specialFlags;

  const BriefQuestTemplateAddonEntity({
    this.id = 0,
    this.maxLevel = 0,
    this.prevQuestId = 0,
    this.nextQuestId = 0,
    this.specialFlags = 0,
  });

  factory BriefQuestTemplateAddonEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestTemplateAddonEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      maxLevel: (json['MaxLevel'] as num?)?.toInt() ?? 0,
      prevQuestId: (json['PrevQuestID'] as num?)?.toInt() ?? 0,
      nextQuestId: (json['NextQuestID'] as num?)?.toInt() ?? 0,
      specialFlags: (json['SpecialFlags'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
