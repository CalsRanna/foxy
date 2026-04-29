class ItemDisplayInfo {
  final int id;
  final String modelName0;
  final String inventoryIcon0;

  const ItemDisplayInfo({
    this.id = 0,
    this.modelName0 = '',
    this.inventoryIcon0 = '',
  });

  factory ItemDisplayInfo.fromJson(Map<String, dynamic> json) {
    return ItemDisplayInfo(
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
}
