import 'package:flutter/foundation.dart';
import 'package:foxy/entity/quest_template_locale_entity.dart';

@immutable
final class QuestTemplateLocaleKey {
  final int id;
  final String locale;

  const QuestTemplateLocaleKey({required this.id, required this.locale});

  factory QuestTemplateLocaleKey.fromEntity(QuestTemplateLocaleEntity value) {
    return QuestTemplateLocaleKey(id: value.id, locale: value.locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestTemplateLocaleKey &&
            id == other.id &&
            locale == other.locale;
  }

  @override
  int get hashCode => Object.hash(id, locale);
}
