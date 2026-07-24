// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'page_text_locale_entity.key.g.dart';

final class BriefPageTextLocaleEntity {
  final int id;
  final String locale;
  final String text;
  final int verifiedBuild;

  const BriefPageTextLocaleEntity({
    this.id = 0,
    this.locale = '',
    this.text = '',
    this.verifiedBuild = 0,
  });

  factory BriefPageTextLocaleEntity.fromJson(Map<String, dynamic> json) {
    return BriefPageTextLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? '',
      text: json['Text']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  PageTextLocaleKey get key {
    return PageTextLocaleKey(id: id, locale: locale);
  }
}
