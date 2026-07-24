// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_provider_preferences_entity.dart';

mixin _SoundProviderPreferencesEntityMixin {
  int get id;
  String get description;
  int get flags;
  int get eaxEnvironmentSelection;
  double get eaxDecayTime;
  double get eax2EnvironmentSize;
  double get eax2EnvironmentDiffusion;
  int get eax2Room;
  int get eax2RoomHf;
  double get eax2DecayHfRatio;
  int get eax2Reflections;
  double get eax2ReflectionsDelay;
  int get eax2Reverb;
  double get eax2ReverbDelay;
  double get eax2RoomRolloff;
  double get eax2AirAbsorption;
  int get eax3RoomLf;
  double get eax3DecayLfRatio;
  double get eax3EchoTime;
  double get eax3EchoDepth;
  double get eax3ModulationTime;
  double get eax3ModulationDepth;
  double get eax3HfReference;
  double get eax3LfReference;

  static SoundProviderPreferencesEntity fromJson(Map<String, dynamic> json) {
    return SoundProviderPreferencesEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      description: json['Description']?.toString() ?? '',
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      eaxEnvironmentSelection:
          (json['EAXEnvironmentSelection'] as num?)?.toInt() ?? 0,
      eaxDecayTime: (json['EAXDecayTime'] as num?)?.toDouble() ?? 0.0,
      eax2EnvironmentSize:
          (json['EAX2EnvironmentSize'] as num?)?.toDouble() ?? 0.0,
      eax2EnvironmentDiffusion:
          (json['EAX2EnvironmentDiffusion'] as num?)?.toDouble() ?? 0.0,
      eax2Room: (json['EAX2Room'] as num?)?.toInt() ?? 0,
      eax2RoomHf: (json['EAX2RoomHF'] as num?)?.toInt() ?? 0,
      eax2DecayHfRatio: (json['EAX2DecayHFRatio'] as num?)?.toDouble() ?? 0.0,
      eax2Reflections: (json['EAX2Reflections'] as num?)?.toInt() ?? 0,
      eax2ReflectionsDelay:
          (json['EAX2ReflectionsDelay'] as num?)?.toDouble() ?? 0.0,
      eax2Reverb: (json['EAX2Reverb'] as num?)?.toInt() ?? 0,
      eax2ReverbDelay: (json['EAX2ReverbDelay'] as num?)?.toDouble() ?? 0.0,
      eax2RoomRolloff: (json['EAX2RoomRolloff'] as num?)?.toDouble() ?? 0.0,
      eax2AirAbsorption: (json['EAX2AirAbsorption'] as num?)?.toDouble() ?? 0.0,
      eax3RoomLf: (json['EAX3RoomLF'] as num?)?.toInt() ?? 0,
      eax3DecayLfRatio: (json['EAX3DecayLFRatio'] as num?)?.toDouble() ?? 0.0,
      eax3EchoTime: (json['EAX3EchoTime'] as num?)?.toDouble() ?? 0.0,
      eax3EchoDepth: (json['EAX3EchoDepth'] as num?)?.toDouble() ?? 0.0,
      eax3ModulationTime:
          (json['EAX3ModulationTime'] as num?)?.toDouble() ?? 0.0,
      eax3ModulationDepth:
          (json['EAX3ModulationDepth'] as num?)?.toDouble() ?? 0.0,
      eax3HfReference: (json['EAX3HFReference'] as num?)?.toDouble() ?? 0.0,
      eax3LfReference: (json['EAX3LFReference'] as num?)?.toDouble() ?? 0.0,
    );
  }

  SoundProviderPreferencesEntity copyWith({
    int? id,
    String? description,
    int? flags,
    int? eaxEnvironmentSelection,
    double? eaxDecayTime,
    double? eax2EnvironmentSize,
    double? eax2EnvironmentDiffusion,
    int? eax2Room,
    int? eax2RoomHf,
    double? eax2DecayHfRatio,
    int? eax2Reflections,
    double? eax2ReflectionsDelay,
    int? eax2Reverb,
    double? eax2ReverbDelay,
    double? eax2RoomRolloff,
    double? eax2AirAbsorption,
    int? eax3RoomLf,
    double? eax3DecayLfRatio,
    double? eax3EchoTime,
    double? eax3EchoDepth,
    double? eax3ModulationTime,
    double? eax3ModulationDepth,
    double? eax3HfReference,
    double? eax3LfReference,
  }) {
    return SoundProviderPreferencesEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      flags: flags ?? this.flags,
      eaxEnvironmentSelection:
          eaxEnvironmentSelection ?? this.eaxEnvironmentSelection,
      eaxDecayTime: eaxDecayTime ?? this.eaxDecayTime,
      eax2EnvironmentSize: eax2EnvironmentSize ?? this.eax2EnvironmentSize,
      eax2EnvironmentDiffusion:
          eax2EnvironmentDiffusion ?? this.eax2EnvironmentDiffusion,
      eax2Room: eax2Room ?? this.eax2Room,
      eax2RoomHf: eax2RoomHf ?? this.eax2RoomHf,
      eax2DecayHfRatio: eax2DecayHfRatio ?? this.eax2DecayHfRatio,
      eax2Reflections: eax2Reflections ?? this.eax2Reflections,
      eax2ReflectionsDelay: eax2ReflectionsDelay ?? this.eax2ReflectionsDelay,
      eax2Reverb: eax2Reverb ?? this.eax2Reverb,
      eax2ReverbDelay: eax2ReverbDelay ?? this.eax2ReverbDelay,
      eax2RoomRolloff: eax2RoomRolloff ?? this.eax2RoomRolloff,
      eax2AirAbsorption: eax2AirAbsorption ?? this.eax2AirAbsorption,
      eax3RoomLf: eax3RoomLf ?? this.eax3RoomLf,
      eax3DecayLfRatio: eax3DecayLfRatio ?? this.eax3DecayLfRatio,
      eax3EchoTime: eax3EchoTime ?? this.eax3EchoTime,
      eax3EchoDepth: eax3EchoDepth ?? this.eax3EchoDepth,
      eax3ModulationTime: eax3ModulationTime ?? this.eax3ModulationTime,
      eax3ModulationDepth: eax3ModulationDepth ?? this.eax3ModulationDepth,
      eax3HfReference: eax3HfReference ?? this.eax3HfReference,
      eax3LfReference: eax3LfReference ?? this.eax3LfReference,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Description': description,
      'Flags': flags,
      'EAXEnvironmentSelection': eaxEnvironmentSelection,
      'EAXDecayTime': eaxDecayTime,
      'EAX2EnvironmentSize': eax2EnvironmentSize,
      'EAX2EnvironmentDiffusion': eax2EnvironmentDiffusion,
      'EAX2Room': eax2Room,
      'EAX2RoomHF': eax2RoomHf,
      'EAX2DecayHFRatio': eax2DecayHfRatio,
      'EAX2Reflections': eax2Reflections,
      'EAX2ReflectionsDelay': eax2ReflectionsDelay,
      'EAX2Reverb': eax2Reverb,
      'EAX2ReverbDelay': eax2ReverbDelay,
      'EAX2RoomRolloff': eax2RoomRolloff,
      'EAX2AirAbsorption': eax2AirAbsorption,
      'EAX3RoomLF': eax3RoomLf,
      'EAX3DecayLFRatio': eax3DecayLfRatio,
      'EAX3EchoTime': eax3EchoTime,
      'EAX3EchoDepth': eax3EchoDepth,
      'EAX3ModulationTime': eax3ModulationTime,
      'EAX3ModulationDepth': eax3ModulationDepth,
      'EAX3HFReference': eax3HfReference,
      'EAX3LFReference': eax3LfReference,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SoundProviderPreferencesEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            description == other.description &&
            flags == other.flags &&
            eaxEnvironmentSelection == other.eaxEnvironmentSelection &&
            eaxDecayTime == other.eaxDecayTime &&
            eax2EnvironmentSize == other.eax2EnvironmentSize &&
            eax2EnvironmentDiffusion == other.eax2EnvironmentDiffusion &&
            eax2Room == other.eax2Room &&
            eax2RoomHf == other.eax2RoomHf &&
            eax2DecayHfRatio == other.eax2DecayHfRatio &&
            eax2Reflections == other.eax2Reflections &&
            eax2ReflectionsDelay == other.eax2ReflectionsDelay &&
            eax2Reverb == other.eax2Reverb &&
            eax2ReverbDelay == other.eax2ReverbDelay &&
            eax2RoomRolloff == other.eax2RoomRolloff &&
            eax2AirAbsorption == other.eax2AirAbsorption &&
            eax3RoomLf == other.eax3RoomLf &&
            eax3DecayLfRatio == other.eax3DecayLfRatio &&
            eax3EchoTime == other.eax3EchoTime &&
            eax3EchoDepth == other.eax3EchoDepth &&
            eax3ModulationTime == other.eax3ModulationTime &&
            eax3ModulationDepth == other.eax3ModulationDepth &&
            eax3HfReference == other.eax3HfReference &&
            eax3LfReference == other.eax3LfReference;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      description,
      flags,
      eaxEnvironmentSelection,
      eaxDecayTime,
      eax2EnvironmentSize,
      eax2EnvironmentDiffusion,
      eax2Room,
      eax2RoomHf,
      eax2DecayHfRatio,
      eax2Reflections,
      eax2ReflectionsDelay,
      eax2Reverb,
      eax2ReverbDelay,
      eax2RoomRolloff,
      eax2AirAbsorption,
      eax3RoomLf,
      eax3DecayLfRatio,
      eax3EchoTime,
      eax3EchoDepth,
      eax3ModulationTime,
      eax3ModulationDepth,
      eax3HfReference,
      eax3LfReference,
    ]);
  }

  @override
  String toString() {
    return 'SoundProviderPreferencesEntity('
        'id: $id, '
        'description: $description, '
        'flags: $flags, '
        'eaxEnvironmentSelection: $eaxEnvironmentSelection, '
        'eaxDecayTime: $eaxDecayTime, '
        'eax2EnvironmentSize: $eax2EnvironmentSize, '
        'eax2EnvironmentDiffusion: $eax2EnvironmentDiffusion, '
        'eax2Room: $eax2Room, '
        'eax2RoomHf: $eax2RoomHf, '
        'eax2DecayHfRatio: $eax2DecayHfRatio, '
        'eax2Reflections: $eax2Reflections, '
        'eax2ReflectionsDelay: $eax2ReflectionsDelay, '
        'eax2Reverb: $eax2Reverb, '
        'eax2ReverbDelay: $eax2ReverbDelay, '
        'eax2RoomRolloff: $eax2RoomRolloff, '
        'eax2AirAbsorption: $eax2AirAbsorption, '
        'eax3RoomLf: $eax3RoomLf, '
        'eax3DecayLfRatio: $eax3DecayLfRatio, '
        'eax3EchoTime: $eax3EchoTime, '
        'eax3EchoDepth: $eax3EchoDepth, '
        'eax3ModulationTime: $eax3ModulationTime, '
        'eax3ModulationDepth: $eax3ModulationDepth, '
        'eax3HfReference: $eax3HfReference, '
        'eax3LfReference: $eax3LfReference'
        ')';
  }
}
