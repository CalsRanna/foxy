// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_locale_entity.dart';

mixin _CreatureTemplateLocaleEntityMixin {
  int get entry;
  String get locale;
  String get name;
  String get title;
  int get verifiedBuild;

  static CreatureTemplateLocaleEntity fromJson(Map<String, dynamic> json) {
    return CreatureTemplateLocaleEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? '',
      name: json['Name']?.toString() ?? '',
      title: json['Title']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureTemplateLocaleEntity copyWith({
    int? entry,
    String? locale,
    String? name,
    String? title,
    int? verifiedBuild,
  }) {
    return CreatureTemplateLocaleEntity(
      entry: entry ?? this.entry,
      locale: locale ?? this.locale,
      name: name ?? this.name,
      title: title ?? this.title,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'locale': locale,
      'Name': name,
      'Title': title,
      'VerifiedBuild': verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureTemplateLocaleEntity &&
            runtimeType == other.runtimeType &&
            entry == other.entry &&
            locale == other.locale &&
            name == other.name &&
            title == other.title &&
            verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      entry,
      locale,
      name,
      title,
      verifiedBuild,
    ]);
  }

  @override
  String toString() {
    return 'CreatureTemplateLocaleEntity('
        'entry: $entry, '
        'locale: $locale, '
        'name: $name, '
        'title: $title, '
        'verifiedBuild: $verifiedBuild'
        ')';
  }
}
