class ItemExtendedCostFilterEntity {
  String id = '';

  ItemExtendedCostFilterEntity();

  factory ItemExtendedCostFilterEntity.fromJson(Map<String, dynamic> json) {
    return ItemExtendedCostFilterEntity()
      ..id = json['id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
