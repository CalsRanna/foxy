// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_template_locale_entity.dart';

final class BriefItemTemplateLocaleEntity {
  final int id;
  final String locale;
  final String name;

  const BriefItemTemplateLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.name = '',
  });

  factory BriefItemTemplateLocaleEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemTemplateLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? 'zhCN',
      name: json['Name']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([id, locale, name]);

  ItemTemplateLocaleKey get key {
    return ItemTemplateLocaleKey(id: id, locale: locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefItemTemplateLocaleEntity &&
            id == other.id &&
            locale == other.locale &&
            name == other.name;
  }

  @override
  String toString() {
    return 'BriefItemTemplateLocaleEntity('
        'id: $id, '
        'locale: $locale, '
        'name: $name'
        ')';
  }
}

final class ItemTemplateLocaleKey {
  final int id;
  final String locale;

  const ItemTemplateLocaleKey({required this.id, required this.locale});

  factory ItemTemplateLocaleKey.fromEntity(ItemTemplateLocaleEntity entity) {
    return ItemTemplateLocaleKey(id: entity.id, locale: entity.locale);
  }

  @override
  int get hashCode => Object.hashAll([id, locale]);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemTemplateLocaleKey &&
            id == other.id &&
            locale == other.locale;
  }

  @override
  String toString() {
    return 'ItemTemplateLocaleKey('
        'id: $id, '
        'locale: $locale'
        ')';
  }
}

mixin _ItemTemplateLocaleEntityMixin {
  @override
  int get hashCode {
    final self = this as ItemTemplateLocaleEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.locale,
      self.name,
      self.description,
      self.verifiedBuild,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as ItemTemplateLocaleEntity;
    return identical(self, other) ||
        other is ItemTemplateLocaleEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.locale == other.locale &&
            self.name == other.name &&
            self.description == other.description &&
            self.verifiedBuild == other.verifiedBuild;
  }

  ItemTemplateLocaleEntity copyWith({
    int? id,
    String? locale,
    String? name,
    String? description,
    int? verifiedBuild,
  }) {
    final self = this as ItemTemplateLocaleEntity;
    return ItemTemplateLocaleEntity(
      id: id ?? self.id,
      locale: locale ?? self.locale,
      name: name ?? self.name,
      description: description ?? self.description,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ItemTemplateLocaleEntity;
    return {
      'ID': self.id,
      'locale': self.locale,
      'Name': self.name,
      'Description': self.description,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  String toString() {
    final self = this as ItemTemplateLocaleEntity;
    return 'ItemTemplateLocaleEntity('
        'id: ${self.id}, '
        'locale: ${self.locale}, '
        'name: ${self.name}, '
        'description: ${self.description}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }

  static ItemTemplateLocaleEntity fromJson(Map<String, dynamic> json) {
    return ItemTemplateLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? 'zhCN',
      name: json['Name']?.toString() ?? '',
      description: json['Description']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }
}
