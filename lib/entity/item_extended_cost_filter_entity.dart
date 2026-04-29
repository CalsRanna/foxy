class ItemExtendedCostFilterEntity {
  final String id;

  const ItemExtendedCostFilterEntity({this.id = ''});

  factory ItemExtendedCostFilterEntity.fromJson(Map<String, dynamic> json) {
    return ItemExtendedCostFilterEntity(
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
