import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'game_object_display_info_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_game_object_display_info')
class GameObjectDisplayInfoEntity with _GameObjectDisplayInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ModelName')
  final String modelName;

  @FoxyFullField('Sound0')
  final int sound0;

  @FoxyFullField('Sound1')
  final int sound1;

  @FoxyFullField('Sound2')
  final int sound2;

  @FoxyFullField('Sound3')
  final int sound3;

  @FoxyFullField('Sound4')
  final int sound4;

  @FoxyFullField('Sound5')
  final int sound5;

  @FoxyFullField('Sound6')
  final int sound6;

  @FoxyFullField('Sound7')
  final int sound7;

  @FoxyFullField('Sound8')
  final int sound8;

  @FoxyFullField('Sound9')
  final int sound9;

  @FoxyFullField('GeoBoxMin0')
  final double geoBoxMin0;

  @FoxyFullField('GeoBoxMin1')
  final double geoBoxMin1;

  @FoxyFullField('GeoBoxMin2')
  final double geoBoxMin2;

  @FoxyFullField('GeoBoxMax0')
  final double geoBoxMax0;

  @FoxyFullField('GeoBoxMax1')
  final double geoBoxMax1;

  @FoxyFullField('GeoBoxMax2')
  final double geoBoxMax2;

  @FoxyFullField('ObjectEffectPackageID')
  final int objectEffectPackageId;

  const GameObjectDisplayInfoEntity({
    this.id = 0,
    this.modelName = '',
    this.sound0 = 0,
    this.sound1 = 0,
    this.sound2 = 0,
    this.sound3 = 0,
    this.sound4 = 0,
    this.sound5 = 0,
    this.sound6 = 0,
    this.sound7 = 0,
    this.sound8 = 0,
    this.sound9 = 0,
    this.geoBoxMin0 = 0,
    this.geoBoxMin1 = 0,
    this.geoBoxMin2 = 0,
    this.geoBoxMax0 = 0,
    this.geoBoxMax1 = 0,
    this.geoBoxMax2 = 0,
    this.objectEffectPackageId = 0,
  });

  factory GameObjectDisplayInfoEntity.fromJson(Map<String, dynamic> json) =>
      _GameObjectDisplayInfoEntityMixin.fromJson(json);
}
