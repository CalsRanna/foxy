// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'gossip_menu_option_locale_entity.key.g.dart';

final class BriefGossipMenuOptionLocaleEntity {
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
      menuId: (json['MenuID'] as num?)?.toInt() ?? 0,
      optionId: (json['OptionID'] as num?)?.toInt() ?? 0,
      locale: json['Locale']?.toString() ?? 'zhCN',
      optionText: json['OptionText']?.toString() ?? '',
    );
  }

  GossipMenuOptionLocaleKey get key {
    return GossipMenuOptionLocaleKey(
      menuId: menuId,
      optionId: optionId,
      locale: locale,
    );
  }
}
