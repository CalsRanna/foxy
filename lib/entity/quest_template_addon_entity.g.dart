// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_addon_entity.dart';

mixin _QuestTemplateAddonEntityMixin {
  int get id;
  int get maxLevel;
  int get allowableClasses;
  int get sourceSpellId;
  int get prevQuestId;
  int get nextQuestId;
  int get exclusiveGroup;
  int get breadcrumbForQuestId;
  int get rewardMailTemplateId;
  int get rewardMailDelay;
  int get requiredSkillId;
  int get requiredSkillPoints;
  int get requiredMinRepFaction;
  int get requiredMaxRepFaction;
  int get requiredMinRepValue;
  int get requiredMaxRepValue;
  int get providedItemCount;
  int get specialFlags;

  static QuestTemplateAddonEntity fromJson(Map<String, dynamic> json) {
    return QuestTemplateAddonEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      maxLevel: (json['MaxLevel'] as num?)?.toInt() ?? 0,
      allowableClasses: (json['AllowableClasses'] as num?)?.toInt() ?? 0,
      sourceSpellId: (json['SourceSpellID'] as num?)?.toInt() ?? 0,
      prevQuestId: (json['PrevQuestID'] as num?)?.toInt() ?? 0,
      nextQuestId: (json['NextQuestID'] as num?)?.toInt() ?? 0,
      exclusiveGroup: (json['ExclusiveGroup'] as num?)?.toInt() ?? 0,
      breadcrumbForQuestId:
          (json['BreadcrumbForQuestId'] as num?)?.toInt() ?? 0,
      rewardMailTemplateId:
          (json['RewardMailTemplateID'] as num?)?.toInt() ?? 0,
      rewardMailDelay: (json['RewardMailDelay'] as num?)?.toInt() ?? 0,
      requiredSkillId: (json['RequiredSkillID'] as num?)?.toInt() ?? 0,
      requiredSkillPoints: (json['RequiredSkillPoints'] as num?)?.toInt() ?? 0,
      requiredMinRepFaction:
          (json['RequiredMinRepFaction'] as num?)?.toInt() ?? 0,
      requiredMaxRepFaction:
          (json['RequiredMaxRepFaction'] as num?)?.toInt() ?? 0,
      requiredMinRepValue: (json['RequiredMinRepValue'] as num?)?.toInt() ?? 0,
      requiredMaxRepValue: (json['RequiredMaxRepValue'] as num?)?.toInt() ?? 0,
      providedItemCount: (json['ProvidedItemCount'] as num?)?.toInt() ?? 0,
      specialFlags: (json['SpecialFlags'] as num?)?.toInt() ?? 0,
    );
  }

  QuestTemplateAddonEntity copyWith({
    int? id,
    int? maxLevel,
    int? allowableClasses,
    int? sourceSpellId,
    int? prevQuestId,
    int? nextQuestId,
    int? exclusiveGroup,
    int? breadcrumbForQuestId,
    int? rewardMailTemplateId,
    int? rewardMailDelay,
    int? requiredSkillId,
    int? requiredSkillPoints,
    int? requiredMinRepFaction,
    int? requiredMaxRepFaction,
    int? requiredMinRepValue,
    int? requiredMaxRepValue,
    int? providedItemCount,
    int? specialFlags,
  }) {
    return QuestTemplateAddonEntity(
      id: id ?? this.id,
      maxLevel: maxLevel ?? this.maxLevel,
      allowableClasses: allowableClasses ?? this.allowableClasses,
      sourceSpellId: sourceSpellId ?? this.sourceSpellId,
      prevQuestId: prevQuestId ?? this.prevQuestId,
      nextQuestId: nextQuestId ?? this.nextQuestId,
      exclusiveGroup: exclusiveGroup ?? this.exclusiveGroup,
      breadcrumbForQuestId: breadcrumbForQuestId ?? this.breadcrumbForQuestId,
      rewardMailTemplateId: rewardMailTemplateId ?? this.rewardMailTemplateId,
      rewardMailDelay: rewardMailDelay ?? this.rewardMailDelay,
      requiredSkillId: requiredSkillId ?? this.requiredSkillId,
      requiredSkillPoints: requiredSkillPoints ?? this.requiredSkillPoints,
      requiredMinRepFaction:
          requiredMinRepFaction ?? this.requiredMinRepFaction,
      requiredMaxRepFaction:
          requiredMaxRepFaction ?? this.requiredMaxRepFaction,
      requiredMinRepValue: requiredMinRepValue ?? this.requiredMinRepValue,
      requiredMaxRepValue: requiredMaxRepValue ?? this.requiredMaxRepValue,
      providedItemCount: providedItemCount ?? this.providedItemCount,
      specialFlags: specialFlags ?? this.specialFlags,
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
      'BreadcrumbForQuestId': breadcrumbForQuestId,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestTemplateAddonEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            maxLevel == other.maxLevel &&
            allowableClasses == other.allowableClasses &&
            sourceSpellId == other.sourceSpellId &&
            prevQuestId == other.prevQuestId &&
            nextQuestId == other.nextQuestId &&
            exclusiveGroup == other.exclusiveGroup &&
            breadcrumbForQuestId == other.breadcrumbForQuestId &&
            rewardMailTemplateId == other.rewardMailTemplateId &&
            rewardMailDelay == other.rewardMailDelay &&
            requiredSkillId == other.requiredSkillId &&
            requiredSkillPoints == other.requiredSkillPoints &&
            requiredMinRepFaction == other.requiredMinRepFaction &&
            requiredMaxRepFaction == other.requiredMaxRepFaction &&
            requiredMinRepValue == other.requiredMinRepValue &&
            requiredMaxRepValue == other.requiredMaxRepValue &&
            providedItemCount == other.providedItemCount &&
            specialFlags == other.specialFlags;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      maxLevel,
      allowableClasses,
      sourceSpellId,
      prevQuestId,
      nextQuestId,
      exclusiveGroup,
      breadcrumbForQuestId,
      rewardMailTemplateId,
      rewardMailDelay,
      requiredSkillId,
      requiredSkillPoints,
      requiredMinRepFaction,
      requiredMaxRepFaction,
      requiredMinRepValue,
      requiredMaxRepValue,
      providedItemCount,
      specialFlags,
    ]);
  }

  @override
  String toString() {
    return 'QuestTemplateAddonEntity('
        'id: $id, '
        'maxLevel: $maxLevel, '
        'allowableClasses: $allowableClasses, '
        'sourceSpellId: $sourceSpellId, '
        'prevQuestId: $prevQuestId, '
        'nextQuestId: $nextQuestId, '
        'exclusiveGroup: $exclusiveGroup, '
        'breadcrumbForQuestId: $breadcrumbForQuestId, '
        'rewardMailTemplateId: $rewardMailTemplateId, '
        'rewardMailDelay: $rewardMailDelay, '
        'requiredSkillId: $requiredSkillId, '
        'requiredSkillPoints: $requiredSkillPoints, '
        'requiredMinRepFaction: $requiredMinRepFaction, '
        'requiredMaxRepFaction: $requiredMaxRepFaction, '
        'requiredMinRepValue: $requiredMinRepValue, '
        'requiredMaxRepValue: $requiredMaxRepValue, '
        'providedItemCount: $providedItemCount, '
        'specialFlags: $specialFlags'
        ')';
  }
}
