class SpellRangeFilterEntity {
  final String id;
  final String name;

  const SpellRangeFilterEntity({this.id = '', this.name = ''});

  factory SpellRangeFilterEntity.fromJson(Map<String, dynamic> json) {
    return SpellRangeFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  SpellRangeFilterEntity copyWith({String? id, String? name}) {
    return SpellRangeFilterEntity(id: id ?? this.id, name: name ?? this.name);
  }
}
