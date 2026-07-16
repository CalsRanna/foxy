class NpcTextFilterEntity {
  final String id;
  final String text;

  const NpcTextFilterEntity({this.id = '', this.text = ''});

  factory NpcTextFilterEntity.fromJson(Map<String, dynamic> json) {
    return NpcTextFilterEntity(id: json['id'] ?? '', text: json['text'] ?? '');
  }

  NpcTextFilterEntity copyWith({String? id, String? text}) {
    return NpcTextFilterEntity(id: id ?? this.id, text: text ?? this.text);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}
