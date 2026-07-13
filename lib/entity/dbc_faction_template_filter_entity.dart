class DbcFactionTemplateFilterEntity {
  final String id;
  final String faction;
  final String name;

  const DbcFactionTemplateFilterEntity({
    this.id = '',
    this.faction = '',
    this.name = '',
  });

  factory DbcFactionTemplateFilterEntity.fromJson(Map<String, dynamic> json) {
    return DbcFactionTemplateFilterEntity(
      id: json['id'] ?? '',
      faction: json['faction'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'faction': faction, 'name': name};
  }

  DbcFactionTemplateFilterEntity copyWith({
    String? id,
    String? faction,
    String? name,
  }) {
    return DbcFactionTemplateFilterEntity(
      id: id ?? this.id,
      faction: faction ?? this.faction,
      name: name ?? this.name,
    );
  }
}
