import 'package:foxy/entity/creature_template_resistance_key.dart';

/// 生物模板抗性列表展示模型。
class BriefCreatureTemplateResistanceEntity {
  final int creatureID;
  final int school;
  final int resistance;
  final int verifiedBuild;

  const BriefCreatureTemplateResistanceEntity({
    this.creatureID = 0,
    this.school = 0,
    this.resistance = 0,
    this.verifiedBuild = 0,
  });

  factory BriefCreatureTemplateResistanceEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefCreatureTemplateResistanceEntity(
      creatureID: json['CreatureID'] ?? json['creatureID'] ?? 0,
      school: json['School'] ?? json['school'] ?? 0,
      resistance: json['Resistance'] ?? json['resistance'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0,
    );
  }

  CreatureTemplateResistanceKey get key =>
      CreatureTemplateResistanceKey(creatureID: creatureID, school: school);
}
