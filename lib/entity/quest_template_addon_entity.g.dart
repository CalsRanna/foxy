// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_addon_entity.dart';

mixin _QuestTemplateAddonEntityMixin {
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
    final self = this as QuestTemplateAddonEntity;
    return QuestTemplateAddonEntity(
      id: id ?? self.id,
      maxLevel: maxLevel ?? self.maxLevel,
      allowableClasses: allowableClasses ?? self.allowableClasses,
      sourceSpellId: sourceSpellId ?? self.sourceSpellId,
      prevQuestId: prevQuestId ?? self.prevQuestId,
      nextQuestId: nextQuestId ?? self.nextQuestId,
      exclusiveGroup: exclusiveGroup ?? self.exclusiveGroup,
      breadcrumbForQuestId: breadcrumbForQuestId ?? self.breadcrumbForQuestId,
      rewardMailTemplateId: rewardMailTemplateId ?? self.rewardMailTemplateId,
      rewardMailDelay: rewardMailDelay ?? self.rewardMailDelay,
      requiredSkillId: requiredSkillId ?? self.requiredSkillId,
      requiredSkillPoints: requiredSkillPoints ?? self.requiredSkillPoints,
      requiredMinRepFaction:
          requiredMinRepFaction ?? self.requiredMinRepFaction,
      requiredMaxRepFaction:
          requiredMaxRepFaction ?? self.requiredMaxRepFaction,
      requiredMinRepValue: requiredMinRepValue ?? self.requiredMinRepValue,
      requiredMaxRepValue: requiredMaxRepValue ?? self.requiredMaxRepValue,
      providedItemCount: providedItemCount ?? self.providedItemCount,
      specialFlags: specialFlags ?? self.specialFlags,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as QuestTemplateAddonEntity;
    return {
      'ID': self.id,
      'MaxLevel': self.maxLevel,
      'AllowableClasses': self.allowableClasses,
      'SourceSpellID': self.sourceSpellId,
      'PrevQuestID': self.prevQuestId,
      'NextQuestID': self.nextQuestId,
      'ExclusiveGroup': self.exclusiveGroup,
      'BreadcrumbForQuestId': self.breadcrumbForQuestId,
      'RewardMailTemplateID': self.rewardMailTemplateId,
      'RewardMailDelay': self.rewardMailDelay,
      'RequiredSkillID': self.requiredSkillId,
      'RequiredSkillPoints': self.requiredSkillPoints,
      'RequiredMinRepFaction': self.requiredMinRepFaction,
      'RequiredMaxRepFaction': self.requiredMaxRepFaction,
      'RequiredMinRepValue': self.requiredMinRepValue,
      'RequiredMaxRepValue': self.requiredMaxRepValue,
      'ProvidedItemCount': self.providedItemCount,
      'SpecialFlags': self.specialFlags,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as QuestTemplateAddonEntity;
    return identical(self, other) ||
        other is QuestTemplateAddonEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.maxLevel == other.maxLevel &&
            self.allowableClasses == other.allowableClasses &&
            self.sourceSpellId == other.sourceSpellId &&
            self.prevQuestId == other.prevQuestId &&
            self.nextQuestId == other.nextQuestId &&
            self.exclusiveGroup == other.exclusiveGroup &&
            self.breadcrumbForQuestId == other.breadcrumbForQuestId &&
            self.rewardMailTemplateId == other.rewardMailTemplateId &&
            self.rewardMailDelay == other.rewardMailDelay &&
            self.requiredSkillId == other.requiredSkillId &&
            self.requiredSkillPoints == other.requiredSkillPoints &&
            self.requiredMinRepFaction == other.requiredMinRepFaction &&
            self.requiredMaxRepFaction == other.requiredMaxRepFaction &&
            self.requiredMinRepValue == other.requiredMinRepValue &&
            self.requiredMaxRepValue == other.requiredMaxRepValue &&
            self.providedItemCount == other.providedItemCount &&
            self.specialFlags == other.specialFlags;
  }

  @override
  int get hashCode {
    final self = this as QuestTemplateAddonEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.maxLevel,
      self.allowableClasses,
      self.sourceSpellId,
      self.prevQuestId,
      self.nextQuestId,
      self.exclusiveGroup,
      self.breadcrumbForQuestId,
      self.rewardMailTemplateId,
      self.rewardMailDelay,
      self.requiredSkillId,
      self.requiredSkillPoints,
      self.requiredMinRepFaction,
      self.requiredMaxRepFaction,
      self.requiredMinRepValue,
      self.requiredMaxRepValue,
      self.providedItemCount,
      self.specialFlags,
    ]);
  }

  @override
  String toString() {
    final self = this as QuestTemplateAddonEntity;
    return 'QuestTemplateAddonEntity('
        'id: ${self.id}, '
        'maxLevel: ${self.maxLevel}, '
        'allowableClasses: ${self.allowableClasses}, '
        'sourceSpellId: ${self.sourceSpellId}, '
        'prevQuestId: ${self.prevQuestId}, '
        'nextQuestId: ${self.nextQuestId}, '
        'exclusiveGroup: ${self.exclusiveGroup}, '
        'breadcrumbForQuestId: ${self.breadcrumbForQuestId}, '
        'rewardMailTemplateId: ${self.rewardMailTemplateId}, '
        'rewardMailDelay: ${self.rewardMailDelay}, '
        'requiredSkillId: ${self.requiredSkillId}, '
        'requiredSkillPoints: ${self.requiredSkillPoints}, '
        'requiredMinRepFaction: ${self.requiredMinRepFaction}, '
        'requiredMaxRepFaction: ${self.requiredMaxRepFaction}, '
        'requiredMinRepValue: ${self.requiredMinRepValue}, '
        'requiredMaxRepValue: ${self.requiredMaxRepValue}, '
        'providedItemCount: ${self.providedItemCount}, '
        'specialFlags: ${self.specialFlags}'
        ')';
  }
}

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
