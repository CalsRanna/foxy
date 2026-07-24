// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'cinematic_sequence_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_cinematic_sequences')
class CinematicSequenceEntity with _CinematicSequenceEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('SoundID')
  final int soundId;

  @FoxyBriefField()
  @FoxyFullField('Camera0')
  final int camera0;

  @FoxyFullField('Camera1')
  final int camera1;

  @FoxyFullField('Camera2')
  final int camera2;

  @FoxyFullField('Camera3')
  final int camera3;

  @FoxyFullField('Camera4')
  final int camera4;

  @FoxyFullField('Camera5')
  final int camera5;

  @FoxyFullField('Camera6')
  final int camera6;

  @FoxyFullField('Camera7')
  final int camera7;

  const CinematicSequenceEntity({
    this.id = 0,
    this.soundId = 0,
    this.camera0 = 0,
    this.camera1 = 0,
    this.camera2 = 0,
    this.camera3 = 0,
    this.camera4 = 0,
    this.camera5 = 0,
    this.camera6 = 0,
    this.camera7 = 0,
  });

  factory CinematicSequenceEntity.fromJson(Map<String, dynamic> json) =>
      _CinematicSequenceEntityMixin.fromJson(json);
}
