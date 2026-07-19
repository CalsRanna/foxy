class DbcItemEntity {
  final int id;
  final int classId;
  final int subclassId;
  final int soundOverrideSubclassId;
  final int material;
  final int displayInfoId;
  final int inventoryType;
  final int sheatheType;

  const DbcItemEntity({
    this.id = 0,
    this.classId = 0,
    this.subclassId = 0,
    this.soundOverrideSubclassId = 0,
    this.material = 0,
    this.displayInfoId = 0,
    this.inventoryType = 0,
    this.sheatheType = 0,
  });

  factory DbcItemEntity.fromJson(Map<String, dynamic> json) {
    return DbcItemEntity(
      id: json['ID'] ?? 0,
      classId: json['ClassID'] ?? 0,
      subclassId: json['SubclassID'] ?? 0,
      soundOverrideSubclassId: json['Sound_override_subclassID'] ?? 0,
      material: json['Material'] ?? 0,
      displayInfoId: json['DisplayInfoID'] ?? 0,
      inventoryType: json['InventoryType'] ?? 0,
      sheatheType: json['SheatheType'] ?? 0,
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

  Map<String, dynamic> toJson() => {
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
