class EmoteTextFilterEntity {
  String id = '';
  String name = '';
  EmoteTextFilterEntity();

  factory EmoteTextFilterEntity.fromJson(Map<String, dynamic> json) {
    return EmoteTextFilterEntity()
      ..id = json['id'] ?? ''
      ..name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
