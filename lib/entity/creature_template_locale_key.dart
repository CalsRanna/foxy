import 'package:flutter/foundation.dart';
import 'package:foxy/entity/creature_template_locale_entity.dart';

@immutable
final class CreatureTemplateLocaleKey {
  final int entry;
  final String locale;

  const CreatureTemplateLocaleKey({required this.entry, required this.locale});

  factory CreatureTemplateLocaleKey.fromEntity(
    CreatureTemplateLocaleEntity value,
  ) {
    return CreatureTemplateLocaleKey(entry: value.entry, locale: value.locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureTemplateLocaleKey &&
            entry == other.entry &&
            locale == other.locale;
  }

  @override
  int get hashCode => Object.hash(entry, locale);
}
