import 'package:foxy/entity/gossip_menu_option_key.dart';

/// 对话菜单选项列表展示模型。
///
/// 只携带列表展示列和完整的两列行定位器。
class BriefGossipMenuOptionEntity {
  final int menuId;
  final int optionId;
  final int optionIcon;
  final String optionText;
  final int optionType;
  final int optionNpcFlag;
  final int actionMenuId;
  final String localeOptionText;

  const BriefGossipMenuOptionEntity({
    this.menuId = 0,
    this.optionId = 0,
    this.optionIcon = 0,
    this.optionText = '',
    this.optionType = 0,
    this.optionNpcFlag = 0,
    this.actionMenuId = 0,
    this.localeOptionText = '',
  });

  factory BriefGossipMenuOptionEntity.fromJson(Map<String, dynamic> json) {
    return BriefGossipMenuOptionEntity(
      menuId: json['MenuID'] ?? json['menuid'] ?? 0,
      optionId: json['OptionID'] ?? json['optionid'] ?? 0,
      optionIcon: json['OptionIcon'] ?? json['optionicon'] ?? 0,
      optionText: json['OptionText']?.toString() ?? '',
      optionType: json['OptionType'] ?? 0,
      optionNpcFlag: json['OptionNpcFlag'] ?? 0,
      actionMenuId: json['ActionMenuID'] ?? 0,
      localeOptionText: json['localeOptionText']?.toString() ?? '',
    );
  }

  String get displayText =>
      localeOptionText.isNotEmpty ? localeOptionText : optionText;

  GossipMenuOptionKey get key =>
      GossipMenuOptionKey(menuId: menuId, optionId: optionId);
}
