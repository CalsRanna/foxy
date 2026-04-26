class QuestTemplateFilterEntity {
  String id = '';
  String title = '';

  QuestTemplateFilterEntity();

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }

  factory QuestTemplateFilterEntity.fromJson(Map<String, dynamic> json) {
    return QuestTemplateFilterEntity()
      ..id = json['id'] ?? ''
      ..title = json['title'] ?? '';
  }
}
