// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_locale_entity.dart';

mixin _GameObjectTemplateLocaleEntityMixin {
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
    final self = this as GameObjectTemplateLocaleEntity;
    return GameObjectTemplateLocaleEntity(
      entry: entry ?? self.entry,
      locale: locale ?? self.locale,
      name: name ?? self.name,
      castBarCaption: castBarCaption ?? self.castBarCaption,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GameObjectTemplateLocaleEntity;
    return {
      'entry': self.entry,
      'locale': self.locale,
      'name': self.name,
      'castBarCaption': self.castBarCaption,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as GameObjectTemplateLocaleEntity;
    return identical(self, other) ||
        other is GameObjectTemplateLocaleEntity &&
            self.runtimeType == other.runtimeType &&
            self.entry == other.entry &&
            self.locale == other.locale &&
            self.name == other.name &&
            self.castBarCaption == other.castBarCaption &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as GameObjectTemplateLocaleEntity;
    return Object.hashAll([
      self.runtimeType,
      self.entry,
      self.locale,
      self.name,
      self.castBarCaption,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as GameObjectTemplateLocaleEntity;
    return 'GameObjectTemplateLocaleEntity('
        'entry: ${self.entry}, '
        'locale: ${self.locale}, '
        'name: ${self.name}, '
        'castBarCaption: ${self.castBarCaption}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class GameObjectTemplateLocaleKey {
  final int entry;
  final String locale;

  const GameObjectTemplateLocaleKey({
    required this.entry,
    required this.locale,
  });

  factory GameObjectTemplateLocaleKey.fromEntity(
    GameObjectTemplateLocaleEntity entity,
  ) {
    return GameObjectTemplateLocaleKey(
      entry: entity.entry,
      locale: entity.locale,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectTemplateLocaleKey &&
            entry == other.entry &&
            locale == other.locale;
  }

  @override
  int get hashCode => Object.hashAll([entry, locale]);

  @override
  String toString() {
    return 'GameObjectTemplateLocaleKey('
        'entry: $entry, '
        'locale: $locale'
        ')';
  }
}

final class BriefGameObjectTemplateLocaleEntity {
  final int entry;
  final String locale;
  final String name;
  final String castBarCaption;

  const BriefGameObjectTemplateLocaleEntity({
    this.entry = 0,
    this.locale = '',
    this.name = '',
    this.castBarCaption = '',
  });

  factory BriefGameObjectTemplateLocaleEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefGameObjectTemplateLocaleEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      castBarCaption: json['castBarCaption']?.toString() ?? '',
    );
  }

  GameObjectTemplateLocaleKey get key {
    return GameObjectTemplateLocaleKey(entry: entry, locale: locale);
  }
}
