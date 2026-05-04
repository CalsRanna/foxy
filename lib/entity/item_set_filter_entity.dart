class ItemSetFilterEntity {
  final String id;
  final String name;

  const ItemSetFilterEntity({this.id = '', this.name = ''});

  factory ItemSetFilterEntity.fromJson(Map<String, dynamic> json) {
    return ItemSetFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  ItemSetFilterEntity copyWith({
    String? id,
    String? name,
  }) {
    return ItemSetFilterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
