/// gossip_menu_option 模型（复合键: MenuID + OptionID）
///
/// 列表查询时通过 LEFT JOIN gossip_menu_option_locale 得到 localeOptionText，
/// 仅用于列表展示，不参与 toJson。
class GossipMenuOptionEntity {
  final int menuId;
  final int optionId;
  final int optionIcon;
  final String optionText;
  final int optionBroadcastTextId;
  final int optionType;
  final int optionNpcFlag;
  final int boxCoded;
  final int boxMoney;
  final String boxText;
  final int boxBroadcastTextId;
  final int actionMenuId;
  final int actionPoiId;
  final int verifiedBuild;

  /// 仅列表展示用（JOIN 结果）
  final String localeOptionText;

  const GossipMenuOptionEntity({
    this.menuId = 0,
    this.optionId = 0,
    this.optionIcon = 0,
    this.optionText = '',
    this.optionBroadcastTextId = 0,
    this.optionType = 0,
    this.optionNpcFlag = 0,
    this.boxCoded = 0,
    this.boxMoney = 0,
    this.boxText = '',
    this.boxBroadcastTextId = 0,
    this.actionMenuId = 0,
    this.actionPoiId = 0,
    this.verifiedBuild = 0,
    this.localeOptionText = '',
  });

  factory GossipMenuOptionEntity.fromJson(Map<String, dynamic> json) {
    return GossipMenuOptionEntity(
      menuId: json['MenuID'] ?? json['menuid'] ?? 0,
      optionId: json['OptionID'] ?? json['optionid'] ?? 0,
      optionIcon: json['OptionIcon'] ?? json['optionicon'] ?? 0,
      optionText: json['OptionText']?.toString() ?? '',
      optionBroadcastTextId: json['OptionBroadcastTextID'] ?? 0,
      optionType: json['OptionType'] ?? 0,
      optionNpcFlag: json['OptionNpcFlag'] ?? 0,
      boxCoded: json['BoxCoded'] ?? 0,
      boxMoney: json['BoxMoney'] ?? 0,
      boxText: json['BoxText']?.toString() ?? '',
      boxBroadcastTextId: json['BoxBroadcastTextID'] ?? 0,
      actionMenuId: json['ActionMenuID'] ?? 0,
      actionPoiId: json['ActionPoiID'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? 0,
      localeOptionText: json['localeOptionText']?.toString() ?? '',
    );
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
