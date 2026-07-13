class DbcItemEntity {
  final Map<String, dynamic> values;

  DbcItemEntity.fromJson(Map<String, dynamic> json)
    : values = Map.unmodifiable(Map<String, dynamic>.from(json));

  int get id => values['ID'] ?? 0;
  int get inventoryType => values['InventoryType'] ?? 0;
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(values);
}

class BriefDbcItemEntity {
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

  factory BriefDbcItemEntity.fromJson(Map<String, dynamic> json) =>
      BriefDbcItemEntity(
        id: json['ID'] ?? 0,
        classId: json['ClassID'] ?? 0,
        subclassId: json['SubclassID'] ?? 0,
        displayInfoId: json['DisplayInfoID'] ?? 0,
        inventoryType: json['InventoryType'] ?? 0,
      );
}
