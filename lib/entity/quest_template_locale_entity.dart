// quest_template_locale 表模型（1:N locale，复合主键 ID + Locale）

class QuestTemplateLocaleEntity {
  final int id;
  final String locale;
  final String title;
  final String details;
  final String objectives;
  final String endText;
  final String completedText;
  final String objectiveText1;
  final String objectiveText2;
  final String objectiveText3;
  final String objectiveText4;
  final int verifiedBuild;

  const QuestTemplateLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.title = '',
    this.details = '',
    this.objectives = '',
    this.endText = '',
    this.completedText = '',
    this.objectiveText1 = '',
    this.objectiveText2 = '',
    this.objectiveText3 = '',
    this.objectiveText4 = '',
    this.verifiedBuild = 0,
  });

  factory QuestTemplateLocaleEntity.fromJson(Map<String, dynamic> json) {
    return QuestTemplateLocaleEntity(
      id: (json['ID'] ?? json['id'] ?? 0) as int,
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
      verifiedBuild: json['VerifiedBuild'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'ID': id,
      'locale': locale,
      'Title': title,
      'Details': details,
      'Objectives': objectives,
      'EndText': endText,
      'CompletedText': completedText,
      'ObjectiveText1': objectiveText1,
      'ObjectiveText2': objectiveText2,
      'ObjectiveText3': objectiveText3,
      'ObjectiveText4': objectiveText4,
      'VerifiedBuild': verifiedBuild,
    };
    return result;
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
    return QuestTemplateLocaleEntity(
      id: id ?? this.id,
      locale: locale ?? this.locale,
      title: title ?? this.title,
      details: details ?? this.details,
      objectives: objectives ?? this.objectives,
      endText: endText ?? this.endText,
      completedText: completedText ?? this.completedText,
      objectiveText1: objectiveText1 ?? this.objectiveText1,
      objectiveText2: objectiveText2 ?? this.objectiveText2,
      objectiveText3: objectiveText3 ?? this.objectiveText3,
      objectiveText4: objectiveText4 ?? this.objectiveText4,
      verifiedBuild: verifiedBuild ?? this.verifiedBuild,
    );
  }
}
