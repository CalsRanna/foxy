// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'gossip_menu_option_locale_entity.dart';

final class GossipMenuOptionLocaleKey {
  final int menuId;
  final int optionId;
  final String locale;

  const GossipMenuOptionLocaleKey({
    required this.menuId,
    required this.optionId,
    required this.locale,
  });

  factory GossipMenuOptionLocaleKey.fromEntity(
    GossipMenuOptionLocaleEntity entity,
  ) {
    return GossipMenuOptionLocaleKey(
      menuId: entity.menuId,
      optionId: entity.optionId,
      locale: entity.locale,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GossipMenuOptionLocaleKey &&
            menuId == other.menuId &&
            optionId == other.optionId &&
            locale == other.locale;
  }

  @override
  int get hashCode => Object.hashAll([menuId, optionId, locale]);

  @override
  String toString() {
    return 'GossipMenuOptionLocaleKey('
        'menuId: $menuId, '
        'optionId: $optionId, '
        'locale: $locale'
        ')';
  }
}
