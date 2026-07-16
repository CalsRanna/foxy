class BriefDestructibleModelDataEntity {
  final int id;
  final int state1Wmo;
  final int state2Wmo;
  final int state3Wmo;

  const BriefDestructibleModelDataEntity({
    this.id = 0,
    this.state1Wmo = 0,
    this.state2Wmo = 0,
    this.state3Wmo = 0,
  });

  factory BriefDestructibleModelDataEntity.fromJson(
    Map<String, dynamic> json,
  ) => DestructibleModelDataEntity.fromJson(json).toBrief();
}

class DestructibleModelDataEntity {
  final int id;
  final int state0ImpactEffectDoodadSet;
  final int state0AmbientDoodadSet;
  final int state1Wmo;
  final int state1DestructionDoodadSet;
  final int state1ImpactEffectDoodadSet;
  final int state1AmbientDoodadSet;
  final int state2Wmo;
  final int state2DestructionDoodadSet;
  final int state2ImpactEffectDoodadSet;
  final int state2AmbientDoodadSet;
  final int state3Wmo;
  final int state3InitDoodadSet;
  final int state3AmbientDoodadSet;
  final int ejectDirection;
  final int repairGroundFx;
  final int doNotHighlight;
  final int healEffect;
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

  factory DestructibleModelDataEntity.fromJson(Map<String, dynamic> json) {
    return DestructibleModelDataEntity(
      id: json['ID'] ?? 0,
      state0ImpactEffectDoodadSet: json['State0ImpactEffectDoodadSet'] ?? 0,
      state0AmbientDoodadSet: json['State0AmbientDoodadSet'] ?? 0,
      state1Wmo: json['State1WMO'] ?? 0,
      state1DestructionDoodadSet: json['State1DestructionDoodadSet'] ?? 0,
      state1ImpactEffectDoodadSet: json['State1ImpactEffectDoodadSet'] ?? 0,
      state1AmbientDoodadSet: json['State1AmbientDoodadSet'] ?? 0,
      state2Wmo: json['State2WMO'] ?? 0,
      state2DestructionDoodadSet: json['State2DestructionDoodadSet'] ?? 0,
      state2ImpactEffectDoodadSet: json['State2ImpactEffectDoodadSet'] ?? 0,
      state2AmbientDoodadSet: json['State2AmbientDoodadSet'] ?? 0,
      state3Wmo: json['State3WMO'] ?? 0,
      state3InitDoodadSet: json['State3InitDoodadSet'] ?? 0,
      state3AmbientDoodadSet: json['State3AmbientDoodadSet'] ?? 0,
      ejectDirection: json['EjectDirection'] ?? 0,
      repairGroundFx: json['RepairGroundFx'] ?? 0,
      doNotHighlight: json['DoNotHighlight'] ?? 0,
      healEffect: json['HealEffect'] ?? 0,
      healEffectSpeed: json['HealEffectSpeed'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'State0ImpactEffectDoodadSet': state0ImpactEffectDoodadSet,
    'State0AmbientDoodadSet': state0AmbientDoodadSet,
    'State1WMO': state1Wmo,
    'State1DestructionDoodadSet': state1DestructionDoodadSet,
    'State1ImpactEffectDoodadSet': state1ImpactEffectDoodadSet,
    'State1AmbientDoodadSet': state1AmbientDoodadSet,
    'State2WMO': state2Wmo,
    'State2DestructionDoodadSet': state2DestructionDoodadSet,
    'State2ImpactEffectDoodadSet': state2ImpactEffectDoodadSet,
    'State2AmbientDoodadSet': state2AmbientDoodadSet,
    'State3WMO': state3Wmo,
    'State3InitDoodadSet': state3InitDoodadSet,
    'State3AmbientDoodadSet': state3AmbientDoodadSet,
    'EjectDirection': ejectDirection,
    'RepairGroundFx': repairGroundFx,
    'DoNotHighlight': doNotHighlight,
    'HealEffect': healEffect,
    'HealEffectSpeed': healEffectSpeed,
  };
}

extension on DestructibleModelDataEntity {
  BriefDestructibleModelDataEntity toBrief() =>
      BriefDestructibleModelDataEntity(
        id: id,
        state1Wmo: state1Wmo,
        state2Wmo: state2Wmo,
        state3Wmo: state3Wmo,
      );
}
