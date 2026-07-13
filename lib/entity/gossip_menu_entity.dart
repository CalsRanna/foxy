class BriefGossipMenuEntity {
  final int menuId;
  final int textId;
  final String text00;
  final String text01;
  final String textLocale00;
  final String textLocale01;

  const BriefGossipMenuEntity({
    this.menuId = 0,
    this.textId = 0,
    this.text00 = '',
    this.text01 = '',
    this.textLocale00 = '',
    this.textLocale01 = '',
  });

  factory BriefGossipMenuEntity.fromJson(Map<String, dynamic> json) {
    return BriefGossipMenuEntity(
      menuId: json['MenuID'] ?? json['menuid'] ?? 0,
      textId: json['TextID'] ?? json['textid'] ?? 0,
      text00: json['text0_0']?.toString() ?? '',
      text01: json['text0_1']?.toString() ?? '',
      textLocale00: json['Text0_0']?.toString() ?? '',
      textLocale01: json['Text0_1']?.toString() ?? '',
    );
  }

  String get text {
    if (textLocale00.isNotEmpty) return textLocale00;
    if (textLocale01.isNotEmpty) return textLocale01;
    if (text00.isNotEmpty) return text00;
    if (text01.isNotEmpty) return text01;
    return '';
  }

  Map<String, dynamic> toJson() {
    return {
      'MenuID': menuId,
      'TextID': textId,
      'text0_0': text00,
      'text0_1': text01,
      'Text0_0': textLocale00,
      'Text0_1': textLocale01,
    };
  }

  BriefGossipMenuEntity copyWith({
    int? menuId,
    int? textId,
    String? text00,
    String? text01,
    String? textLocale00,
    String? textLocale01,
  }) {
    return BriefGossipMenuEntity(
      menuId: menuId ?? this.menuId,
      textId: textId ?? this.textId,
      text00: text00 ?? this.text00,
      text01: text01 ?? this.text01,
      textLocale00: textLocale00 ?? this.textLocale00,
      textLocale01: textLocale01 ?? this.textLocale01,
    );
  }
}

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

  /// 主表仅 MenuID + TextID 两列
  Map<String, dynamic> toJson() {
    return {'MenuID': menuId, 'TextID': textId};
  }

  GossipMenuEntity copyWith({int? menuId, int? textId}) {
    return GossipMenuEntity(
      menuId: menuId ?? this.menuId,
      textId: textId ?? this.textId,
    );
  }
}
