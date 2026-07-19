import 'package:flutter/foundation.dart';
import 'package:foxy/entity/quest_request_items_entity.dart';

@immutable
final class QuestRequestItemsLocaleKey {
  final int id;
  final String locale;

  const QuestRequestItemsLocaleKey({required this.id, required this.locale});

  factory QuestRequestItemsLocaleKey.fromEntity(
    QuestRequestItemsLocaleEntity value,
  ) {
    return QuestRequestItemsLocaleKey(id: value.id, locale: value.locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestRequestItemsLocaleKey &&
            id == other.id &&
            locale == other.locale;
  }

  @override
  int get hashCode => Object.hash(id, locale);
}
