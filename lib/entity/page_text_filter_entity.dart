class PageTextFilterEntity {
  final String id;
  final String text;

  const PageTextFilterEntity({this.id = '', this.text = ''});

  factory PageTextFilterEntity.fromJson(Map<String, dynamic> json) {
    return PageTextFilterEntity(id: json['id'] ?? '', text: json['text'] ?? '');
  }

  PageTextFilterEntity copyWith({String? id, String? text}) {
    return PageTextFilterEntity(id: id ?? this.id, text: text ?? this.text);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}
