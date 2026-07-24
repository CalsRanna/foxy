// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_locale_entity.dart';

mixin _CreatureTemplateLocaleEntityMixin {
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
}
