// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destructible_model_data_entity.dart';

mixin _DestructibleModelDataEntityMixin {
  int get id;
  int get state0ImpactEffectDoodadSet;
  int get state0AmbientDoodadSet;
  int get state1Wmo;
  int get state1DestructionDoodadSet;
  int get state1ImpactEffectDoodadSet;
  int get state1AmbientDoodadSet;
  int get state2Wmo;
  int get state2DestructionDoodadSet;
  int get state2ImpactEffectDoodadSet;
  int get state2AmbientDoodadSet;
  int get state3Wmo;
  int get state3InitDoodadSet;
  int get state3AmbientDoodadSet;
  int get ejectDirection;
  int get repairGroundFx;
  int get doNotHighlight;
  int get healEffect;
  int get healEffectSpeed;

  static DestructibleModelDataEntity fromJson(Map<String, dynamic> json) {
    return DestructibleModelDataEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      state0ImpactEffectDoodadSet:
          (json['State0ImpactEffectDoodadSet'] as num?)?.toInt() ?? 0,
      state0AmbientDoodadSet:
          (json['State0AmbientDoodadSet'] as num?)?.toInt() ?? 0,
      state1Wmo: (json['State1WMO'] as num?)?.toInt() ?? 0,
      state1DestructionDoodadSet:
          (json['State1DestructionDoodadSet'] as num?)?.toInt() ?? 0,
      state1ImpactEffectDoodadSet:
          (json['State1ImpactEffectDoodadSet'] as num?)?.toInt() ?? 0,
      state1AmbientDoodadSet:
          (json['State1AmbientDoodadSet'] as num?)?.toInt() ?? 0,
      state2Wmo: (json['State2WMO'] as num?)?.toInt() ?? 0,
      state2DestructionDoodadSet:
          (json['State2DestructionDoodadSet'] as num?)?.toInt() ?? 0,
      state2ImpactEffectDoodadSet:
          (json['State2ImpactEffectDoodadSet'] as num?)?.toInt() ?? 0,
      state2AmbientDoodadSet:
          (json['State2AmbientDoodadSet'] as num?)?.toInt() ?? 0,
      state3Wmo: (json['State3WMO'] as num?)?.toInt() ?? 0,
      state3InitDoodadSet: (json['State3InitDoodadSet'] as num?)?.toInt() ?? 0,
      state3AmbientDoodadSet:
          (json['State3AmbientDoodadSet'] as num?)?.toInt() ?? 0,
      ejectDirection: (json['EjectDirection'] as num?)?.toInt() ?? 0,
      repairGroundFx: (json['RepairGroundFx'] as num?)?.toInt() ?? 0,
      doNotHighlight: (json['DoNotHighlight'] as num?)?.toInt() ?? 0,
      healEffect: (json['HealEffect'] as num?)?.toInt() ?? 0,
      healEffectSpeed: (json['HealEffectSpeed'] as num?)?.toInt() ?? 0,
    );
  }

  DestructibleModelDataEntity copyWith({
    int? id,
    int? state0ImpactEffectDoodadSet,
    int? state0AmbientDoodadSet,
    int? state1Wmo,
    int? state1DestructionDoodadSet,
    int? state1ImpactEffectDoodadSet,
    int? state1AmbientDoodadSet,
    int? state2Wmo,
    int? state2DestructionDoodadSet,
    int? state2ImpactEffectDoodadSet,
    int? state2AmbientDoodadSet,
    int? state3Wmo,
    int? state3InitDoodadSet,
    int? state3AmbientDoodadSet,
    int? ejectDirection,
    int? repairGroundFx,
    int? doNotHighlight,
    int? healEffect,
    int? healEffectSpeed,
  }) {
    return DestructibleModelDataEntity(
      id: id ?? this.id,
      state0ImpactEffectDoodadSet:
          state0ImpactEffectDoodadSet ?? this.state0ImpactEffectDoodadSet,
      state0AmbientDoodadSet:
          state0AmbientDoodadSet ?? this.state0AmbientDoodadSet,
      state1Wmo: state1Wmo ?? this.state1Wmo,
      state1DestructionDoodadSet:
          state1DestructionDoodadSet ?? this.state1DestructionDoodadSet,
      state1ImpactEffectDoodadSet:
          state1ImpactEffectDoodadSet ?? this.state1ImpactEffectDoodadSet,
      state1AmbientDoodadSet:
          state1AmbientDoodadSet ?? this.state1AmbientDoodadSet,
      state2Wmo: state2Wmo ?? this.state2Wmo,
      state2DestructionDoodadSet:
          state2DestructionDoodadSet ?? this.state2DestructionDoodadSet,
      state2ImpactEffectDoodadSet:
          state2ImpactEffectDoodadSet ?? this.state2ImpactEffectDoodadSet,
      state2AmbientDoodadSet:
          state2AmbientDoodadSet ?? this.state2AmbientDoodadSet,
      state3Wmo: state3Wmo ?? this.state3Wmo,
      state3InitDoodadSet: state3InitDoodadSet ?? this.state3InitDoodadSet,
      state3AmbientDoodadSet:
          state3AmbientDoodadSet ?? this.state3AmbientDoodadSet,
      ejectDirection: ejectDirection ?? this.ejectDirection,
      repairGroundFx: repairGroundFx ?? this.repairGroundFx,
      doNotHighlight: doNotHighlight ?? this.doNotHighlight,
      healEffect: healEffect ?? this.healEffect,
      healEffectSpeed: healEffectSpeed ?? this.healEffectSpeed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DestructibleModelDataEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            state0ImpactEffectDoodadSet == other.state0ImpactEffectDoodadSet &&
            state0AmbientDoodadSet == other.state0AmbientDoodadSet &&
            state1Wmo == other.state1Wmo &&
            state1DestructionDoodadSet == other.state1DestructionDoodadSet &&
            state1ImpactEffectDoodadSet == other.state1ImpactEffectDoodadSet &&
            state1AmbientDoodadSet == other.state1AmbientDoodadSet &&
            state2Wmo == other.state2Wmo &&
            state2DestructionDoodadSet == other.state2DestructionDoodadSet &&
            state2ImpactEffectDoodadSet == other.state2ImpactEffectDoodadSet &&
            state2AmbientDoodadSet == other.state2AmbientDoodadSet &&
            state3Wmo == other.state3Wmo &&
            state3InitDoodadSet == other.state3InitDoodadSet &&
            state3AmbientDoodadSet == other.state3AmbientDoodadSet &&
            ejectDirection == other.ejectDirection &&
            repairGroundFx == other.repairGroundFx &&
            doNotHighlight == other.doNotHighlight &&
            healEffect == other.healEffect &&
            healEffectSpeed == other.healEffectSpeed;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      state0ImpactEffectDoodadSet,
      state0AmbientDoodadSet,
      state1Wmo,
      state1DestructionDoodadSet,
      state1ImpactEffectDoodadSet,
      state1AmbientDoodadSet,
      state2Wmo,
      state2DestructionDoodadSet,
      state2ImpactEffectDoodadSet,
      state2AmbientDoodadSet,
      state3Wmo,
      state3InitDoodadSet,
      state3AmbientDoodadSet,
      ejectDirection,
      repairGroundFx,
      doNotHighlight,
      healEffect,
      healEffectSpeed,
    ]);
  }

  @override
  String toString() {
    return 'DestructibleModelDataEntity('
        'id: $id, '
        'state0ImpactEffectDoodadSet: $state0ImpactEffectDoodadSet, '
        'state0AmbientDoodadSet: $state0AmbientDoodadSet, '
        'state1Wmo: $state1Wmo, '
        'state1DestructionDoodadSet: $state1DestructionDoodadSet, '
        'state1ImpactEffectDoodadSet: $state1ImpactEffectDoodadSet, '
        'state1AmbientDoodadSet: $state1AmbientDoodadSet, '
        'state2Wmo: $state2Wmo, '
        'state2DestructionDoodadSet: $state2DestructionDoodadSet, '
        'state2ImpactEffectDoodadSet: $state2ImpactEffectDoodadSet, '
        'state2AmbientDoodadSet: $state2AmbientDoodadSet, '
        'state3Wmo: $state3Wmo, '
        'state3InitDoodadSet: $state3InitDoodadSet, '
        'state3AmbientDoodadSet: $state3AmbientDoodadSet, '
        'ejectDirection: $ejectDirection, '
        'repairGroundFx: $repairGroundFx, '
        'doNotHighlight: $doNotHighlight, '
        'healEffect: $healEffect, '
        'healEffectSpeed: $healEffectSpeed'
        ')';
  }
}
