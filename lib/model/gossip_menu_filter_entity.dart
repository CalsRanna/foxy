class GossipMenuFilterEntity {
  final String menuId;
  final String text;

  const GossipMenuFilterEntity({this.menuId = '', this.text = ''});

  Map<String, dynamic> toJson() {
    return {'menuId': menuId, 'text': text};
  }

  factory GossipMenuFilterEntity.fromJson(Map<String, dynamic> json) {
    return GossipMenuFilterEntity(
      menuId: json['menuId'] ?? '',
      text: json['text'] ?? '',
    );
  }
}
