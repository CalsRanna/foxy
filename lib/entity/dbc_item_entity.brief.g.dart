// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
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
