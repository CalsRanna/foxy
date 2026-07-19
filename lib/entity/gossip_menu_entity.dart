/// gossip_menu 主表模型（复合键: MenuID + TextID）。
class GossipMenuEntity {
  final int menuId;
  final int textId;

  const GossipMenuEntity({this.menuId = 0, this.textId = 0});

  factory GossipMenuEntity.fromJson(Map<String, dynamic> json) {
    return GossipMenuEntity(
      menuId: json['MenuID'] ?? json['menuid'] ?? 0,
      textId: json['TextID'] ?? json['textid'] ?? 0,
    );
  }

  GossipMenuEntity copyWith({int? menuId, int? textId}) {
    return GossipMenuEntity(
      menuId: menuId ?? this.menuId,
      textId: textId ?? this.textId,
    );
  }

  /// 主表仅 MenuID + TextID 两列
  Map<String, dynamic> toJson() {
    return {'MenuID': menuId, 'TextID': textId};
  }
}
