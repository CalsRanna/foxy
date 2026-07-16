class GameObjectTemplateFilterEntity {
  final String entry;
  final String name;

  const GameObjectTemplateFilterEntity({this.entry = '', this.name = ''});

  factory GameObjectTemplateFilterEntity.fromJson(Map<String, dynamic> json) {
    return GameObjectTemplateFilterEntity(
      entry: json['entry'] ?? '',
      name: json['name'] ?? '',
    );
  }

  GameObjectTemplateFilterEntity copyWith({String? entry, String? name}) {
    return GameObjectTemplateFilterEntity(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
