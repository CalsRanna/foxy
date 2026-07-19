import 'package:foxy/entity/npc_trainer_key.dart';

/// 训练师技能列表展示模型（含 DBC 技能名称）。
class BriefNpcTrainerEntity {
  final int trainerId;
  final int spellId;
  final int moneyCost;
  final int reqSkillLine;
  final int reqLevel;
  final String spellName;
  final String spellSubtext;

  const BriefNpcTrainerEntity({
    this.trainerId = 0,
    this.spellId = 0,
    this.moneyCost = 0,
    this.reqSkillLine = 0,
    this.reqLevel = 0,
    this.spellName = '',
    this.spellSubtext = '',
  });

  factory BriefNpcTrainerEntity.fromJson(Map<String, dynamic> json) {
    return BriefNpcTrainerEntity(
      trainerId: json['TrainerId'] ?? 0,
      spellId: json['SpellId'] ?? 0,
      moneyCost: json['MoneyCost'] ?? 0,
      reqSkillLine: json['ReqSkillLine'] ?? 0,
      reqLevel: json['ReqLevel'] ?? 0,
      spellName: json['spellName'] ?? '',
      spellSubtext: json['spellSubtext'] ?? '',
    );
  }

  NpcTrainerKey get key =>
      NpcTrainerKey(trainerId: trainerId, spellId: spellId);
}
