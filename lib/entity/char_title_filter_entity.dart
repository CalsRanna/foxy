class CharTitleFilterEntity {
  final String id;
  final String name;

  const CharTitleFilterEntity({this.id = '', this.name = ''});

  factory CharTitleFilterEntity.fromJson(Map<String, dynamic> json) {
    return CharTitleFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  CharTitleFilterEntity copyWith({String? id, String? name}) {
    return CharTitleFilterEntity(id: id ?? this.id, name: name ?? this.name);
  }
}
