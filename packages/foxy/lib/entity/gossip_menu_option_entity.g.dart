// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_option_entity.dart';

final class BriefGossipMenuOptionEntity {
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
      menuId: json['MenuID'] == true
          ? 1
          : json['MenuID'] == false
          ? 0
          : (json['MenuID'] as num?)?.toInt() ?? 0,
      optionId: json['OptionID'] == true
          ? 1
          : json['OptionID'] == false
          ? 0
          : (json['OptionID'] as num?)?.toInt() ?? 0,
      optionIcon: json['OptionIcon'] == true
          ? 1
          : json['OptionIcon'] == false
          ? 0
          : (json['OptionIcon'] as num?)?.toInt() ?? 0,
      optionText: json['OptionText']?.toString() ?? '',
      optionType: json['OptionType'] == true
          ? 1
          : json['OptionType'] == false
          ? 0
          : (json['OptionType'] as num?)?.toInt() ?? 0,
      optionNpcFlag: json['OptionNpcFlag'] == true
          ? 1
          : json['OptionNpcFlag'] == false
          ? 0
          : (json['OptionNpcFlag'] as num?)?.toInt() ?? 0,
      actionMenuId: json['ActionMenuID'] == true
          ? 1
          : json['ActionMenuID'] == false
          ? 0
          : (json['ActionMenuID'] as num?)?.toInt() ?? 0,
      localeOptionText: json['localeOptionText']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([
    menuId,
    optionId,
    optionIcon,
    optionText,
    optionType,
    optionNpcFlag,
    actionMenuId,
    localeOptionText,
  ]);

  GossipMenuOptionKey get key {
    return GossipMenuOptionKey(menuId: menuId, optionId: optionId);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefGossipMenuOptionEntity &&
            menuId == other.menuId &&
            optionId == other.optionId &&
            optionIcon == other.optionIcon &&
            optionText == other.optionText &&
            optionType == other.optionType &&
            optionNpcFlag == other.optionNpcFlag &&
            actionMenuId == other.actionMenuId &&
            localeOptionText == other.localeOptionText;
  }

  @override
  String toString() {
    return 'BriefGossipMenuOptionEntity('
        'menuId: $menuId, '
        'optionId: $optionId, '
        'optionIcon: $optionIcon, '
        'optionText: $optionText, '
        'optionType: $optionType, '
        'optionNpcFlag: $optionNpcFlag, '
        'actionMenuId: $actionMenuId, '
        'localeOptionText: $localeOptionText'
        ')';
  }
}

final class GossipMenuOptionKey {
  final int menuId;
  final int optionId;

  const GossipMenuOptionKey({required this.menuId, required this.optionId});

  factory GossipMenuOptionKey.fromEntity(GossipMenuOptionEntity entity) {
    return GossipMenuOptionKey(
      menuId: entity.menuId,
      optionId: entity.optionId,
    );
  }

  @override
  int get hashCode => Object.hashAll([menuId, optionId]);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GossipMenuOptionKey &&
            menuId == other.menuId &&
            optionId == other.optionId;
  }

  @override
  String toString() {
    return 'GossipMenuOptionKey('
        'menuId: $menuId, '
        'optionId: $optionId'
        ')';
  }
}

