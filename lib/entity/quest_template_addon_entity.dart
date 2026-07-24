// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'quest_template_addon_entity.g.dart';

/// QuestTemplateAddon 模型
/// quest_template_addon 表，1:1 关系与 quest_template，共享 ID 主键。

@FoxyBriefEntity()
@FoxyFullEntity(table: 'quest_template_addon')
class QuestTemplateAddonEntity with _QuestTemplateAddonEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('MaxLevel')
  final int maxLevel;

  @FoxyFullField('AllowableClasses')
  final int allowableClasses;

  @FoxyFullField('SourceSpellID')
  final int sourceSpellId;

  @FoxyBriefField()
  @FoxyFullField('PrevQuestID')
  final int prevQuestId;

  @FoxyBriefField()
  @FoxyFullField('NextQuestID')
  final int nextQuestId;

  @FoxyFullField('ExclusiveGroup')
  final int exclusiveGroup;

  @FoxyFullField('BreadcrumbForQuestId')
  final int breadcrumbForQuestId;

  @FoxyFullField('RewardMailTemplateID')
  final int rewardMailTemplateId;

  @FoxyFullField('RewardMailDelay')
  final int rewardMailDelay;

  @FoxyFullField('RequiredSkillID')
  final int requiredSkillId;

  @FoxyFullField('RequiredSkillPoints')
  final int requiredSkillPoints;

  @FoxyFullField('RequiredMinRepFaction')
  final int requiredMinRepFaction;

  @FoxyFullField('RequiredMaxRepFaction')
  final int requiredMaxRepFaction;

  @FoxyFullField('RequiredMinRepValue')
  final int requiredMinRepValue;

  @FoxyFullField('RequiredMaxRepValue')
  final int requiredMaxRepValue;

  @FoxyFullField('ProvidedItemCount')
  final int providedItemCount;

  @FoxyBriefField()
  @FoxyFullField('SpecialFlags')
  final int specialFlags;

  const QuestTemplateAddonEntity({
    this.id = 0,
    this.maxLevel = 0,
    this.allowableClasses = 0,
    this.sourceSpellId = 0,
    this.prevQuestId = 0,
    this.nextQuestId = 0,
    this.exclusiveGroup = 0,
    this.breadcrumbForQuestId = 0,
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

  factory QuestTemplateAddonEntity.fromJson(Map<String, dynamic> json) =>
      _QuestTemplateAddonEntityMixin.fromJson(json);
}
