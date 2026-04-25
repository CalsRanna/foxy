class GameObjectTemplateFilterEntity {
  String entry = '';
  String name = '';

  GameObjectTemplateFilterEntity();

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }

  factory GameObjectTemplateFilterEntity.fromJson(Map<String, dynamic> json) {
    return GameObjectTemplateFilterEntity()
      ..entry = json['entry'] ?? ''
      ..name = json['name'] ?? '';
  }
}
