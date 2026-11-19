import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

part 'creature_model_info_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity()
class CreatureModelInfoEntity with _CreatureModelInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFieldMeaning.reference(
    '模型显示',
    table: 'foxy.dbc_creature_display_info',
    column: 'ID',
  )
  @FoxyFullField('DisplayID', key: true)
  final int displayId;

  @FoxyBriefField()
  @FoxyFullField('BoundingRadius')
  final double boundingRadius;

  @FoxyBriefField()
  @FoxyFullField('CombatReach')
  final double combatReach;

  @FoxyBriefField()
  @FoxyFieldMeaning.enumValues('性别', values: SpellEnums.spellAreaGenderOptions)
  @FoxyFullField('Gender')
  final int gender;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference(
    '其他性别显示',
    table: 'foxy.dbc_creature_display_info',
    column: 'ID',
  )
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
