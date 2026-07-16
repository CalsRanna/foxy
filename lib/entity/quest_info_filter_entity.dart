class QuestInfoFilterEntity {
  final String id;
  final String name;

  const QuestInfoFilterEntity({this.id = '', this.name = ''});

  factory QuestInfoFilterEntity.fromJson(Map<String, dynamic> json) {
    return QuestInfoFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  QuestInfoFilterEntity copyWith({String? id, String? name}) {
    return QuestInfoFilterEntity(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
