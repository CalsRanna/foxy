class ItemRandomSuffixFilterEntity {
  final String id;
  final String name;

  const ItemRandomSuffixFilterEntity({this.id = '', this.name = ''});

  factory ItemRandomSuffixFilterEntity.fromJson(Map<String, dynamic> json) {
    return ItemRandomSuffixFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  ItemRandomSuffixFilterEntity copyWith({String? id, String? name}) {
    return ItemRandomSuffixFilterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
