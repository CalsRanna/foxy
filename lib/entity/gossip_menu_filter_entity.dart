class GossipMenuFilterEntity {
  final String menuId;
  final String text;

  const GossipMenuFilterEntity({this.menuId = '', this.text = ''});

  factory GossipMenuFilterEntity.fromJson(Map<String, dynamic> json) {
    return GossipMenuFilterEntity(
      menuId: json['menuId'] ?? '',
      text: json['text'] ?? '',
    );
  }

  GossipMenuFilterEntity copyWith({String? menuId, String? text}) {
    return GossipMenuFilterEntity(
      menuId: menuId ?? this.menuId,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toJson() {
    return {'menuId': menuId, 'text': text};
  }
}
