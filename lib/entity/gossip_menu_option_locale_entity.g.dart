// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_option_locale_entity.dart';

mixin _GossipMenuOptionLocaleEntityMixin {
  static GossipMenuOptionLocaleEntity fromJson(Map<String, dynamic> json) {
    return GossipMenuOptionLocaleEntity(
      menuId: (json['MenuID'] as num?)?.toInt() ?? 0,
      optionId: (json['OptionID'] as num?)?.toInt() ?? 0,
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
    final self = this as GossipMenuOptionLocaleEntity;
    return GossipMenuOptionLocaleEntity(
      menuId: menuId ?? self.menuId,
      optionId: optionId ?? self.optionId,
      locale: locale ?? self.locale,
      optionText: optionText ?? self.optionText,
      boxText: boxText ?? self.boxText,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GossipMenuOptionLocaleEntity;
    return {
      'MenuID': self.menuId,
      'OptionID': self.optionId,
      'Locale': self.locale,
      'OptionText': self.optionText,
      'BoxText': self.boxText,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as GossipMenuOptionLocaleEntity;
    return identical(self, other) ||
        other is GossipMenuOptionLocaleEntity &&
            self.runtimeType == other.runtimeType &&
            self.menuId == other.menuId &&
            self.optionId == other.optionId &&
            self.locale == other.locale &&
            self.optionText == other.optionText &&
            self.boxText == other.boxText;
  }

  @override
  int get hashCode {
    final self = this as GossipMenuOptionLocaleEntity;
    return Object.hashAll([
      self.runtimeType,
      self.menuId,
      self.optionId,
      self.locale,
      self.optionText,
      self.boxText,
    ]);
  }

  @override
  String toString() {
    final self = this as GossipMenuOptionLocaleEntity;
    return 'GossipMenuOptionLocaleEntity('
        'menuId: ${self.menuId}, '
        'optionId: ${self.optionId}, '
        'locale: ${self.locale}, '
        'optionText: ${self.optionText}, '
        'boxText: ${self.boxText}'
        ')';
  }
}
