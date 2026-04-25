/// gossip_menu_option_locale 本地化模型
/// 复合键: MenuID + OptionID + Locale
///
/// 本模块仅在 GossipMenuOptionRepository 的列表 JOIN 中使用，
/// 不单独提供编辑 UI。
class GossipMenuOptionLocale {
  int menuId = 0;
  int optionId = 0;
  String locale = 'zhCN';
  String optionText = '';
  String boxText = '';

  GossipMenuOptionLocale();

  GossipMenuOptionLocale.fromJson(Map<String, dynamic> json) {
    menuId = json['MenuID'] ?? 0;
    optionId = json['OptionID'] ?? 0;
    locale = json['Locale']?.toString() ?? 'zhCN';
    optionText = json['OptionText']?.toString() ?? '';
    boxText = json['BoxText']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'MenuID': menuId,
      'OptionID': optionId,
      'Locale': locale,
      'OptionText': optionText,
      'BoxText': boxText,
    };
  }
}
