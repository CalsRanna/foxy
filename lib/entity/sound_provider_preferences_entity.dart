import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'sound_provider_preferences_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_sound_provider_preferences')
class SoundProviderPreferencesEntity with _SoundProviderPreferencesEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Description')
  final String description;

  @FoxyBriefField()
  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('EAXEnvironmentSelection')
  final int eaxEnvironmentSelection;

  @FoxyFullField('EAXDecayTime')
  final double eaxDecayTime;

  @FoxyFullField('EAX2EnvironmentSize')
  final double eax2EnvironmentSize;

  @FoxyFullField('EAX2EnvironmentDiffusion')
  final double eax2EnvironmentDiffusion;

  @FoxyFullField('EAX2Room')
  final int eax2Room;

  @FoxyFullField('EAX2RoomHF')
  final int eax2RoomHf;

  @FoxyFullField('EAX2DecayHFRatio')
  final double eax2DecayHfRatio;

  @FoxyFullField('EAX2Reflections')
  final int eax2Reflections;

  @FoxyFullField('EAX2ReflectionsDelay')
  final double eax2ReflectionsDelay;

  @FoxyFullField('EAX2Reverb')
  final int eax2Reverb;

  @FoxyFullField('EAX2ReverbDelay')
  final double eax2ReverbDelay;

  @FoxyFullField('EAX2RoomRolloff')
  final double eax2RoomRolloff;

  @FoxyFullField('EAX2AirAbsorption')
  final double eax2AirAbsorption;

  @FoxyFullField('EAX3RoomLF')
  final int eax3RoomLf;

  @FoxyFullField('EAX3DecayLFRatio')
  final double eax3DecayLfRatio;

  @FoxyFullField('EAX3EchoTime')
  final double eax3EchoTime;

  @FoxyFullField('EAX3EchoDepth')
  final double eax3EchoDepth;

  @FoxyFullField('EAX3ModulationTime')
  final double eax3ModulationTime;

  @FoxyFullField('EAX3ModulationDepth')
  final double eax3ModulationDepth;

  @FoxyFullField('EAX3HFReference')
  final double eax3HfReference;

  @FoxyFullField('EAX3LFReference')
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

  factory SoundProviderPreferencesEntity.fromJson(Map<String, dynamic> json) =>
      _SoundProviderPreferencesEntityMixin.fromJson(json);
}
