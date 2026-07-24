// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'creature_template_locale_entity.dart';

final class CreatureTemplateLocaleKey {
  final int entry;
  final String locale;

  const CreatureTemplateLocaleKey({required this.entry, required this.locale});

  factory CreatureTemplateLocaleKey.fromEntity(
    CreatureTemplateLocaleEntity entity,
  ) {
    return CreatureTemplateLocaleKey(
      entry: entity.entry,
      locale: entity.locale,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureTemplateLocaleKey &&
            entry == other.entry &&
            locale == other.locale;
  }

  @override
  int get hashCode => Object.hashAll([entry, locale]);

  @override
  String toString() {
    return 'CreatureTemplateLocaleKey('
        'entry: $entry, '
        'locale: $locale'
        ')';
  }
}
