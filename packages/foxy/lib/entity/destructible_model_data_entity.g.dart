// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destructible_model_data_entity.dart';

final class BriefDestructibleModelDataEntity {
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

  factory BriefDestructibleModelDataEntity.fromJson(Map<String, dynamic> json) {
    return BriefDestructibleModelDataEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      state1Wmo: json['State1WMO'] == true
          ? 1
          : json['State1WMO'] == false
          ? 0
          : (json['State1WMO'] as num?)?.toInt() ?? 0,
      state2Wmo: json['State2WMO'] == true
          ? 1
          : json['State2WMO'] == false
          ? 0
          : (json['State2WMO'] as num?)?.toInt() ?? 0,
      state3Wmo: json['State3WMO'] == true
          ? 1
          : json['State3WMO'] == false
          ? 0
          : (json['State3WMO'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  int get hashCode => Object.hashAll([id, state1Wmo, state2Wmo, state3Wmo]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefDestructibleModelDataEntity &&
            id == other.id &&
            state1Wmo == other.state1Wmo &&
            state2Wmo == other.state2Wmo &&
            state3Wmo == other.state3Wmo;
  }

  @override
  String toString() {
    return 'BriefDestructibleModelDataEntity('
        'id: $id, '
        'state1Wmo: $state1Wmo, '
        'state2Wmo: $state2Wmo, '
        'state3Wmo: $state3Wmo'
        ')';
  }
}

mixin _DestructibleModelDataEntityMixin {
  @override
  int get hashCode {
    final self = this as DestructibleModelDataEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.state0ImpactEffectDoodadSet,
      self.state0AmbientDoodadSet,
      self.state1Wmo,
      self.state1DestructionDoodadSet,
      self.state1ImpactEffectDoodadSet,
      self.state1AmbientDoodadSet,
      self.state2Wmo,
      self.state2DestructionDoodadSet,
      self.state2ImpactEffectDoodadSet,
      self.state2AmbientDoodadSet,
      self.state3Wmo,
      self.state3InitDoodadSet,
      self.state3AmbientDoodadSet,
      self.ejectDirection,
      self.repairGroundFx,
      self.doNotHighlight,
      self.healEffect,
      self.healEffectSpeed,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as DestructibleModelDataEntity;
    return identical(self, other) ||
        other is DestructibleModelDataEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.state0ImpactEffectDoodadSet ==
                other.state0ImpactEffectDoodadSet &&
            self.state0AmbientDoodadSet == other.state0AmbientDoodadSet &&
            self.state1Wmo == other.state1Wmo &&
            self.state1DestructionDoodadSet ==
                other.state1DestructionDoodadSet &&
            self.state1ImpactEffectDoodadSet ==
                other.state1ImpactEffectDoodadSet &&
            self.state1AmbientDoodadSet == other.state1AmbientDoodadSet &&
            self.state2Wmo == other.state2Wmo &&
            self.state2DestructionDoodadSet ==
                other.state2DestructionDoodadSet &&
            self.state2ImpactEffectDoodadSet ==
                other.state2ImpactEffectDoodadSet &&
            self.state2AmbientDoodadSet == other.state2AmbientDoodadSet &&
            self.state3Wmo == other.state3Wmo &&
            self.state3InitDoodadSet == other.state3InitDoodadSet &&
            self.state3AmbientDoodadSet == other.state3AmbientDoodadSet &&
            self.ejectDirection == other.ejectDirection &&
            self.repairGroundFx == other.repairGroundFx &&
            self.doNotHighlight == other.doNotHighlight &&
            self.healEffect == other.healEffect &&
            self.healEffectSpeed == other.healEffectSpeed;
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
    final self = this as DestructibleModelDataEntity;
    return DestructibleModelDataEntity(
      id: id ?? self.id,
      state0ImpactEffectDoodadSet:
          state0ImpactEffectDoodadSet ?? self.state0ImpactEffectDoodadSet,
      state0AmbientDoodadSet:
          state0AmbientDoodadSet ?? self.state0AmbientDoodadSet,
      state1Wmo: state1Wmo ?? self.state1Wmo,
      state1DestructionDoodadSet:
          state1DestructionDoodadSet ?? self.state1DestructionDoodadSet,
      state1ImpactEffectDoodadSet:
          state1ImpactEffectDoodadSet ?? self.state1ImpactEffectDoodadSet,
      state1AmbientDoodadSet:
          state1AmbientDoodadSet ?? self.state1AmbientDoodadSet,
      state2Wmo: state2Wmo ?? self.state2Wmo,
      state2DestructionDoodadSet:
          state2DestructionDoodadSet ?? self.state2DestructionDoodadSet,
      state2ImpactEffectDoodadSet:
          state2ImpactEffectDoodadSet ?? self.state2ImpactEffectDoodadSet,
      state2AmbientDoodadSet:
          state2AmbientDoodadSet ?? self.state2AmbientDoodadSet,
      state3Wmo: state3Wmo ?? self.state3Wmo,
      state3InitDoodadSet: state3InitDoodadSet ?? self.state3InitDoodadSet,
      state3AmbientDoodadSet:
          state3AmbientDoodadSet ?? self.state3AmbientDoodadSet,
      ejectDirection: ejectDirection ?? self.ejectDirection,
      repairGroundFx: repairGroundFx ?? self.repairGroundFx,
      doNotHighlight: doNotHighlight ?? self.doNotHighlight,
      healEffect: healEffect ?? self.healEffect,
      healEffectSpeed: healEffectSpeed ?? self.healEffectSpeed,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as DestructibleModelDataEntity;
    return {
      'ID': self.id,
      'State0ImpactEffectDoodadSet': self.state0ImpactEffectDoodadSet,
      'State0AmbientDoodadSet': self.state0AmbientDoodadSet,
      'State1WMO': self.state1Wmo,
      'State1DestructionDoodadSet': self.state1DestructionDoodadSet,
      'State1ImpactEffectDoodadSet': self.state1ImpactEffectDoodadSet,
      'State1AmbientDoodadSet': self.state1AmbientDoodadSet,
      'State2WMO': self.state2Wmo,
      'State2DestructionDoodadSet': self.state2DestructionDoodadSet,
      'State2ImpactEffectDoodadSet': self.state2ImpactEffectDoodadSet,
      'State2AmbientDoodadSet': self.state2AmbientDoodadSet,
      'State3WMO': self.state3Wmo,
      'State3InitDoodadSet': self.state3InitDoodadSet,
      'State3AmbientDoodadSet': self.state3AmbientDoodadSet,
      'EjectDirection': self.ejectDirection,
      'RepairGroundFx': self.repairGroundFx,
      'DoNotHighlight': self.doNotHighlight,
      'HealEffect': self.healEffect,
      'HealEffectSpeed': self.healEffectSpeed,
    };
  }

  @override
  String toString() {
    final self = this as DestructibleModelDataEntity;
    return 'DestructibleModelDataEntity('
        'id: ${self.id}, '
        'state0ImpactEffectDoodadSet: ${self.state0ImpactEffectDoodadSet}, '
        'state0AmbientDoodadSet: ${self.state0AmbientDoodadSet}, '
        'state1Wmo: ${self.state1Wmo}, '
        'state1DestructionDoodadSet: ${self.state1DestructionDoodadSet}, '
        'state1ImpactEffectDoodadSet: ${self.state1ImpactEffectDoodadSet}, '
        'state1AmbientDoodadSet: ${self.state1AmbientDoodadSet}, '
        'state2Wmo: ${self.state2Wmo}, '
        'state2DestructionDoodadSet: ${self.state2DestructionDoodadSet}, '
        'state2ImpactEffectDoodadSet: ${self.state2ImpactEffectDoodadSet}, '
        'state2AmbientDoodadSet: ${self.state2AmbientDoodadSet}, '
        'state3Wmo: ${self.state3Wmo}, '
        'state3InitDoodadSet: ${self.state3InitDoodadSet}, '
        'state3AmbientDoodadSet: ${self.state3AmbientDoodadSet}, '
        'ejectDirection: ${self.ejectDirection}, '
        'repairGroundFx: ${self.repairGroundFx}, '
        'doNotHighlight: ${self.doNotHighlight}, '
        'healEffect: ${self.healEffect}, '
        'healEffectSpeed: ${self.healEffectSpeed}'
        ')';
  }

  static DestructibleModelDataEntity fromJson(Map<String, dynamic> json) {
    return DestructibleModelDataEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      state0ImpactEffectDoodadSet: json['State0ImpactEffectDoodadSet'] == true
          ? 1
          : json['State0ImpactEffectDoodadSet'] == false
          ? 0
          : (json['State0ImpactEffectDoodadSet'] as num?)?.toInt() ?? 0,
      state0AmbientDoodadSet: json['State0AmbientDoodadSet'] == true
          ? 1
          : json['State0AmbientDoodadSet'] == false
          ? 0
          : (json['State0AmbientDoodadSet'] as num?)?.toInt() ?? 0,
      state1Wmo: json['State1WMO'] == true
          ? 1
          : json['State1WMO'] == false
          ? 0
          : (json['State1WMO'] as num?)?.toInt() ?? 0,
      state1DestructionDoodadSet: json['State1DestructionDoodadSet'] == true
          ? 1
          : json['State1DestructionDoodadSet'] == false
          ? 0
          : (json['State1DestructionDoodadSet'] as num?)?.toInt() ?? 0,
      state1ImpactEffectDoodadSet: json['State1ImpactEffectDoodadSet'] == true
          ? 1
          : json['State1ImpactEffectDoodadSet'] == false
          ? 0
          : (json['State1ImpactEffectDoodadSet'] as num?)?.toInt() ?? 0,
      state1AmbientDoodadSet: json['State1AmbientDoodadSet'] == true
          ? 1
          : json['State1AmbientDoodadSet'] == false
          ? 0
          : (json['State1AmbientDoodadSet'] as num?)?.toInt() ?? 0,
      state2Wmo: json['State2WMO'] == true
          ? 1
          : json['State2WMO'] == false
          ? 0
          : (json['State2WMO'] as num?)?.toInt() ?? 0,
      state2DestructionDoodadSet: json['State2DestructionDoodadSet'] == true
          ? 1
          : json['State2DestructionDoodadSet'] == false
          ? 0
          : (json['State2DestructionDoodadSet'] as num?)?.toInt() ?? 0,
      state2ImpactEffectDoodadSet: json['State2ImpactEffectDoodadSet'] == true
          ? 1
          : json['State2ImpactEffectDoodadSet'] == false
          ? 0
          : (json['State2ImpactEffectDoodadSet'] as num?)?.toInt() ?? 0,
      state2AmbientDoodadSet: json['State2AmbientDoodadSet'] == true
          ? 1
          : json['State2AmbientDoodadSet'] == false
          ? 0
          : (json['State2AmbientDoodadSet'] as num?)?.toInt() ?? 0,
      state3Wmo: json['State3WMO'] == true
          ? 1
          : json['State3WMO'] == false
          ? 0
          : (json['State3WMO'] as num?)?.toInt() ?? 0,
      state3InitDoodadSet: json['State3InitDoodadSet'] == true
          ? 1
          : json['State3InitDoodadSet'] == false
          ? 0
          : (json['State3InitDoodadSet'] as num?)?.toInt() ?? 0,
      state3AmbientDoodadSet: json['State3AmbientDoodadSet'] == true
          ? 1
          : json['State3AmbientDoodadSet'] == false
          ? 0
          : (json['State3AmbientDoodadSet'] as num?)?.toInt() ?? 0,
      ejectDirection: json['EjectDirection'] == true
          ? 1
          : json['EjectDirection'] == false
          ? 0
          : (json['EjectDirection'] as num?)?.toInt() ?? 0,
      repairGroundFx: json['RepairGroundFx'] == true
          ? 1
          : json['RepairGroundFx'] == false
          ? 0
          : (json['RepairGroundFx'] as num?)?.toInt() ?? 0,
      doNotHighlight: json['DoNotHighlight'] == true
          ? 1
          : json['DoNotHighlight'] == false
          ? 0
          : (json['DoNotHighlight'] as num?)?.toInt() ?? 0,
      healEffect: json['HealEffect'] == true
          ? 1
          : json['HealEffect'] == false
          ? 0
          : (json['HealEffect'] as num?)?.toInt() ?? 0,
      healEffectSpeed: json['HealEffectSpeed'] == true
          ? 1
          : json['HealEffectSpeed'] == false
          ? 0
          : (json['HealEffectSpeed'] as num?)?.toInt() ?? 0,
    );
  }
}
