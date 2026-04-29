class QuestSortFilterEntity {
  String id = '';
  String name = '';

  QuestSortFilterEntity();

  factory QuestSortFilterEntity.fromJson(Map<String, dynamic> json) {
    return QuestSortFilterEntity()
      ..id = json['id'] ?? ''
      ..name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
