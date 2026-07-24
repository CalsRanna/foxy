import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'destructible_model_data_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_destructible_model_data')
class DestructibleModelDataEntity with _DestructibleModelDataEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('State0ImpactEffectDoodadSet')
  final int state0ImpactEffectDoodadSet;

  @FoxyFullField('State0AmbientDoodadSet')
  final int state0AmbientDoodadSet;

  @FoxyBriefField()
  @FoxyFullField('State1WMO')
  final int state1Wmo;

  @FoxyFullField('State1DestructionDoodadSet')
  final int state1DestructionDoodadSet;

  @FoxyFullField('State1ImpactEffectDoodadSet')
  final int state1ImpactEffectDoodadSet;

  @FoxyFullField('State1AmbientDoodadSet')
  final int state1AmbientDoodadSet;

  @FoxyBriefField()
  @FoxyFullField('State2WMO')
  final int state2Wmo;

  @FoxyFullField('State2DestructionDoodadSet')
  final int state2DestructionDoodadSet;

  @FoxyFullField('State2ImpactEffectDoodadSet')
  final int state2ImpactEffectDoodadSet;

  @FoxyFullField('State2AmbientDoodadSet')
  final int state2AmbientDoodadSet;

  @FoxyBriefField()
  @FoxyFullField('State3WMO')
  final int state3Wmo;

  @FoxyFullField('State3InitDoodadSet')
  final int state3InitDoodadSet;

  @FoxyFullField('State3AmbientDoodadSet')
  final int state3AmbientDoodadSet;

  @FoxyFullField('EjectDirection')
  final int ejectDirection;

  @FoxyFullField('RepairGroundFx')
  final int repairGroundFx;

  @FoxyFullField('DoNotHighlight')
  final int doNotHighlight;

  @FoxyFullField('HealEffect')
  final int healEffect;

  @FoxyFullField('HealEffectSpeed')
  final int healEffectSpeed;

  const DestructibleModelDataEntity({
    this.id = 0,
    this.state0ImpactEffectDoodadSet = 0,
    this.state0AmbientDoodadSet = 0,
    this.state1Wmo = 0,
    this.state1DestructionDoodadSet = 0,
    this.state1ImpactEffectDoodadSet = 0,
    this.state1AmbientDoodadSet = 0,
    this.state2Wmo = 0,
    this.state2DestructionDoodadSet = 0,
    this.state2ImpactEffectDoodadSet = 0,
    this.state2AmbientDoodadSet = 0,
    this.state3Wmo = 0,
    this.state3InitDoodadSet = 0,
    this.state3AmbientDoodadSet = 0,
    this.ejectDirection = 0,
    this.repairGroundFx = 0,
    this.doNotHighlight = 0,
    this.healEffect = 0,
    this.healEffectSpeed = 0,
  });

  factory DestructibleModelDataEntity.fromJson(Map<String, dynamic> json) =>
      _DestructibleModelDataEntityMixin.fromJson(json);
}
