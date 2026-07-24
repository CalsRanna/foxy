// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_display_info_entity.dart';

mixin _ItemDisplayInfoEntityMixin {
  int get id;
  String get modelName0;
  String get modelName1;
  String get modelTexture0;
  String get modelTexture1;
  String get inventoryIcon0;
  String get inventoryIcon1;
  int get geosetGroup0;
  int get geosetGroup1;
  int get geosetGroup2;
  int get flags;
  int get spellVisualId;
  int get groupSoundIndex;
  int get helmetGeosetVisId0;
  int get helmetGeosetVisId1;
  String get texture0;
  String get texture1;
  String get texture2;
  String get texture3;
  String get texture4;
  String get texture5;
  String get texture6;
  String get texture7;
  int get itemVisual;
  int get particleColorId;

  static ItemDisplayInfoEntity fromJson(Map<String, dynamic> json) {
    return ItemDisplayInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      modelName0: json['ModelName0']?.toString() ?? '',
      modelName1: json['ModelName1']?.toString() ?? '',
      modelTexture0: json['ModelTexture0']?.toString() ?? '',
      modelTexture1: json['ModelTexture1']?.toString() ?? '',
      inventoryIcon0: json['InventoryIcon0']?.toString() ?? '',
      inventoryIcon1: json['InventoryIcon1']?.toString() ?? '',
      geosetGroup0: (json['GeosetGroup0'] as num?)?.toInt() ?? 0,
      geosetGroup1: (json['GeosetGroup1'] as num?)?.toInt() ?? 0,
      geosetGroup2: (json['GeosetGroup2'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      spellVisualId: (json['SpellVisualID'] as num?)?.toInt() ?? 0,
      groupSoundIndex: (json['GroupSoundIndex'] as num?)?.toInt() ?? 0,
      helmetGeosetVisId0: (json['HelmetGeosetVisID0'] as num?)?.toInt() ?? 0,
      helmetGeosetVisId1: (json['HelmetGeosetVisID1'] as num?)?.toInt() ?? 0,
      texture0: json['Texture0']?.toString() ?? '',
      texture1: json['Texture1']?.toString() ?? '',
      texture2: json['Texture2']?.toString() ?? '',
      texture3: json['Texture3']?.toString() ?? '',
      texture4: json['Texture4']?.toString() ?? '',
      texture5: json['Texture5']?.toString() ?? '',
      texture6: json['Texture6']?.toString() ?? '',
      texture7: json['Texture7']?.toString() ?? '',
      itemVisual: (json['ItemVisual'] as num?)?.toInt() ?? 0,
      particleColorId: (json['ParticleColorID'] as num?)?.toInt() ?? 0,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemDisplayInfoEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            modelName0 == other.modelName0 &&
            modelName1 == other.modelName1 &&
            modelTexture0 == other.modelTexture0 &&
            modelTexture1 == other.modelTexture1 &&
            inventoryIcon0 == other.inventoryIcon0 &&
            inventoryIcon1 == other.inventoryIcon1 &&
            geosetGroup0 == other.geosetGroup0 &&
            geosetGroup1 == other.geosetGroup1 &&
            geosetGroup2 == other.geosetGroup2 &&
            flags == other.flags &&
            spellVisualId == other.spellVisualId &&
            groupSoundIndex == other.groupSoundIndex &&
            helmetGeosetVisId0 == other.helmetGeosetVisId0 &&
            helmetGeosetVisId1 == other.helmetGeosetVisId1 &&
            texture0 == other.texture0 &&
            texture1 == other.texture1 &&
            texture2 == other.texture2 &&
            texture3 == other.texture3 &&
            texture4 == other.texture4 &&
            texture5 == other.texture5 &&
            texture6 == other.texture6 &&
            texture7 == other.texture7 &&
            itemVisual == other.itemVisual &&
            particleColorId == other.particleColorId;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      modelName0,
      modelName1,
      modelTexture0,
      modelTexture1,
      inventoryIcon0,
      inventoryIcon1,
      geosetGroup0,
      geosetGroup1,
      geosetGroup2,
      flags,
      spellVisualId,
      groupSoundIndex,
      helmetGeosetVisId0,
      helmetGeosetVisId1,
      texture0,
      texture1,
      texture2,
      texture3,
      texture4,
      texture5,
      texture6,
      texture7,
      itemVisual,
      particleColorId,
    ]);
  }

  @override
  String toString() {
    return 'ItemDisplayInfoEntity('
        'id: $id, '
        'modelName0: $modelName0, '
        'modelName1: $modelName1, '
        'modelTexture0: $modelTexture0, '
        'modelTexture1: $modelTexture1, '
        'inventoryIcon0: $inventoryIcon0, '
        'inventoryIcon1: $inventoryIcon1, '
        'geosetGroup0: $geosetGroup0, '
        'geosetGroup1: $geosetGroup1, '
        'geosetGroup2: $geosetGroup2, '
        'flags: $flags, '
        'spellVisualId: $spellVisualId, '
        'groupSoundIndex: $groupSoundIndex, '
        'helmetGeosetVisId0: $helmetGeosetVisId0, '
        'helmetGeosetVisId1: $helmetGeosetVisId1, '
        'texture0: $texture0, '
        'texture1: $texture1, '
        'texture2: $texture2, '
        'texture3: $texture3, '
        'texture4: $texture4, '
        'texture5: $texture5, '
        'texture6: $texture6, '
        'texture7: $texture7, '
        'itemVisual: $itemVisual, '
        'particleColorId: $particleColorId'
        ')';
  }
}
