class ItemDisplayInfoFilterEntity {
  final String id;
  final String name;

  const ItemDisplayInfoFilterEntity({this.id = '', this.name = ''});

  factory ItemDisplayInfoFilterEntity.fromJson(Map<String, dynamic> json) {
    return ItemDisplayInfoFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  ItemDisplayInfoFilterEntity copyWith({String? id, String? name}) {
    return ItemDisplayInfoFilterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
