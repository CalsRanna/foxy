// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_provider_preferences_entity.dart';

mixin _SoundProviderPreferencesEntityMixin {
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
    final self = this as SoundProviderPreferencesEntity;
    return SoundProviderPreferencesEntity(
      id: id ?? self.id,
      description: description ?? self.description,
      flags: flags ?? self.flags,
      eaxEnvironmentSelection:
          eaxEnvironmentSelection ?? self.eaxEnvironmentSelection,
      eaxDecayTime: eaxDecayTime ?? self.eaxDecayTime,
      eax2EnvironmentSize: eax2EnvironmentSize ?? self.eax2EnvironmentSize,
      eax2EnvironmentDiffusion:
          eax2EnvironmentDiffusion ?? self.eax2EnvironmentDiffusion,
      eax2Room: eax2Room ?? self.eax2Room,
      eax2RoomHf: eax2RoomHf ?? self.eax2RoomHf,
      eax2DecayHfRatio: eax2DecayHfRatio ?? self.eax2DecayHfRatio,
      eax2Reflections: eax2Reflections ?? self.eax2Reflections,
      eax2ReflectionsDelay: eax2ReflectionsDelay ?? self.eax2ReflectionsDelay,
      eax2Reverb: eax2Reverb ?? self.eax2Reverb,
      eax2ReverbDelay: eax2ReverbDelay ?? self.eax2ReverbDelay,
      eax2RoomRolloff: eax2RoomRolloff ?? self.eax2RoomRolloff,
      eax2AirAbsorption: eax2AirAbsorption ?? self.eax2AirAbsorption,
      eax3RoomLf: eax3RoomLf ?? self.eax3RoomLf,
      eax3DecayLfRatio: eax3DecayLfRatio ?? self.eax3DecayLfRatio,
      eax3EchoTime: eax3EchoTime ?? self.eax3EchoTime,
      eax3EchoDepth: eax3EchoDepth ?? self.eax3EchoDepth,
      eax3ModulationTime: eax3ModulationTime ?? self.eax3ModulationTime,
      eax3ModulationDepth: eax3ModulationDepth ?? self.eax3ModulationDepth,
      eax3HfReference: eax3HfReference ?? self.eax3HfReference,
      eax3LfReference: eax3LfReference ?? self.eax3LfReference,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SoundProviderPreferencesEntity;
    return {
      'ID': self.id,
      'Description': self.description,
      'Flags': self.flags,
      'EAXEnvironmentSelection': self.eaxEnvironmentSelection,
      'EAXDecayTime': self.eaxDecayTime,
      'EAX2EnvironmentSize': self.eax2EnvironmentSize,
      'EAX2EnvironmentDiffusion': self.eax2EnvironmentDiffusion,
      'EAX2Room': self.eax2Room,
      'EAX2RoomHF': self.eax2RoomHf,
      'EAX2DecayHFRatio': self.eax2DecayHfRatio,
      'EAX2Reflections': self.eax2Reflections,
      'EAX2ReflectionsDelay': self.eax2ReflectionsDelay,
      'EAX2Reverb': self.eax2Reverb,
      'EAX2ReverbDelay': self.eax2ReverbDelay,
      'EAX2RoomRolloff': self.eax2RoomRolloff,
      'EAX2AirAbsorption': self.eax2AirAbsorption,
      'EAX3RoomLF': self.eax3RoomLf,
      'EAX3DecayLFRatio': self.eax3DecayLfRatio,
      'EAX3EchoTime': self.eax3EchoTime,
      'EAX3EchoDepth': self.eax3EchoDepth,
      'EAX3ModulationTime': self.eax3ModulationTime,
      'EAX3ModulationDepth': self.eax3ModulationDepth,
      'EAX3HFReference': self.eax3HfReference,
      'EAX3LFReference': self.eax3LfReference,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SoundProviderPreferencesEntity;
    return identical(self, other) ||
        other is SoundProviderPreferencesEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.description == other.description &&
            self.flags == other.flags &&
            self.eaxEnvironmentSelection == other.eaxEnvironmentSelection &&
            self.eaxDecayTime == other.eaxDecayTime &&
            self.eax2EnvironmentSize == other.eax2EnvironmentSize &&
            self.eax2EnvironmentDiffusion == other.eax2EnvironmentDiffusion &&
            self.eax2Room == other.eax2Room &&
            self.eax2RoomHf == other.eax2RoomHf &&
            self.eax2DecayHfRatio == other.eax2DecayHfRatio &&
            self.eax2Reflections == other.eax2Reflections &&
            self.eax2ReflectionsDelay == other.eax2ReflectionsDelay &&
            self.eax2Reverb == other.eax2Reverb &&
            self.eax2ReverbDelay == other.eax2ReverbDelay &&
            self.eax2RoomRolloff == other.eax2RoomRolloff &&
            self.eax2AirAbsorption == other.eax2AirAbsorption &&
            self.eax3RoomLf == other.eax3RoomLf &&
            self.eax3DecayLfRatio == other.eax3DecayLfRatio &&
            self.eax3EchoTime == other.eax3EchoTime &&
            self.eax3EchoDepth == other.eax3EchoDepth &&
            self.eax3ModulationTime == other.eax3ModulationTime &&
            self.eax3ModulationDepth == other.eax3ModulationDepth &&
            self.eax3HfReference == other.eax3HfReference &&
            self.eax3LfReference == other.eax3LfReference;
  }

  @override
  int get hashCode {
    final self = this as SoundProviderPreferencesEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.description,
      self.flags,
      self.eaxEnvironmentSelection,
      self.eaxDecayTime,
      self.eax2EnvironmentSize,
      self.eax2EnvironmentDiffusion,
      self.eax2Room,
      self.eax2RoomHf,
      self.eax2DecayHfRatio,
      self.eax2Reflections,
      self.eax2ReflectionsDelay,
      self.eax2Reverb,
      self.eax2ReverbDelay,
      self.eax2RoomRolloff,
      self.eax2AirAbsorption,
      self.eax3RoomLf,
      self.eax3DecayLfRatio,
      self.eax3EchoTime,
      self.eax3EchoDepth,
      self.eax3ModulationTime,
      self.eax3ModulationDepth,
      self.eax3HfReference,
      self.eax3LfReference,
    ]);
  }

  @override
  String toString() {
    final self = this as SoundProviderPreferencesEntity;
    return 'SoundProviderPreferencesEntity('
        'id: ${self.id}, '
        'description: ${self.description}, '
        'flags: ${self.flags}, '
        'eaxEnvironmentSelection: ${self.eaxEnvironmentSelection}, '
        'eaxDecayTime: ${self.eaxDecayTime}, '
        'eax2EnvironmentSize: ${self.eax2EnvironmentSize}, '
        'eax2EnvironmentDiffusion: ${self.eax2EnvironmentDiffusion}, '
        'eax2Room: ${self.eax2Room}, '
        'eax2RoomHf: ${self.eax2RoomHf}, '
        'eax2DecayHfRatio: ${self.eax2DecayHfRatio}, '
        'eax2Reflections: ${self.eax2Reflections}, '
        'eax2ReflectionsDelay: ${self.eax2ReflectionsDelay}, '
        'eax2Reverb: ${self.eax2Reverb}, '
        'eax2ReverbDelay: ${self.eax2ReverbDelay}, '
        'eax2RoomRolloff: ${self.eax2RoomRolloff}, '
        'eax2AirAbsorption: ${self.eax2AirAbsorption}, '
        'eax3RoomLf: ${self.eax3RoomLf}, '
        'eax3DecayLfRatio: ${self.eax3DecayLfRatio}, '
        'eax3EchoTime: ${self.eax3EchoTime}, '
        'eax3EchoDepth: ${self.eax3EchoDepth}, '
        'eax3ModulationTime: ${self.eax3ModulationTime}, '
        'eax3ModulationDepth: ${self.eax3ModulationDepth}, '
        'eax3HfReference: ${self.eax3HfReference}, '
        'eax3LfReference: ${self.eax3LfReference}'
        ')';
  }
}
