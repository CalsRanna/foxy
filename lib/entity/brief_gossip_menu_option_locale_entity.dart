import 'package:foxy/entity/gossip_menu_option_locale_key.dart';

/// 对话菜单选项本地化列表展示模型。
class BriefGossipMenuOptionLocaleEntity {
  final int menuId;
  final int optionId;
  final String locale;
  final String optionText;

  const BriefGossipMenuOptionLocaleEntity({
    this.menuId = 0,
    this.optionId = 0,
    this.locale = 'zhCN',
    this.optionText = '',
  });

  factory BriefGossipMenuOptionLocaleEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefGossipMenuOptionLocaleEntity(
      menuId: json['MenuID'] ?? 0,
      optionId: json['OptionID'] ?? 0,
      locale: json['Locale']?.toString() ?? 'zhCN',
      optionText: json['OptionText']?.toString() ?? '',
    );
  }

  GossipMenuOptionLocaleKey get key => GossipMenuOptionLocaleKey(
    menuId: menuId,
    optionId: optionId,
    locale: locale,
  );
}
