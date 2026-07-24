// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_text_locale_entity.dart';

mixin _PageTextLocaleEntityMixin {
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
    final self = this as PageTextLocaleEntity;
    return PageTextLocaleEntity(
      id: id ?? self.id,
      locale: locale ?? self.locale,
      text: text ?? self.text,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as PageTextLocaleEntity;
    return {
      'ID': self.id,
      'locale': self.locale,
      'Text': self.text,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as PageTextLocaleEntity;
    return identical(self, other) ||
        other is PageTextLocaleEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.locale == other.locale &&
            self.text == other.text &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as PageTextLocaleEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.locale,
      self.text,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as PageTextLocaleEntity;
    return 'PageTextLocaleEntity('
        'id: ${self.id}, '
        'locale: ${self.locale}, '
        'text: ${self.text}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

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