mixin _GossipMenuOptionEntityMixin {
  @override
  int get hashCode {
    final self = this as GossipMenuOptionEntity;
    return Object.hashAll([
      self.runtimeType,
      self.menuId,
      self.optionId,
      self.optionIcon,
      self.optionText,
      self.optionBroadcastTextId,
      self.optionType,
      self.optionNpcFlag,
      self.boxCoded,
      self.boxMoney,
      self.boxText,
      self.boxBroadcastTextId,
      self.actionMenuId,
      self.actionPoiId,
      self.verifiedBuild,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as GossipMenuOptionEntity;
    return identical(self, other) ||
        other is GossipMenuOptionEntity &&
            self.runtimeType == other.runtimeType &&
            self.menuId == other.menuId &&
            self.optionId == other.optionId &&
            self.optionIcon == other.optionIcon &&
            self.optionText == other.optionText &&
            self.optionBroadcastTextId == other.optionBroadcastTextId &&
            self.optionType == other.optionType &&
            self.optionNpcFlag == other.optionNpcFlag &&
            self.boxCoded == other.boxCoded &&
            self.boxMoney == other.boxMoney &&
            self.boxText == other.boxText &&
            self.boxBroadcastTextId == other.boxBroadcastTextId &&
            self.actionMenuId == other.actionMenuId &&
            self.actionPoiId == other.actionPoiId &&
            self.verifiedBuild == other.verifiedBuild;
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
    final self = this as GossipMenuOptionEntity;
    return GossipMenuOptionEntity(
      menuId: menuId ?? self.menuId,
      optionId: optionId ?? self.optionId,
      optionIcon: optionIcon ?? self.optionIcon,
      optionText: optionText ?? self.optionText,
      optionBroadcastTextId:
          optionBroadcastTextId ?? self.optionBroadcastTextId,
      optionType: optionType ?? self.optionType,
      optionNpcFlag: optionNpcFlag ?? self.optionNpcFlag,
      boxCoded: boxCoded ?? self.boxCoded,
      boxMoney: boxMoney ?? self.boxMoney,
      boxText: boxText ?? self.boxText,
      boxBroadcastTextId: boxBroadcastTextId ?? self.boxBroadcastTextId,
      actionMenuId: actionMenuId ?? self.actionMenuId,
      actionPoiId: actionPoiId ?? self.actionPoiId,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GossipMenuOptionEntity;
    return {
      'MenuID': self.menuId,
      'OptionID': self.optionId,
      'OptionIcon': self.optionIcon,
      'OptionText': self.optionText,
      'OptionBroadcastTextID': self.optionBroadcastTextId,
      'OptionType': self.optionType,
      'OptionNpcFlag': self.optionNpcFlag,
      'BoxCoded': self.boxCoded,
      'BoxMoney': self.boxMoney,
      'BoxText': self.boxText,
      'BoxBroadcastTextID': self.boxBroadcastTextId,
      'ActionMenuID': self.actionMenuId,
      'ActionPoiID': self.actionPoiId,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  String toString() {
    final self = this as GossipMenuOptionEntity;
    return 'GossipMenuOptionEntity('
        'menuId: ${self.menuId}, '
        'optionId: ${self.optionId}, '
        'optionIcon: ${self.optionIcon}, '
        'optionText: ${self.optionText}, '
        'optionBroadcastTextId: ${self.optionBroadcastTextId}, '
        'optionType: ${self.optionType}, '
        'optionNpcFlag: ${self.optionNpcFlag}, '
        'boxCoded: ${self.boxCoded}, '
        'boxMoney: ${self.boxMoney}, '
        'boxText: ${self.boxText}, '
        'boxBroadcastTextId: ${self.boxBroadcastTextId}, '
        'actionMenuId: ${self.actionMenuId}, '
        'actionPoiId: ${self.actionPoiId}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }

  static GossipMenuOptionEntity fromJson(Map<String, dynamic> json) {
    return GossipMenuOptionEntity(
      menuId: json['MenuID'] == true
          ? 1
          : json['MenuID'] == false
          ? 0
          : (json['MenuID'] as num?)?.toInt() ?? 0,
      optionId: json['OptionID'] == true
          ? 1
          : json['OptionID'] == false
          ? 0
          : (json['OptionID'] as num?)?.toInt() ?? 0,
      optionIcon: json['OptionIcon'] == true
          ? 1
          : json['OptionIcon'] == false
          ? 0
          : (json['OptionIcon'] as num?)?.toInt() ?? 0,
      optionText: json['OptionText']?.toString() ?? '',
      optionBroadcastTextId: json['OptionBroadcastTextID'] == true
          ? 1
          : json['OptionBroadcastTextID'] == false
          ? 0
          : (json['OptionBroadcastTextID'] as num?)?.toInt() ?? 0,
      optionType: json['OptionType'] == true
          ? 1
          : json['OptionType'] == false
          ? 0
          : (json['OptionType'] as num?)?.toInt() ?? 0,
      optionNpcFlag: json['OptionNpcFlag'] == true
          ? 1
          : json['OptionNpcFlag'] == false
          ? 0
          : (json['OptionNpcFlag'] as num?)?.toInt() ?? 0,
      boxCoded: json['BoxCoded'] == true
          ? 1
          : json['BoxCoded'] == false
          ? 0
          : (json['BoxCoded'] as num?)?.toInt() ?? 0,
      boxMoney: json['BoxMoney'] == true
          ? 1
          : json['BoxMoney'] == false
          ? 0
          : (json['BoxMoney'] as num?)?.toInt() ?? 0,
      boxText: json['BoxText']?.toString() ?? '',
      boxBroadcastTextId: json['BoxBroadcastTextID'] == true
          ? 1
          : json['BoxBroadcastTextID'] == false
          ? 0
          : (json['BoxBroadcastTextID'] as num?)?.toInt() ?? 0,
      actionMenuId: json['ActionMenuID'] == true
          ? 1
          : json['ActionMenuID'] == false
          ? 0
          : (json['ActionMenuID'] as num?)?.toInt() ?? 0,
      actionPoiId: json['ActionPoiID'] == true
          ? 1
          : json['ActionPoiID'] == false
          ? 0
          : (json['ActionPoiID'] as num?)?.toInt() ?? 0,
      verifiedBuild: json['VerifiedBuild'] == true
          ? 1
          : json['VerifiedBuild'] == false
          ? 0
          : (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }
}
