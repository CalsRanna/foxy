import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'npc_trainer_entity.g.dart';

/// Trainer spells — maps to the trainer_spell table (composite key:
/// TrainerId + SpellId).

@FoxyBriefEntity()
@FoxyBriefField.text('spellName')
@FoxyBriefField.text('spellSubtext')
@FoxyBriefField.text('textureFilename')
@FoxyBriefField.text('skillLineName')
@FoxyBriefField.text('skillLineTextureFilename')
@FoxyFullEntity(table: 'trainer_spell')
class NpcTrainerEntity with _NpcTrainerEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('TrainerId', key: true)
  final int trainerId;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('法术', table: 'foxy.dbc_spell', column: 'ID')
  @FoxyFullField('SpellId', key: true)
  final int spellId;

  @FoxyBriefField()
  @FoxyFullField('MoneyCost')
  final int moneyCost;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference(
    '需要技能',
    table: 'foxy.dbc_skill_line',
    column: 'ID',
  )
  @FoxyFullField('ReqSkillLine')
  final int reqSkillLine;

  @FoxyFullField('ReqSkillRank')
  final int reqSkillRank;

  @FoxyFieldMeaning.reference('需要法术1', table: 'foxy.dbc_spell', column: 'ID')
  @FoxyFullField('ReqAbility1')
  final int reqAbility1;

  @FoxyFieldMeaning.reference('需要法术2', table: 'foxy.dbc_spell', column: 'ID')
  @FoxyFullField('ReqAbility2')
  final int reqAbility2;

  @FoxyFieldMeaning.reference('需要法术3', table: 'foxy.dbc_spell', column: 'ID')
  @FoxyFullField('ReqAbility3')
  final int reqAbility3;

  @FoxyBriefField()
  @FoxyFullField('ReqLevel')
  final int reqLevel;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const NpcTrainerEntity({
    this.trainerId = 0,
    this.spellId = 0,
    this.moneyCost = 0,
    this.reqSkillLine = 0,
    this.reqSkillRank = 0,
    this.reqAbility1 = 0,
    this.reqAbility2 = 0,
    this.reqAbility3 = 0,
    this.reqLevel = 0,
    this.verifiedBuild = 0,
  });

  factory NpcTrainerEntity.fromJson(Map<String, dynamic> json) =>
      _NpcTrainerEntityMixin.fromJson(json);
}
