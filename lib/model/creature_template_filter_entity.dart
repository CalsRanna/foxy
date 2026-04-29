class CreatureTemplateFilterEntity {
  final String entry;
  final String name;
  final String subName;

  const CreatureTemplateFilterEntity({this.entry = '', this.name = '', this.subName = ''});

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name, 'subName': subName};
  }

  factory CreatureTemplateFilterEntity.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateFilterEntity(
      entry: json['entry'] ?? '',
      name: json['name'] ?? '',
      subName: json['subName'] ?? '',
    );
  }
}
