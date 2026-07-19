import 'package:foxy/entity/quest_template_addon_key.dart';

class BriefQuestTemplateAddonEntity {
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
      id: json['ID'] ?? 0,
      maxLevel: json['MaxLevel'] ?? 0,
      prevQuestId: json['PrevQuestID'] ?? 0,
      nextQuestId: json['NextQuestID'] ?? 0,
      specialFlags: json['SpecialFlags'] ?? 0,
    );
  }

  QuestTemplateAddonKey get key => QuestTemplateAddonKey(id: id);
}
