// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
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
