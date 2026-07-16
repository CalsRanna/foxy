class ItemRandomPropertiesFilterEntity {
  final String id;
  final String name;

  const ItemRandomPropertiesFilterEntity({this.id = '', this.name = ''});

  factory ItemRandomPropertiesFilterEntity.fromJson(Map<String, dynamic> json) {
    return ItemRandomPropertiesFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  ItemRandomPropertiesFilterEntity copyWith({String? id, String? name}) {
    return ItemRandomPropertiesFilterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
