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
