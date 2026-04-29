class ItemDisplayInfo {
  int id = 0;
  String modelName0 = '';
  String inventoryIcon0 = '';

  ItemDisplayInfo();

  factory ItemDisplayInfo.fromJson(Map<String, dynamic> json) {
    return ItemDisplayInfo()
      ..id = json['ID'] ?? 0
      ..modelName0 = json['ModelName0'] ?? ''
      ..inventoryIcon0 = json['InventoryIcon0'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ModelName0': modelName0,
      'InventoryIcon0': inventoryIcon0,
    };
  }
}
