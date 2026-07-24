// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'game_object_template_locale_entity.dart';

final class GameObjectTemplateLocaleKey {
  final int entry;
  final String locale;

  const GameObjectTemplateLocaleKey({
    required this.entry,
    required this.locale,
  });

  factory GameObjectTemplateLocaleKey.fromEntity(
    GameObjectTemplateLocaleEntity entity,
  ) {
    return GameObjectTemplateLocaleKey(
      entry: entity.entry,
      locale: entity.locale,
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
  int get hashCode => Object.hashAll([entry, locale]);

  @override
  String toString() {
    return 'GameObjectTemplateLocaleKey('
        'entry: $entry, '
        'locale: $locale'
        ')';
  }
}
