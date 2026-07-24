// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'page_text_locale_entity.dart';

final class PageTextLocaleKey {
  final int id;
  final String locale;

  const PageTextLocaleKey({required this.id, required this.locale});

  factory PageTextLocaleKey.fromEntity(PageTextLocaleEntity entity) {
    return PageTextLocaleKey(id: entity.id, locale: entity.locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PageTextLocaleKey && id == other.id && locale == other.locale;
  }

  @override
  int get hashCode => Object.hashAll([id, locale]);

  @override
  String toString() {
    return 'PageTextLocaleKey('
        'id: $id, '
        'locale: $locale'
        ')';
  }
}
