class SpellIconFilterEntity {
  final String id;
  final String name;

  const SpellIconFilterEntity({this.id = '', this.name = ''});

  factory SpellIconFilterEntity.fromJson(Map<String, dynamic> json) {
    return SpellIconFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  SpellIconFilterEntity copyWith({String? id, String? name}) {
    return SpellIconFilterEntity(id: id ?? this.id, name: name ?? this.name);
  }
}
