// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_display_info_entity.dart';

mixin _ItemDisplayInfoEntityMixin {
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
    final self = this as ItemDisplayInfoEntity;
    return ItemDisplayInfoEntity(
      id: id ?? self.id,
      modelName0: modelName0 ?? self.modelName0,
      modelName1: modelName1 ?? self.modelName1,
      modelTexture0: modelTexture0 ?? self.modelTexture0,
      modelTexture1: modelTexture1 ?? self.modelTexture1,
      inventoryIcon0: inventoryIcon0 ?? self.inventoryIcon0,
      inventoryIcon1: inventoryIcon1 ?? self.inventoryIcon1,
      geosetGroup0: geosetGroup0 ?? self.geosetGroup0,
      geosetGroup1: geosetGroup1 ?? self.geosetGroup1,
      geosetGroup2: geosetGroup2 ?? self.geosetGroup2,
      flags: flags ?? self.flags,
      spellVisualId: spellVisualId ?? self.spellVisualId,
      groupSoundIndex: groupSoundIndex ?? self.groupSoundIndex,
      helmetGeosetVisId0: helmetGeosetVisId0 ?? self.helmetGeosetVisId0,
      helmetGeosetVisId1: helmetGeosetVisId1 ?? self.helmetGeosetVisId1,
      texture0: texture0 ?? self.texture0,
      texture1: texture1 ?? self.texture1,
      texture2: texture2 ?? self.texture2,
      texture3: texture3 ?? self.texture3,
      texture4: texture4 ?? self.texture4,
      texture5: texture5 ?? self.texture5,
      texture6: texture6 ?? self.texture6,
      texture7: texture7 ?? self.texture7,
      itemVisual: itemVisual ?? self.itemVisual,
      particleColorId: particleColorId ?? self.particleColorId,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ItemDisplayInfoEntity;
    return {
      'ID': self.id,
      'ModelName0': self.modelName0,
      'ModelName1': self.modelName1,
      'ModelTexture0': self.modelTexture0,
      'ModelTexture1': self.modelTexture1,
      'InventoryIcon0': self.inventoryIcon0,
      'InventoryIcon1': self.inventoryIcon1,
      'GeosetGroup0': self.geosetGroup0,
      'GeosetGroup1': self.geosetGroup1,
      'GeosetGroup2': self.geosetGroup2,
      'Flags': self.flags,
      'SpellVisualID': self.spellVisualId,
      'GroupSoundIndex': self.groupSoundIndex,
      'HelmetGeosetVisID0': self.helmetGeosetVisId0,
      'HelmetGeosetVisID1': self.helmetGeosetVisId1,
      'Texture0': self.texture0,
      'Texture1': self.texture1,
      'Texture2': self.texture2,
      'Texture3': self.texture3,
      'Texture4': self.texture4,
      'Texture5': self.texture5,
      'Texture6': self.texture6,
      'Texture7': self.texture7,
      'ItemVisual': self.itemVisual,
      'ParticleColorID': self.particleColorId,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as ItemDisplayInfoEntity;
    return identical(self, other) ||
        other is ItemDisplayInfoEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.modelName0 == other.modelName0 &&
            self.modelName1 == other.modelName1 &&
            self.modelTexture0 == other.modelTexture0 &&
            self.modelTexture1 == other.modelTexture1 &&
            self.inventoryIcon0 == other.inventoryIcon0 &&
            self.inventoryIcon1 == other.inventoryIcon1 &&
            self.geosetGroup0 == other.geosetGroup0 &&
            self.geosetGroup1 == other.geosetGroup1 &&
            self.geosetGroup2 == other.geosetGroup2 &&
            self.flags == other.flags &&
            self.spellVisualId == other.spellVisualId &&
            self.groupSoundIndex == other.groupSoundIndex &&
            self.helmetGeosetVisId0 == other.helmetGeosetVisId0 &&
            self.helmetGeosetVisId1 == other.helmetGeosetVisId1 &&
            self.texture0 == other.texture0 &&
            self.texture1 == other.texture1 &&
            self.texture2 == other.texture2 &&
            self.texture3 == other.texture3 &&
            self.texture4 == other.texture4 &&
            self.texture5 == other.texture5 &&
            self.texture6 == other.texture6 &&
            self.texture7 == other.texture7 &&
            self.itemVisual == other.itemVisual &&
            self.particleColorId == other.particleColorId;
  }

  @override
  int get hashCode {
    final self = this as ItemDisplayInfoEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.modelName0,
      self.modelName1,
      self.modelTexture0,
      self.modelTexture1,
      self.inventoryIcon0,
      self.inventoryIcon1,
      self.geosetGroup0,
      self.geosetGroup1,
      self.geosetGroup2,
      self.flags,
      self.spellVisualId,
      self.groupSoundIndex,
      self.helmetGeosetVisId0,
      self.helmetGeosetVisId1,
      self.texture0,
      self.texture1,
      self.texture2,
      self.texture3,
      self.texture4,
      self.texture5,
      self.texture6,
      self.texture7,
      self.itemVisual,
      self.particleColorId,
    ]);
  }

  @override
  String toString() {
    final self = this as ItemDisplayInfoEntity;
    return 'ItemDisplayInfoEntity('
        'id: ${self.id}, '
        'modelName0: ${self.modelName0}, '
        'modelName1: ${self.modelName1}, '
        'modelTexture0: ${self.modelTexture0}, '
        'modelTexture1: ${self.modelTexture1}, '
        'inventoryIcon0: ${self.inventoryIcon0}, '
        'inventoryIcon1: ${self.inventoryIcon1}, '
        'geosetGroup0: ${self.geosetGroup0}, '
        'geosetGroup1: ${self.geosetGroup1}, '
        'geosetGroup2: ${self.geosetGroup2}, '
        'flags: ${self.flags}, '
        'spellVisualId: ${self.spellVisualId}, '
        'groupSoundIndex: ${self.groupSoundIndex}, '
        'helmetGeosetVisId0: ${self.helmetGeosetVisId0}, '
        'helmetGeosetVisId1: ${self.helmetGeosetVisId1}, '
        'texture0: ${self.texture0}, '
        'texture1: ${self.texture1}, '
        'texture2: ${self.texture2}, '
        'texture3: ${self.texture3}, '
        'texture4: ${self.texture4}, '
        'texture5: ${self.texture5}, '
        'texture6: ${self.texture6}, '
        'texture7: ${self.texture7}, '
        'itemVisual: ${self.itemVisual}, '
        'particleColorId: ${self.particleColorId}'
        ')';
  }
}

final class BriefItemDisplayInfoEntity {
  final int id;
  final String modelName0;
  final String inventoryIcon0;

  const BriefItemDisplayInfoEntity({
    this.id = 0,
    this.modelName0 = '',
    this.inventoryIcon0 = '',
  });

  factory BriefItemDisplayInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemDisplayInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      modelName0: json['ModelName0']?.toString() ?? '',
      inventoryIcon0: json['InventoryIcon0']?.toString() ?? '',
    );
  }

  int get key => id;
}
