class BroadcastTextFilterEntity {
  final String id;
  final String text;

  const BroadcastTextFilterEntity({this.id = '', this.text = ''});

  factory BroadcastTextFilterEntity.fromJson(Map<String, dynamic> json) {
    return BroadcastTextFilterEntity(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }

  BroadcastTextFilterEntity copyWith({String? id, String? text}) {
    return BroadcastTextFilterEntity(
      id: id ?? this.id,
      text: text ?? this.text,
    );
  }
}
