class CreatureTemplateFilterEntity {
  String entry = '';
  String name = '';
  String subName = '';

  CreatureTemplateFilterEntity();

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name, 'subName': subName};
  }

  factory CreatureTemplateFilterEntity.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateFilterEntity()
      ..entry = json['entry'] ?? ''
      ..name = json['name'] ?? ''
      ..subName = json['subName'] ?? '';
  }
}
