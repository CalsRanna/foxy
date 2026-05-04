class ItemDisplayInfoEntity {
  final int id;
  final String modelName0;
  final String inventoryIcon0;

  const ItemDisplayInfoEntity({
    this.id = 0,
    this.modelName0 = '',
    this.inventoryIcon0 = '',
  });

  factory ItemDisplayInfoEntity.fromJson(Map<String, dynamic> json) {
    return ItemDisplayInfoEntity(
      id: json['ID'] ?? 0,
      modelName0: json['ModelName0'] ?? '',
      inventoryIcon0: json['InventoryIcon0'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ModelName0': modelName0,
      'InventoryIcon0': inventoryIcon0,
    };
  }

  ItemDisplayInfoEntity copyWith({
    int? id,
    String? modelName0,
    String? inventoryIcon0,
  }) {
    return ItemDisplayInfoEntity(
      id: id ?? this.id,
      modelName0: modelName0 ?? this.modelName0,
      inventoryIcon0: inventoryIcon0 ?? this.inventoryIcon0,
    );
  }
}
