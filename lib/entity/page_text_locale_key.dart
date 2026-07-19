import 'package:flutter/foundation.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';

@immutable
final class PageTextLocaleKey {
  final int id;
  final String locale;

  const PageTextLocaleKey({required this.id, required this.locale});

  factory PageTextLocaleKey.fromEntity(PageTextLocaleEntity value) {
    return PageTextLocaleKey(id: value.id, locale: value.locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PageTextLocaleKey && id == other.id && locale == other.locale;
  }

  @override
  int get hashCode => Object.hash(id, locale);
}
