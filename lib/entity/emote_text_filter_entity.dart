class EmoteTextFilterEntity {
  final String id;
  final String name;

  const EmoteTextFilterEntity({this.id = '', this.name = ''});

  factory EmoteTextFilterEntity.fromJson(Map<String, dynamic> json) {
    return EmoteTextFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
