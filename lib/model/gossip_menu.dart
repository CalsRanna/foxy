/// gossip_menu 主表模型（复合键: MenuID + TextID）
///
/// 列表查询通过 LEFT JOIN npc_text + npc_text_locale 得到展示文本，
/// 因此 fromJson 兼容这些附加字段的读入。
class GossipMenu {
  int menuId = 0;
  int textId = 0;
  // 以下字段来自 LEFT JOIN npc_text 和 npc_text_locale，仅列表展示用
  String text00 = '';
  String text01 = '';
  String textLocale00 = '';
  String textLocale01 = '';

  GossipMenu();

  GossipMenu.fromJson(Map<String, dynamic> json) {
    menuId = json['MenuID'] ?? json['menuid'] ?? 0;
    textId = json['TextID'] ?? json['textid'] ?? 0;
    text00 = json['text0_0']?.toString() ?? '';
    text01 = json['text0_1']?.toString() ?? '';
    textLocale00 = json['Text0_0']?.toString() ?? '';
    textLocale01 = json['Text0_1']?.toString() ?? '';
  }

  /// 优先本地化文本 > 英文文本
  String get text {
    if (textLocale00.isNotEmpty) return textLocale00;
    if (textLocale01.isNotEmpty) return textLocale01;
    if (text00.isNotEmpty) return text00;
    if (text01.isNotEmpty) return text01;
    return '';
  }

  /// 主表仅 MenuID + TextID 两列
  Map<String, dynamic> toJson() {
    return {'MenuID': menuId, 'TextID': textId};
  }
}
