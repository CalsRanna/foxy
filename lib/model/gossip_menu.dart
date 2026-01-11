class GossipMenu {
  int menuId = 0;
  int textId = 0;
  String text00 = '';
  String text01 = '';
  String textLocale00 = '';
  String textLocale01 = '';

  GossipMenu();

  GossipMenu.fromJson(Map<String, dynamic> json) {
    menuId = json['MenuID'] ?? json['menuid'] ?? 0;
    textId = json['TextID'] ?? json['textid'] ?? 0;
    text00 = json['text0_0'] ?? '';
    text01 = json['text0_1'] ?? '';
    textLocale00 = json['Text0_0'] ?? '';
    textLocale01 = json['Text0_1'] ?? '';
  }

  /// 优先使用本地化文本，否则使用英文文本
  String get text {
    if (textLocale00.isNotEmpty) return textLocale00;
    if (textLocale01.isNotEmpty) return textLocale01;
    if (text00.isNotEmpty) return text00;
    if (text01.isNotEmpty) return text01;
    return '';
  }

  Map<String, dynamic> toJson() {
    return {'MenuID': menuId, 'TextID': textId};
  }
}
