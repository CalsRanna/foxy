/// gossip_menu_option 模型（复合键: MenuID + OptionID）
///
/// 列表查询时通过 LEFT JOIN gossip_menu_option_locale 得到 localeOptionText，
/// 仅用于列表展示，不参与 toJson。
class GossipMenuOption {
  int menuId = 0;
  int optionId = 0;
  int optionIcon = 0;
  String optionText = '';
  int optionBroadcastTextId = 0;
  int optionType = 0;
  int optionNpcFlag = 0;
  int boxCoded = 0;
  int boxMoney = 0;
  String boxText = '';
  int boxBroadcastTextId = 0;
  int actionMenuId = 0;
  int actionPoiId = 0;
  int verifiedBuild = 0;

  /// 仅列表展示用（JOIN 结果）
  String localeOptionText = '';

  GossipMenuOption();

  factory GossipMenuOption.fromJson(Map<String, dynamic> json) {
    return GossipMenuOption()
      ..menuId = json['MenuID'] ?? json['menuid'] ?? 0
      ..optionId = json['OptionID'] ?? json['optionid'] ?? 0
      ..optionIcon = json['OptionIcon'] ?? json['optionicon'] ?? 0
      ..optionText = json['OptionText']?.toString() ?? ''
      ..optionBroadcastTextId = json['OptionBroadcastTextID'] ?? 0
      ..optionType = json['OptionType'] ?? 0
      ..optionNpcFlag = json['OptionNpcFlag'] ?? 0
      ..boxCoded = json['BoxCoded'] ?? 0
      ..boxMoney = json['BoxMoney'] ?? 0
      ..boxText = json['BoxText']?.toString() ?? ''
      ..boxBroadcastTextId = json['BoxBroadcastTextID'] ?? 0
      ..actionMenuId = json['ActionMenuID'] ?? 0
      ..actionPoiId = json['ActionPoiID'] ?? 0
      ..verifiedBuild = json['VerifiedBuild'] ?? 0
      ..localeOptionText = json['localeOptionText']?.toString() ?? '';
  }

  /// 显示文本（优先本地化）
  String get displayText =>
      localeOptionText.isNotEmpty ? localeOptionText : optionText;

  Map<String, dynamic> toJson() {
    return {
      'MenuID': menuId,
      'OptionID': optionId,
      'OptionIcon': optionIcon,
      'OptionText': optionText,
      'OptionBroadcastTextID': optionBroadcastTextId,
      'OptionType': optionType,
      'OptionNpcFlag': optionNpcFlag,
      'BoxCoded': boxCoded,
      'BoxMoney': boxMoney,
      'BoxText': boxText,
      'BoxBroadcastTextID': boxBroadcastTextId,
      'ActionMenuID': actionMenuId,
      'ActionPoiID': actionPoiId,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
