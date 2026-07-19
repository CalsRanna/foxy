import 'package:flutter/foundation.dart';
import 'package:foxy/entity/npc_text_locale_entity.dart';

@immutable
final class NpcTextLocaleKey {
  final int id;
  final String locale;

  const NpcTextLocaleKey({required this.id, required this.locale});

  factory NpcTextLocaleKey.fromEntity(NpcTextLocaleEntity value) {
    return NpcTextLocaleKey(id: value.id, locale: value.locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NpcTextLocaleKey && id == other.id && locale == other.locale;
  }

  @override
  int get hashCode => Object.hash(id, locale);
}
