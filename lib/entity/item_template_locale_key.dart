import 'package:flutter/foundation.dart';
import 'package:foxy/entity/item_template_locale_entity.dart';

@immutable
final class ItemTemplateLocaleKey {
  final int id;
  final String locale;

  const ItemTemplateLocaleKey({required this.id, required this.locale});

  factory ItemTemplateLocaleKey.fromEntity(ItemTemplateLocaleEntity value) {
    return ItemTemplateLocaleKey(id: value.id, locale: value.locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemTemplateLocaleKey &&
            id == other.id &&
            locale == other.locale;
  }

  @override
  int get hashCode => Object.hash(id, locale);
}
