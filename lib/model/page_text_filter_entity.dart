class PageTextFilterEntity {
  String id = '';
  String text = '';

  PageTextFilterEntity();

  factory PageTextFilterEntity.fromJson(Map<String, dynamic> json) {
    return PageTextFilterEntity()
      ..id = json['id'] ?? ''
      ..text = json['text'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}
