// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_item_entity.dart';

mixin _DbcItemEntityMixin {
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
    final self = this as DbcItemEntity;
    return DbcItemEntity(
      id: id ?? self.id,
      classId: classId ?? self.classId,
      subclassId: subclassId ?? self.subclassId,
      soundOverrideSubclassId:
          soundOverrideSubclassId ?? self.soundOverrideSubclassId,
      material: material ?? self.material,
      displayInfoId: displayInfoId ?? self.displayInfoId,
      inventoryType: inventoryType ?? self.inventoryType,
      sheatheType: sheatheType ?? self.sheatheType,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as DbcItemEntity;
    return {
      'ID': self.id,
      'ClassID': self.classId,
      'SubclassID': self.subclassId,
      'Sound_override_subclassID': self.soundOverrideSubclassId,
      'Material': self.material,
      'DisplayInfoID': self.displayInfoId,
      'InventoryType': self.inventoryType,
      'SheatheType': self.sheatheType,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as DbcItemEntity;
    return identical(self, other) ||
        other is DbcItemEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.classId == other.classId &&
            self.subclassId == other.subclassId &&
            self.soundOverrideSubclassId == other.soundOverrideSubclassId &&
            self.material == other.material &&
            self.displayInfoId == other.displayInfoId &&
            self.inventoryType == other.inventoryType &&
            self.sheatheType == other.sheatheType;
  }

  @override
  int get hashCode {
    final self = this as DbcItemEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.classId,
      self.subclassId,
      self.soundOverrideSubclassId,
      self.material,
      self.displayInfoId,
      self.inventoryType,
      self.sheatheType,
    ]);
  }

  @override
  String toString() {
    final self = this as DbcItemEntity;
    return 'DbcItemEntity('
        'id: ${self.id}, '
        'classId: ${self.classId}, '
        'subclassId: ${self.subclassId}, '
        'soundOverrideSubclassId: ${self.soundOverrideSubclassId}, '
        'material: ${self.material}, '
        'displayInfoId: ${self.displayInfoId}, '
        'inventoryType: ${self.inventoryType}, '
        'sheatheType: ${self.sheatheType}'
        ')';
  }
}

final class BriefDbcItemEntity {
  final int id;
  final int classId;
  final int subclassId;
  final int displayInfoId;
  final int inventoryType;

  const BriefDbcItemEntity({
    this.id = 0,
    this.classId = 0,
    this.subclassId = 0,
    this.displayInfoId = 0,
    this.inventoryType = 0,
  });

  factory BriefDbcItemEntity.fromJson(Map<String, dynamic> json) {
    return BriefDbcItemEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      classId: (json['ClassID'] as num?)?.toInt() ?? 0,
      subclassId: (json['SubclassID'] as num?)?.toInt() ?? 0,
      displayInfoId: (json['DisplayInfoID'] as num?)?.toInt() ?? 0,
      inventoryType: (json['InventoryType'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
