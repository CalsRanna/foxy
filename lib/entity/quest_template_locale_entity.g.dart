// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_locale_entity.dart';

mixin _QuestTemplateLocaleEntityMixin {
  static QuestTemplateLocaleEntity fromJson(Map<String, dynamic> json) {
    return QuestTemplateLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? 'zhCN',
      title: json['Title']?.toString() ?? '',
      details: json['Details']?.toString() ?? '',
      objectives: json['Objectives']?.toString() ?? '',
      endText: json['EndText']?.toString() ?? '',
      completedText: json['CompletedText']?.toString() ?? '',
      objectiveText1: json['ObjectiveText1']?.toString() ?? '',
      objectiveText2: json['ObjectiveText2']?.toString() ?? '',
      objectiveText3: json['ObjectiveText3']?.toString() ?? '',
      objectiveText4: json['ObjectiveText4']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  QuestTemplateLocaleEntity copyWith({
    int? id,
    String? locale,
    String? title,
    String? details,
    String? objectives,
    String? endText,
    String? completedText,
    String? objectiveText1,
    String? objectiveText2,
    String? objectiveText3,
    String? objectiveText4,
    int? verifiedBuild,
  }) {
    final self = this as QuestTemplateLocaleEntity;
    return QuestTemplateLocaleEntity(
      id: id ?? self.id,
      locale: locale ?? self.locale,
      title: title ?? self.title,
      details: details ?? self.details,
      objectives: objectives ?? self.objectives,
      endText: endText ?? self.endText,
      completedText: completedText ?? self.completedText,
      objectiveText1: objectiveText1 ?? self.objectiveText1,
      objectiveText2: objectiveText2 ?? self.objectiveText2,
      objectiveText3: objectiveText3 ?? self.objectiveText3,
      objectiveText4: objectiveText4 ?? self.objectiveText4,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as QuestTemplateLocaleEntity;
    return {
      'ID': self.id,
      'locale': self.locale,
      'Title': self.title,
      'Details': self.details,
      'Objectives': self.objectives,
      'EndText': self.endText,
      'CompletedText': self.completedText,
      'ObjectiveText1': self.objectiveText1,
      'ObjectiveText2': self.objectiveText2,
      'ObjectiveText3': self.objectiveText3,
      'ObjectiveText4': self.objectiveText4,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as QuestTemplateLocaleEntity;
    return identical(self, other) ||
        other is QuestTemplateLocaleEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.locale == other.locale &&
            self.title == other.title &&
            self.details == other.details &&
            self.objectives == other.objectives &&
            self.endText == other.endText &&
            self.completedText == other.completedText &&
            self.objectiveText1 == other.objectiveText1 &&
            self.objectiveText2 == other.objectiveText2 &&
            self.objectiveText3 == other.objectiveText3 &&
            self.objectiveText4 == other.objectiveText4 &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as QuestTemplateLocaleEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.locale,
      self.title,
      self.details,
      self.objectives,
      self.endText,
      self.completedText,
      self.objectiveText1,
      self.objectiveText2,
      self.objectiveText3,
      self.objectiveText4,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as QuestTemplateLocaleEntity;
    return 'QuestTemplateLocaleEntity('
        'id: ${self.id}, '
        'locale: ${self.locale}, '
        'title: ${self.title}, '
        'details: ${self.details}, '
        'objectives: ${self.objectives}, '
        'endText: ${self.endText}, '
        'completedText: ${self.completedText}, '
        'objectiveText1: ${self.objectiveText1}, '
        'objectiveText2: ${self.objectiveText2}, '
        'objectiveText3: ${self.objectiveText3}, '
        'objectiveText4: ${self.objectiveText4}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class QuestTemplateLocaleKey {
  final int id;
  final String locale;

  const QuestTemplateLocaleKey({required this.id, required this.locale});

  factory QuestTemplateLocaleKey.fromEntity(QuestTemplateLocaleEntity entity) {
    return QuestTemplateLocaleKey(id: entity.id, locale: entity.locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestTemplateLocaleKey &&
            id == other.id &&
            locale == other.locale;
  }

  @override
  int get hashCode => Object.hashAll([id, locale]);

  @override
  String toString() {
    return 'QuestTemplateLocaleKey('
        'id: $id, '
        'locale: $locale'
        ')';
  }
}

final class BriefQuestTemplateLocaleEntity {
  final int id;
  final String locale;
  final String title;

  const BriefQuestTemplateLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.title = '',
  });

  factory BriefQuestTemplateLocaleEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestTemplateLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? 'zhCN',
      title: json['Title']?.toString() ?? '',
    );
  }

  QuestTemplateLocaleKey get key {
    return QuestTemplateLocaleKey(id: id, locale: locale);
  }
}
