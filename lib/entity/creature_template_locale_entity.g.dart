// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_locale_entity.dart';

final class BriefCreatureTemplateLocaleEntity {
  final int entry;
  final String locale;
  final String name;
  final String title;

  const BriefCreatureTemplateLocaleEntity({
    this.entry = 0,
    this.locale = '',
    this.name = '',
    this.title = '',
  });

  factory BriefCreatureTemplateLocaleEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefCreatureTemplateLocaleEntity(
      entry: json['entry'] == true
          ? 1
          : json['entry'] == false
          ? 0
          : (json['entry'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? '',
      name: json['Name']?.toString() ?? '',
      title: json['Title']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([entry, locale, name, title]);

  CreatureTemplateLocaleKey get key {
    return CreatureTemplateLocaleKey(entry: entry, locale: locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefCreatureTemplateLocaleEntity &&
            entry == other.entry &&
            locale == other.locale &&
            name == other.name &&
            title == other.title;
  }

  @override
  String toString() {
    return 'BriefCreatureTemplateLocaleEntity('
        'entry: $entry, '
        'locale: $locale, '
        'name: $name, '
        'title: $title'
        ')';
  }
}

final class CreatureTemplateLocaleKey {
  final int entry;
  final String locale;

  const CreatureTemplateLocaleKey({required this.entry, required this.locale});

  factory CreatureTemplateLocaleKey.fromEntity(
    CreatureTemplateLocaleEntity entity,
  ) {
    return CreatureTemplateLocaleKey(
      entry: entity.entry,
      locale: entity.locale,
    );
  }

  @override
  int get hashCode => Object.hashAll([entry, locale]);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureTemplateLocaleKey &&
            entry == other.entry &&
            locale == other.locale;
  }

  @override
  String toString() {
    return 'CreatureTemplateLocaleKey('
        'entry: $entry, '
        'locale: $locale'
        ')';
  }
}

mixin _CreatureTemplateLocaleEntityMixin {
  @override
  int get hashCode {
    final self = this as CreatureTemplateLocaleEntity;
    return Object.hashAll([
      self.runtimeType,
      self.entry,
      self.locale,
      self.name,
      self.title,
      self.verifiedBuild,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureTemplateLocaleEntity;
    return identical(self, other) ||
        other is CreatureTemplateLocaleEntity &&
            self.runtimeType == other.runtimeType &&
            self.entry == other.entry &&
            self.locale == other.locale &&
            self.name == other.name &&
            self.title == other.title &&
            self.verifiedBuild == other.verifiedBuild;
  }

  CreatureTemplateLocaleEntity copyWith({
    int? entry,
    String? locale,
    String? name,
    String? title,
    int? verifiedBuild,
  }) {
    final self = this as CreatureTemplateLocaleEntity;
    return CreatureTemplateLocaleEntity(
      entry: entry ?? self.entry,
      locale: locale ?? self.locale,
      name: name ?? self.name,
      title: title ?? self.title,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureTemplateLocaleEntity;
    return {
      'entry': self.entry,
      'locale': self.locale,
      'Name': self.name,
      'Title': self.title,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  String toString() {
    final self = this as CreatureTemplateLocaleEntity;
    return 'CreatureTemplateLocaleEntity('
        'entry: ${self.entry}, '
        'locale: ${self.locale}, '
        'name: ${self.name}, '
        'title: ${self.title}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }

  static CreatureTemplateLocaleEntity fromJson(Map<String, dynamic> json) {
    return CreatureTemplateLocaleEntity(
      entry: json['entry'] == true
          ? 1
          : json['entry'] == false
          ? 0
          : (json['entry'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? '',
      name: json['Name']?.toString() ?? '',
      title: json['Title']?.toString() ?? '',
      verifiedBuild: json['VerifiedBuild'] == true
          ? 1
          : json['VerifiedBuild'] == false
          ? 0
          : (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }
}
