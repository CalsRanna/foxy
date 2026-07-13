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
}

/// gossip_menu_option 模型（复合键: MenuID + OptionID）。
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
    );
  }

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

  GossipMenuOptionEntity copyWith({
    int? menuId,
    int? optionId,
    int? optionIcon,
    String? optionText,
    int? optionBroadcastTextId,
    int? optionType,
    int? optionNpcFlag,
    int? boxCoded,
    int? boxMoney,
    String? boxText,
    int? boxBroadcastTextId,
    int? actionMenuId,
    int? actionPoiId,
    int? verifiedBuild,
  }) {
    return GossipMenuOptionEntity(
      menuId: menuId ?? this.menuId,
      optionId: optionId ?? this.optionId,
      optionIcon: optionIcon ?? this.optionIcon,
      optionText: optionText ?? this.optionText,
      optionBroadcastTextId:
          optionBroadcastTextId ?? this.optionBroadcastTextId,
      optionType: optionType ?? this.optionType,
      optionNpcFlag: optionNpcFlag ?? this.optionNpcFlag,
      boxCoded: boxCoded ?? this.boxCoded,
      boxMoney: boxMoney ?? this.boxMoney,
      boxText: boxText ?? this.boxText,
      boxBroadcastTextId: boxBroadcastTextId ?? this.boxBroadcastTextId,
      actionMenuId: actionMenuId ?? this.actionMenuId,
      actionPoiId: actionPoiId ?? this.actionPoiId,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }
}
