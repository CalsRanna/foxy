class QuestInfoFilterEntity {
  String id = '';
  String name = '';

  QuestInfoFilterEntity();

  factory QuestInfoFilterEntity.fromJson(Map<String, dynamic> json) {
    return QuestInfoFilterEntity()
      ..id = json['id'] ?? ''
      ..name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
