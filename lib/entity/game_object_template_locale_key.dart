import 'package:flutter/foundation.dart';
import 'package:foxy/entity/game_object_template_locale_entity.dart';

@immutable
final class GameObjectTemplateLocaleKey {
  final int entry;
  final String locale;

  const GameObjectTemplateLocaleKey({
    required this.entry,
    required this.locale,
  });

  factory GameObjectTemplateLocaleKey.fromEntity(
    GameObjectTemplateLocaleEntity value,
  ) {
    return GameObjectTemplateLocaleKey(
      entry: value.entry,
      locale: value.locale,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectTemplateLocaleKey &&
            entry == other.entry &&
            locale == other.locale;
  }

  @override
  int get hashCode => Object.hash(entry, locale);
}
