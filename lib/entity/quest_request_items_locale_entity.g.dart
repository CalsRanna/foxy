// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_request_items_locale_entity.dart';

mixin _QuestRequestItemsLocaleEntityMixin {
  static QuestRequestItemsLocaleEntity fromJson(Map<String, dynamic> json) {
    return QuestRequestItemsLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? 'zhCN',
      completionText: json['CompletionText']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  QuestRequestItemsLocaleEntity copyWith({
    int? id,
    String? locale,
    String? completionText,
    int? verifiedBuild,
  }) {
    final self = this as QuestRequestItemsLocaleEntity;
    return QuestRequestItemsLocaleEntity(
      id: id ?? self.id,
      locale: locale ?? self.locale,
      completionText: completionText ?? self.completionText,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as QuestRequestItemsLocaleEntity;
    return {
      'ID': self.id,
      'locale': self.locale,
      'CompletionText': self.completionText,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as QuestRequestItemsLocaleEntity;
    return identical(self, other) ||
        other is QuestRequestItemsLocaleEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.locale == other.locale &&
            self.completionText == other.completionText &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as QuestRequestItemsLocaleEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.locale,
      self.completionText,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as QuestRequestItemsLocaleEntity;
    return 'QuestRequestItemsLocaleEntity('
        'id: ${self.id}, '
        'locale: ${self.locale}, '
        'completionText: ${self.completionText}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class QuestRequestItemsLocaleKey {
  final int id;
  final String locale;

  const QuestRequestItemsLocaleKey({required this.id, required this.locale});

  factory QuestRequestItemsLocaleKey.fromEntity(
    QuestRequestItemsLocaleEntity entity,
  ) {
    return QuestRequestItemsLocaleKey(id: entity.id, locale: entity.locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestRequestItemsLocaleKey &&
            id == other.id &&
            locale == other.locale;
  }

  @override
  int get hashCode => Object.hashAll([id, locale]);

  @override
  String toString() {
    return 'QuestRequestItemsLocaleKey('
        'id: $id, '
        'locale: $locale'
        ')';
  }
}

final class BriefQuestRequestItemsLocaleEntity {
  final int id;
  final String locale;
  final String completionText;

  const BriefQuestRequestItemsLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.completionText = '',
  });

  factory BriefQuestRequestItemsLocaleEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefQuestRequestItemsLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? 'zhCN',
      completionText: json['CompletionText']?.toString() ?? '',
    );
  }

  QuestRequestItemsLocaleKey get key {
    return QuestRequestItemsLocaleKey(id: id, locale: locale);
  }
}
