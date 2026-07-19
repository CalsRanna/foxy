class ItemDisplayInfoEntity {
  final int id;
  final String modelName0;
  final String modelName1;
  final String modelTexture0;
  final String modelTexture1;
  final String inventoryIcon0;
  final String inventoryIcon1;
  final int geosetGroup0;
  final int geosetGroup1;
  final int geosetGroup2;
  final int flags;
  final int spellVisualId;
  final int groupSoundIndex;
  final int helmetGeosetVisId0;
  final int helmetGeosetVisId1;
  final String texture0;
  final String texture1;
  final String texture2;
  final String texture3;
  final String texture4;
  final String texture5;
  final String texture6;
  final String texture7;
  final int itemVisual;
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

  factory ItemDisplayInfoEntity.fromJson(Map<String, dynamic> json) {
    return ItemDisplayInfoEntity(
      id: json['ID'] ?? 0,
      modelName0: json['ModelName0'] ?? '',
      modelName1: json['ModelName1'] ?? '',
      modelTexture0: json['ModelTexture0'] ?? '',
      modelTexture1: json['ModelTexture1'] ?? '',
      inventoryIcon0: json['InventoryIcon0'] ?? '',
      inventoryIcon1: json['InventoryIcon1'] ?? '',
      geosetGroup0: json['GeosetGroup0'] ?? 0,
      geosetGroup1: json['GeosetGroup1'] ?? 0,
      geosetGroup2: json['GeosetGroup2'] ?? 0,
      flags: json['Flags'] ?? 0,
      spellVisualId: json['SpellVisualID'] ?? 0,
      groupSoundIndex: json['GroupSoundIndex'] ?? 0,
      helmetGeosetVisId0: json['HelmetGeosetVisID0'] ?? 0,
      helmetGeosetVisId1: json['HelmetGeosetVisID1'] ?? 0,
      texture0: json['Texture0'] ?? '',
      texture1: json['Texture1'] ?? '',
      texture2: json['Texture2'] ?? '',
      texture3: json['Texture3'] ?? '',
      texture4: json['Texture4'] ?? '',
      texture5: json['Texture5'] ?? '',
      texture6: json['Texture6'] ?? '',
      texture7: json['Texture7'] ?? '',
      itemVisual: json['ItemVisual'] ?? 0,
      particleColorId: json['ParticleColorID'] ?? 0,
    );
  }

  ItemDisplayInfoEntity copyWith({
    int? id,
    String? modelName0,
    String? modelName1,
    String? modelTexture0,
    String? modelTexture1,
    String? inventoryIcon0,
    String? inventoryIcon1,
    int? geosetGroup0,
    int? geosetGroup1,
    int? geosetGroup2,
    int? flags,
    int? spellVisualId,
    int? groupSoundIndex,
    int? helmetGeosetVisId0,
    int? helmetGeosetVisId1,
    String? texture0,
    String? texture1,
    String? texture2,
    String? texture3,
    String? texture4,
    String? texture5,
    String? texture6,
    String? texture7,
    int? itemVisual,
    int? particleColorId,
  }) {
    return ItemDisplayInfoEntity(
      id: id ?? this.id,
      modelName0: modelName0 ?? this.modelName0,
      modelName1: modelName1 ?? this.modelName1,
      modelTexture0: modelTexture0 ?? this.modelTexture0,
      modelTexture1: modelTexture1 ?? this.modelTexture1,
      inventoryIcon0: inventoryIcon0 ?? this.inventoryIcon0,
      inventoryIcon1: inventoryIcon1 ?? this.inventoryIcon1,
      geosetGroup0: geosetGroup0 ?? this.geosetGroup0,
      geosetGroup1: geosetGroup1 ?? this.geosetGroup1,
      geosetGroup2: geosetGroup2 ?? this.geosetGroup2,
      flags: flags ?? this.flags,
      spellVisualId: spellVisualId ?? this.spellVisualId,
      groupSoundIndex: groupSoundIndex ?? this.groupSoundIndex,
      helmetGeosetVisId0: helmetGeosetVisId0 ?? this.helmetGeosetVisId0,
      helmetGeosetVisId1: helmetGeosetVisId1 ?? this.helmetGeosetVisId1,
      texture0: texture0 ?? this.texture0,
      texture1: texture1 ?? this.texture1,
      texture2: texture2 ?? this.texture2,
      texture3: texture3 ?? this.texture3,
      texture4: texture4 ?? this.texture4,
      texture5: texture5 ?? this.texture5,
      texture6: texture6 ?? this.texture6,
      texture7: texture7 ?? this.texture7,
      itemVisual: itemVisual ?? this.itemVisual,
      particleColorId: particleColorId ?? this.particleColorId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ModelName0': modelName0,
      'ModelName1': modelName1,
      'ModelTexture0': modelTexture0,
      'ModelTexture1': modelTexture1,
      'InventoryIcon0': inventoryIcon0,
      'InventoryIcon1': inventoryIcon1,
      'GeosetGroup0': geosetGroup0,
      'GeosetGroup1': geosetGroup1,
      'GeosetGroup2': geosetGroup2,
      'Flags': flags,
      'SpellVisualID': spellVisualId,
      'GroupSoundIndex': groupSoundIndex,
      'HelmetGeosetVisID0': helmetGeosetVisId0,
      'HelmetGeosetVisID1': helmetGeosetVisId1,
      'Texture0': texture0,
      'Texture1': texture1,
      'Texture2': texture2,
      'Texture3': texture3,
      'Texture4': texture4,
      'Texture5': texture5,
      'Texture6': texture6,
      'Texture7': texture7,
      'ItemVisual': itemVisual,
      'ParticleColorID': particleColorId,
    };
  }
}
