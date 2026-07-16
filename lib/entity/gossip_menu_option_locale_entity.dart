/// 列表 / Picker 精简行：复合键 + OptionText
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

  Map<String, dynamic> toJson() {
    return {
      'MenuID': menuId,
      'OptionID': optionId,
      'Locale': locale,
      'OptionText': optionText,
    };
  }
}

/// gossip_menu_option_locale 本地化模型
/// 复合键: MenuID + OptionID + Locale
class GossipMenuOptionLocaleEntity {
  final int menuId;
  final int optionId;
  final String locale;
  final String optionText;
  final String boxText;

  const GossipMenuOptionLocaleEntity({
    this.menuId = 0,
    this.optionId = 0,
    this.locale = 'zhCN',
    this.optionText = '',
    this.boxText = '',
  });

  factory GossipMenuOptionLocaleEntity.fromJson(Map<String, dynamic> json) {
    return GossipMenuOptionLocaleEntity(
      menuId: json['MenuID'] ?? 0,
      optionId: json['OptionID'] ?? 0,
      locale: json['Locale']?.toString() ?? 'zhCN',
      optionText: json['OptionText']?.toString() ?? '',
      boxText: json['BoxText']?.toString() ?? '',
    );
  }

  GossipMenuOptionLocaleEntity copyWith({
    int? menuId,
    int? optionId,
    String? locale,
    String? optionText,
    String? boxText,
  }) {
    return GossipMenuOptionLocaleEntity(
      menuId: menuId ?? this.menuId,
      optionId: optionId ?? this.optionId,
      locale: locale ?? this.locale,
      optionText: optionText ?? this.optionText,
      boxText: boxText ?? this.boxText,
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
