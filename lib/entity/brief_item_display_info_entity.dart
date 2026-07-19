class BriefItemDisplayInfoEntity {
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
      id: json['ID'] ?? 0,
      modelName0: json['ModelName0'] ?? '',
      inventoryIcon0: json['InventoryIcon0'] ?? '',
    );
  }

  int get key => id;
}
