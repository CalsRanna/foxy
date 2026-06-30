class QuestTemplateFilterEntity {
  final String id;
  final String title;

  const QuestTemplateFilterEntity({this.id = '', this.title = ''});

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }

  QuestTemplateFilterEntity copyWith({String? id, String? title}) {
    return QuestTemplateFilterEntity(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  factory QuestTemplateFilterEntity.fromJson(Map<String, dynamic> json) {
    return QuestTemplateFilterEntity(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
