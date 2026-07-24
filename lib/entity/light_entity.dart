// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'light_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_light')
class LightEntity with _LightEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ContinentID')
  final int continentId;

  @FoxyBriefField()
  @FoxyFullField('GameCoords0')
  final double gameCoords0;

  @FoxyBriefField()
  @FoxyFullField('GameCoords1')
  final double gameCoords1;

  @FoxyBriefField()
  @FoxyFullField('GameCoords2')
  final double gameCoords2;

  @FoxyFullField('GameFalloffStart')
  final double gameFalloffStart;

  @FoxyFullField('GameFalloffEnd')
  final double gameFalloffEnd;

  @FoxyFullField('LightParamsID0')
  final int lightParamsId0;

  @FoxyFullField('LightParamsID1')
  final int lightParamsId1;

  @FoxyFullField('LightParamsID2')
  final int lightParamsId2;

  @FoxyFullField('LightParamsID3')
  final int lightParamsId3;

  @FoxyFullField('LightParamsID4')
  final int lightParamsId4;

  @FoxyFullField('LightParamsID5')
  final int lightParamsId5;

  @FoxyFullField('LightParamsID6')
  final int lightParamsId6;

  @FoxyFullField('LightParamsID7')
  final int lightParamsId7;

  const LightEntity({
    this.id = 0,
    this.continentId = 0,
    this.gameCoords0 = 0.0,
    this.gameCoords1 = 0.0,
    this.gameCoords2 = 0.0,
    this.gameFalloffStart = 0.0,
    this.gameFalloffEnd = 0.0,
    this.lightParamsId0 = 0,
    this.lightParamsId1 = 0,
    this.lightParamsId2 = 0,
    this.lightParamsId3 = 0,
    this.lightParamsId4 = 0,
    this.lightParamsId5 = 0,
    this.lightParamsId6 = 0,
    this.lightParamsId7 = 0,
  });

  factory LightEntity.fromJson(Map<String, dynamic> json) =>
      _LightEntityMixin.fromJson(json);
}
