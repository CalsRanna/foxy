// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'npc_trainer_entity.g.dart';

/// 训练师技能 — 对应 trainer_spell 表（复合键: TrainerId + SpellId）。

@FoxyFullEntity(table: 'trainer_spell')
class NpcTrainerEntity with _NpcTrainerEntityMixin {
  @FoxyFullField('TrainerId', key: true)
  final int trainerId;

  @FoxyFullField('SpellId', key: true)
  final int spellId;

  @FoxyFullField('MoneyCost')
  final int moneyCost;

  @FoxyFullField('ReqSkillLine')
  final int reqSkillLine;

  @FoxyFullField('ReqSkillRank')
  final int reqSkillRank;

  @FoxyFullField('ReqAbility1')
  final int reqAbility1;

  @FoxyFullField('ReqAbility2')
  final int reqAbility2;

  @FoxyFullField('ReqAbility3')
  final int reqAbility3;

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
