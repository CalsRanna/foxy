class GameObjectTemplateFilterEntity {
  final String entry;
  final String name;

  const GameObjectTemplateFilterEntity({this.entry = '', this.name = ''});

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }

  factory GameObjectTemplateFilterEntity.fromJson(Map<String, dynamic> json) {
    return GameObjectTemplateFilterEntity(
      entry: json['entry'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
