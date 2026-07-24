import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'item_display_info_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_item_display_info')
class ItemDisplayInfoEntity with _ItemDisplayInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('ModelName0')
  final String modelName0;

  @FoxyFullField('ModelName1')
  final String modelName1;

  @FoxyFullField('ModelTexture0')
  final String modelTexture0;

  @FoxyFullField('ModelTexture1')
  final String modelTexture1;

  @FoxyBriefField()
  @FoxyFullField('InventoryIcon0')
  final String inventoryIcon0;

  @FoxyFullField('InventoryIcon1')
  final String inventoryIcon1;

  @FoxyFullField('GeosetGroup0')
  final int geosetGroup0;

  @FoxyFullField('GeosetGroup1')
  final int geosetGroup1;

  @FoxyFullField('GeosetGroup2')
  final int geosetGroup2;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('SpellVisualID')
  final int spellVisualId;

  @FoxyFullField('GroupSoundIndex')
  final int groupSoundIndex;

  @FoxyFullField('HelmetGeosetVisID0')
  final int helmetGeosetVisId0;

  @FoxyFullField('HelmetGeosetVisID1')
  final int helmetGeosetVisId1;

  @FoxyFullField('Texture0')
  final String texture0;

  @FoxyFullField('Texture1')
  final String texture1;

  @FoxyFullField('Texture2')
  final String texture2;

  @FoxyFullField('Texture3')
  final String texture3;

  @FoxyFullField('Texture4')
  final String texture4;

  @FoxyFullField('Texture5')
  final String texture5;

  @FoxyFullField('Texture6')
  final String texture6;

  @FoxyFullField('Texture7')
  final String texture7;

  @FoxyFullField('ItemVisual')
  final int itemVisual;

  @FoxyFullField('ParticleColorID')
  final int particleColorId;

  const ItemDisplayInfoEntity({
    this.id = 0,
    this.modelName0 = '',
    this.modelName1 = '',
    this.modelTexture0 = '',
    this.modelTexture1 = '',
    this.inventoryIcon0 = '',
    this.inventoryIcon1 = '',
    this.geosetGroup0 = 0,
    this.geosetGroup1 = 0,
    this.geosetGroup2 = 0,
    this.flags = 0,
    this.spellVisualId = 0,
    this.groupSoundIndex = 0,
    this.helmetGeosetVisId0 = 0,
    this.helmetGeosetVisId1 = 0,
    this.texture0 = '',
    this.texture1 = '',
    this.texture2 = '',
    this.texture3 = '',
    this.texture4 = '',
    this.texture5 = '',
    this.texture6 = '',
    this.texture7 = '',
    this.itemVisual = 0,
    this.particleColorId = 0,
  });

  factory ItemDisplayInfoEntity.fromJson(Map<String, dynamic> json) =>
      _ItemDisplayInfoEntityMixin.fromJson(json);
}
