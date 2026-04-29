/// gossip_menu_option_locale 本地化模型
/// 复合键: MenuID + OptionID + Locale
///
/// 本模块仅在 GossipMenuOptionRepository 的列表 JOIN 中使用，
/// 不单独提供编辑 UI。
class GossipMenuOptionLocale {
  final int menuId;
  final int optionId;
  final String locale;
  final String optionText;
  final String boxText;

  const GossipMenuOptionLocale({
    this.menuId = 0,
    this.optionId = 0,
    this.locale = 'zhCN',
    this.optionText = '',
    this.boxText = '',
  });

  factory GossipMenuOptionLocale.fromJson(Map<String, dynamic> json) {
    return GossipMenuOptionLocale(
      menuId: json['MenuID'] ?? 0,
      optionId: json['OptionID'] ?? 0,
      locale: json['Locale']?.toString() ?? 'zhCN',
      optionText: json['OptionText']?.toString() ?? '',
      boxText: json['BoxText']?.toString() ?? '',
    );
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
