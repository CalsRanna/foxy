// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_text_locale_entity.dart';

mixin _PageTextLocaleEntityMixin {
  int get id;
  String get locale;
  String get text;
  int get verifiedBuild;

  static PageTextLocaleEntity fromJson(Map<String, dynamic> json) {
    return PageTextLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? '',
      text: json['Text']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  PageTextLocaleEntity copyWith({
    int? id,
    String? locale,
    String? text,
    int? verifiedBuild,
  }) {
    return PageTextLocaleEntity(
      id: id ?? this.id,
      locale: locale ?? this.locale,
      text: text ?? this.text,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'locale': locale,
      'Text': text,
      'VerifiedBuild': verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PageTextLocaleEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            locale == other.locale &&
            text == other.text &&
            verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, id, locale, text, verifiedBuild]);
  }

  @override
  String toString() {
    return 'PageTextLocaleEntity('
        'id: $id, '
        'locale: $locale, '
        'text: $text, '
        'verifiedBuild: $verifiedBuild'
        ')';
  }
}
