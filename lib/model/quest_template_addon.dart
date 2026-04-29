// QuestTemplateAddon 模型
// quest_template_addon 表，1:1 关系与 quest_template，共享 ID 主键。

class QuestTemplateAddon {
  final int id;
  final int maxLevel;
  final int allowableClasses;
  final int sourceSpellId;
  final int prevQuestId;
  final int nextQuestId;
  final int exclusiveGroup;
  final int rewardMailTemplateId;
  final int rewardMailDelay;
  final int requiredSkillId;
  final int requiredSkillPoints;
  final int requiredMinRepFaction;
  final int requiredMaxRepFaction;
  final int requiredMinRepValue;
  final int requiredMaxRepValue;
  final int providedItemCount;
  final int specialFlags;

  const QuestTemplateAddon({
    this.id = 0,
    this.maxLevel = 0,
    this.allowableClasses = 0,
    this.sourceSpellId = 0,
    this.prevQuestId = 0,
    this.nextQuestId = 0,
    this.exclusiveGroup = 0,
    this.rewardMailTemplateId = 0,
    this.rewardMailDelay = 0,
    this.requiredSkillId = 0,
    this.requiredSkillPoints = 0,
    this.requiredMinRepFaction = 0,
    this.requiredMaxRepFaction = 0,
    this.requiredMinRepValue = 0,
    this.requiredMaxRepValue = 0,
    this.providedItemCount = 0,
    this.specialFlags = 0,
  });

  factory QuestTemplateAddon.fromJson(Map<String, dynamic> json) {
    return QuestTemplateAddon(
      id: json['ID'] ?? 0,
      maxLevel: json['MaxLevel'] ?? 0,
      allowableClasses: json['AllowableClasses'] ?? 0,
      sourceSpellId: json['SourceSpellID'] ?? 0,
      prevQuestId: json['PrevQuestID'] ?? 0,
      nextQuestId: json['NextQuestID'] ?? 0,
      exclusiveGroup: json['ExclusiveGroup'] ?? 0,
      rewardMailTemplateId: json['RewardMailTemplateID'] ?? 0,
      rewardMailDelay: json['RewardMailDelay'] ?? 0,
      requiredSkillId: json['RequiredSkillID'] ?? 0,
      requiredSkillPoints: json['RequiredSkillPoints'] ?? 0,
      requiredMinRepFaction: json['RequiredMinRepFaction'] ?? 0,
      requiredMaxRepFaction: json['RequiredMaxRepFaction'] ?? 0,
      requiredMinRepValue: json['RequiredMinRepValue'] ?? 0,
      requiredMaxRepValue: json['RequiredMaxRepValue'] ?? 0,
      providedItemCount: json['ProvidedItemCount'] ?? 0,
      specialFlags: json['SpecialFlags'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'MaxLevel': maxLevel,
      'AllowableClasses': allowableClasses,
      'SourceSpellID': sourceSpellId,
      'PrevQuestID': prevQuestId,
      'NextQuestID': nextQuestId,
      'ExclusiveGroup': exclusiveGroup,
      'RewardMailTemplateID': rewardMailTemplateId,
      'RewardMailDelay': rewardMailDelay,
      'RequiredSkillID': requiredSkillId,
      'RequiredSkillPoints': requiredSkillPoints,
      'RequiredMinRepFaction': requiredMinRepFaction,
      'RequiredMaxRepFaction': requiredMaxRepFaction,
      'RequiredMinRepValue': requiredMinRepValue,
      'RequiredMaxRepValue': requiredMaxRepValue,
      'ProvidedItemCount': providedItemCount,
      'SpecialFlags': specialFlags,
    };
  }
}
