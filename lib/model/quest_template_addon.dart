// QuestTemplateAddon 模型
// quest_template_addon 表，1:1 关系与 quest_template，共享 ID 主键。

class QuestTemplateAddon {
  int id = 0;
  int maxLevel = 0;
  int allowableClasses = 0;
  int sourceSpellId = 0;
  int prevQuestId = 0;
  int nextQuestId = 0;
  int exclusiveGroup = 0;
  int rewardMailTemplateId = 0;
  int rewardMailDelay = 0;
  int requiredSkillId = 0;
  int requiredSkillPoints = 0;
  int requiredMinRepFaction = 0;
  int requiredMaxRepFaction = 0;
  int requiredMinRepValue = 0;
  int requiredMaxRepValue = 0;
  int providedItemCount = 0;
  int specialFlags = 0;

  QuestTemplateAddon();

  QuestTemplateAddon.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    maxLevel = json['MaxLevel'] ?? 0;
    allowableClasses = json['AllowableClasses'] ?? 0;
    sourceSpellId = json['SourceSpellID'] ?? 0;
    prevQuestId = json['PrevQuestID'] ?? 0;
    nextQuestId = json['NextQuestID'] ?? 0;
    exclusiveGroup = json['ExclusiveGroup'] ?? 0;
    rewardMailTemplateId = json['RewardMailTemplateID'] ?? 0;
    rewardMailDelay = json['RewardMailDelay'] ?? 0;
    requiredSkillId = json['RequiredSkillID'] ?? 0;
    requiredSkillPoints = json['RequiredSkillPoints'] ?? 0;
    requiredMinRepFaction = json['RequiredMinRepFaction'] ?? 0;
    requiredMaxRepFaction = json['RequiredMaxRepFaction'] ?? 0;
    requiredMinRepValue = json['RequiredMinRepValue'] ?? 0;
    requiredMaxRepValue = json['RequiredMaxRepValue'] ?? 0;
    providedItemCount = json['ProvidedItemCount'] ?? 0;
    specialFlags = json['SpecialFlags'] ?? 0;
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