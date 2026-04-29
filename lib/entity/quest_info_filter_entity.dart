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

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
