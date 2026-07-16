class LootTemplateFilterEntity {
  final String entry;
  final String name;

  const LootTemplateFilterEntity({this.entry = '', this.name = ''});

  factory LootTemplateFilterEntity.fromJson(Map<String, dynamic> json) {
    return LootTemplateFilterEntity(
      entry: json['entry'] ?? '',
      name: json['name'] ?? '',
    );
  }

  LootTemplateFilterEntity copyWith({String? entry, String? name}) {
    return LootTemplateFilterEntity(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
