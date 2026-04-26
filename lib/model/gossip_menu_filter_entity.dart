class GossipMenuFilterEntity {
  String menuId = '';
  String text = '';

  GossipMenuFilterEntity();

  Map<String, dynamic> toJson() {
    return {'menuId': menuId, 'text': text};
  }

  factory GossipMenuFilterEntity.fromJson(Map<String, dynamic> json) {
    return GossipMenuFilterEntity()
      ..menuId = json['menuId'] ?? ''
      ..text = json['text'] ?? '';
  }
}
