class QuestSortFilterEntity {
  final String id;
  final String name;

  const QuestSortFilterEntity({this.id = '', this.name = ''});

  factory QuestSortFilterEntity.fromJson(Map<String, dynamic> json) {
    return QuestSortFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  QuestSortFilterEntity copyWith({String? id, String? name}) {
    return QuestSortFilterEntity(id: id ?? this.id, name: name ?? this.name);
  }
}
