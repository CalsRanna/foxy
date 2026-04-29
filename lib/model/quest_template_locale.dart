// quest_template_locale 表模型（1:N locale，复合主键 ID + Locale）

class QuestTemplateLocale {
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
  final int? verifiedBuild;

  const QuestTemplateLocale({
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
    this.verifiedBuild,
  });

  factory QuestTemplateLocale.fromJson(Map<String, dynamic> json) {
    return QuestTemplateLocale(
      id: (json['ID'] ?? json['id'] ?? 0) as int,
      locale: json['Locale']?.toString() ?? 'zhCN',
      title: json['Title']?.toString() ?? '',
      details: json['Details']?.toString() ?? '',
      objectives: json['Objectives']?.toString() ?? '',
      endText: json['EndText']?.toString() ?? '',
      completedText: json['CompletedText']?.toString() ?? '',
      objectiveText1: json['ObjectiveText1']?.toString() ?? '',
      objectiveText2: json['ObjectiveText2']?.toString() ?? '',
      objectiveText3: json['ObjectiveText3']?.toString() ?? '',
      objectiveText4: json['ObjectiveText4']?.toString() ?? '',
      verifiedBuild: json['VerifiedBuild'],
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'ID': id,
      'Locale': locale,
      'Title': title,
      'Details': details,
      'Objectives': objectives,
      'EndText': endText,
      'CompletedText': completedText,
      'ObjectiveText1': objectiveText1,
      'ObjectiveText2': objectiveText2,
      'ObjectiveText3': objectiveText3,
      'ObjectiveText4': objectiveText4,
    };
    if (verifiedBuild != null) {
      result['VerifiedBuild'] = verifiedBuild!;
    }
    return result;
  }
}
