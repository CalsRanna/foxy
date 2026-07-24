// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_model_info_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'creature_model_info')
class CreatureModelInfoEntity with _CreatureModelInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('DisplayID', key: true)
  final int displayId;

  @FoxyBriefField()
  @FoxyFullField('BoundingRadius')
  final double boundingRadius;

  @FoxyBriefField()
  @FoxyFullField('CombatReach')
  final double combatReach;

  @FoxyBriefField()
  @FoxyFullField('Gender')
  final int gender;

  @FoxyBriefField()
  @FoxyFullField('DisplayID_Other_Gender')
  final int displayIdOtherGender;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const CreatureModelInfoEntity({
    this.displayId = 0,
    this.boundingRadius = 0.0,
    this.combatReach = 0.0,
    this.gender = 0,
    this.displayIdOtherGender = 0,
    this.verifiedBuild = 0,
  });

  factory CreatureModelInfoEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureModelInfoEntityMixin.fromJson(json);
}
