class DbcFactionFilterEntity {
  final String id;
  final String name;

  const DbcFactionFilterEntity({this.id = '', this.name = ''});

  factory DbcFactionFilterEntity.fromJson(Map<String, dynamic> json) {
    return DbcFactionFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  DbcFactionFilterEntity copyWith({String? id, String? name}) {
    return DbcFactionFilterEntity(id: id ?? this.id, name: name ?? this.name);
  }
}
