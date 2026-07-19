class SoundProviderPreferencesEntity {
  final int id;
  final String description;
  final int flags;
  final int eaxEnvironmentSelection;
  final double eaxDecayTime;
  final double eax2EnvironmentSize;
  final double eax2EnvironmentDiffusion;
  final int eax2Room;
  final int eax2RoomHf;
  final double eax2DecayHfRatio;
  final int eax2Reflections;
  final double eax2ReflectionsDelay;
  final int eax2Reverb;
  final double eax2ReverbDelay;
  final double eax2RoomRolloff;
  final double eax2AirAbsorption;
  final int eax3RoomLf;
  final double eax3DecayLfRatio;
  final double eax3EchoTime;
  final double eax3EchoDepth;
  final double eax3ModulationTime;
  final double eax3ModulationDepth;
  final double eax3HfReference;
  final double eax3LfReference;

  const SoundProviderPreferencesEntity({
    this.id = 0,
    this.description = '',
    this.flags = 0,
    this.eaxEnvironmentSelection = 0,
    this.eaxDecayTime = 0.0,
    this.eax2EnvironmentSize = 0.0,
    this.eax2EnvironmentDiffusion = 0.0,
    this.eax2Room = 0,
    this.eax2RoomHf = 0,
    this.eax2DecayHfRatio = 0.0,
    this.eax2Reflections = 0,
    this.eax2ReflectionsDelay = 0.0,
    this.eax2Reverb = 0,
    this.eax2ReverbDelay = 0.0,
    this.eax2RoomRolloff = 0.0,
    this.eax2AirAbsorption = 0.0,
    this.eax3RoomLf = 0,
    this.eax3DecayLfRatio = 0.0,
    this.eax3EchoTime = 0.0,
    this.eax3EchoDepth = 0.0,
    this.eax3ModulationTime = 0.0,
    this.eax3ModulationDepth = 0.0,
    this.eax3HfReference = 0.0,
    this.eax3LfReference = 0.0,
  });

  factory SoundProviderPreferencesEntity.fromJson(
    Map<String, dynamic> json,
  ) => SoundProviderPreferencesEntity(
    id: json['ID'] ?? 0,
    description: json['Description'] ?? '',
    flags: json['Flags'] ?? 0,
    eaxEnvironmentSelection: json['EAXEnvironmentSelection'] ?? 0,
    eaxDecayTime: (json['EAXDecayTime'] as num?)?.toDouble() ?? 0.0,
    eax2EnvironmentSize:
        (json['EAX2EnvironmentSize'] as num?)?.toDouble() ?? 0.0,
    eax2EnvironmentDiffusion:
        (json['EAX2EnvironmentDiffusion'] as num?)?.toDouble() ?? 0.0,
    eax2Room: json['EAX2Room'] ?? 0,
    eax2RoomHf: json['EAX2RoomHF'] ?? 0,
    eax2DecayHfRatio: (json['EAX2DecayHFRatio'] as num?)?.toDouble() ?? 0.0,
    eax2Reflections: json['EAX2Reflections'] ?? 0,
    eax2ReflectionsDelay:
        (json['EAX2ReflectionsDelay'] as num?)?.toDouble() ?? 0.0,
    eax2Reverb: json['EAX2Reverb'] ?? 0,
    eax2ReverbDelay: (json['EAX2ReverbDelay'] as num?)?.toDouble() ?? 0.0,
    eax2RoomRolloff: (json['EAX2RoomRolloff'] as num?)?.toDouble() ?? 0.0,
    eax2AirAbsorption: (json['EAX2AirAbsorption'] as num?)?.toDouble() ?? 0.0,
    eax3RoomLf: json['EAX3RoomLF'] ?? 0,
    eax3DecayLfRatio: (json['EAX3DecayLFRatio'] as num?)?.toDouble() ?? 0.0,
    eax3EchoTime: (json['EAX3EchoTime'] as num?)?.toDouble() ?? 0.0,
    eax3EchoDepth: (json['EAX3EchoDepth'] as num?)?.toDouble() ?? 0.0,
    eax3ModulationTime: (json['EAX3ModulationTime'] as num?)?.toDouble() ?? 0.0,
    eax3ModulationDepth:
        (json['EAX3ModulationDepth'] as num?)?.toDouble() ?? 0.0,
    eax3HfReference: (json['EAX3HFReference'] as num?)?.toDouble() ?? 0.0,
    eax3LfReference: (json['EAX3LFReference'] as num?)?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
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
