// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_locale_entity.dart';

mixin _GameObjectTemplateLocaleEntityMixin {
  int get entry;
  String get locale;
  String get name;
  String get castBarCaption;
  int get verifiedBuild;

  static GameObjectTemplateLocaleEntity fromJson(Map<String, dynamic> json) {
    return GameObjectTemplateLocaleEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      castBarCaption: json['castBarCaption']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  GameObjectTemplateLocaleEntity copyWith({
    int? entry,
    String? locale,
    String? name,
    String? castBarCaption,
    int? verifiedBuild,
  }) {
    return GameObjectTemplateLocaleEntity(
      entry: entry ?? this.entry,
      locale: locale ?? this.locale,
      name: name ?? this.name,
      castBarCaption: castBarCaption ?? this.castBarCaption,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'locale': locale,
      'name': name,
      'castBarCaption': castBarCaption,
      'VerifiedBuild': verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectTemplateLocaleEntity &&
            runtimeType == other.runtimeType &&
            entry == other.entry &&
            locale == other.locale &&
            name == other.name &&
            castBarCaption == other.castBarCaption &&
            verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      entry,
      locale,
      name,
      castBarCaption,
      verifiedBuild,
    ]);
  }

  @override
  String toString() {
    return 'GameObjectTemplateLocaleEntity('
        'entry: $entry, '
        'locale: $locale, '
        'name: $name, '
        'castBarCaption: $castBarCaption, '
        'verifiedBuild: $verifiedBuild'
        ')';
  }
}
