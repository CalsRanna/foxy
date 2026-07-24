// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_item_entity.dart';

mixin _DbcItemEntityMixin {
  int get id;
  int get classId;
  int get subclassId;
  int get soundOverrideSubclassId;
  int get material;
  int get displayInfoId;
  int get inventoryType;
  int get sheatheType;

  static DbcItemEntity fromJson(Map<String, dynamic> json) {
    return DbcItemEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      classId: (json['ClassID'] as num?)?.toInt() ?? 0,
      subclassId: (json['SubclassID'] as num?)?.toInt() ?? 0,
      soundOverrideSubclassId:
          (json['Sound_override_subclassID'] as num?)?.toInt() ?? 0,
      material: (json['Material'] as num?)?.toInt() ?? 0,
      displayInfoId: (json['DisplayInfoID'] as num?)?.toInt() ?? 0,
      inventoryType: (json['InventoryType'] as num?)?.toInt() ?? 0,
      sheatheType: (json['SheatheType'] as num?)?.toInt() ?? 0,
    );
  }

  DbcItemEntity copyWith({
    int? id,
    int? classId,
    int? subclassId,
    int? soundOverrideSubclassId,
    int? material,
    int? displayInfoId,
    int? inventoryType,
    int? sheatheType,
  }) {
    return DbcItemEntity(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      subclassId: subclassId ?? this.subclassId,
      soundOverrideSubclassId:
          soundOverrideSubclassId ?? this.soundOverrideSubclassId,
      material: material ?? this.material,
      displayInfoId: displayInfoId ?? this.displayInfoId,
      inventoryType: inventoryType ?? this.inventoryType,
      sheatheType: sheatheType ?? this.sheatheType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ClassID': classId,
      'SubclassID': subclassId,
      'Sound_override_subclassID': soundOverrideSubclassId,
      'Material': material,
      'DisplayInfoID': displayInfoId,
      'InventoryType': inventoryType,
      'SheatheType': sheatheType,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DbcItemEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            classId == other.classId &&
            subclassId == other.subclassId &&
            soundOverrideSubclassId == other.soundOverrideSubclassId &&
            material == other.material &&
            displayInfoId == other.displayInfoId &&
            inventoryType == other.inventoryType &&
            sheatheType == other.sheatheType;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      classId,
      subclassId,
      soundOverrideSubclassId,
      material,
      displayInfoId,
      inventoryType,
      sheatheType,
    ]);
  }

  @override
  String toString() {
    return 'DbcItemEntity('
        'id: $id, '
        'classId: $classId, '
        'subclassId: $subclassId, '
        'soundOverrideSubclassId: $soundOverrideSubclassId, '
        'material: $material, '
        'displayInfoId: $displayInfoId, '
        'inventoryType: $inventoryType, '
        'sheatheType: $sheatheType'
        ')';
  }
}
