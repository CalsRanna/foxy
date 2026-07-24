// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_option_locale_entity.dart';

mixin _GossipMenuOptionLocaleEntityMixin {
  int get menuId;
  int get optionId;
  String get locale;
  String get optionText;
  String get boxText;

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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GossipMenuOptionLocaleEntity &&
            runtimeType == other.runtimeType &&
            menuId == other.menuId &&
            optionId == other.optionId &&
            locale == other.locale &&
            optionText == other.optionText &&
            boxText == other.boxText;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      menuId,
      optionId,
      locale,
      optionText,
      boxText,
    ]);
  }

  @override
  String toString() {
    return 'GossipMenuOptionLocaleEntity('
        'menuId: $menuId, '
        'optionId: $optionId, '
        'locale: $locale, '
        'optionText: $optionText, '
        'boxText: $boxText'
        ')';
  }
}
