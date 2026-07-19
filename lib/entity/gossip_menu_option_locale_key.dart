import 'package:flutter/foundation.dart';
import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';

@immutable
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
    GossipMenuOptionLocaleEntity value,
  ) {
    return GossipMenuOptionLocaleKey(
      menuId: value.menuId,
      optionId: value.optionId,
      locale: value.locale,
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
  int get hashCode => Object.hash(menuId, optionId, locale);
}
