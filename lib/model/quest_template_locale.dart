// quest_template_locale 表模型（1:N locale，复合主键 ID + Locale）

class QuestTemplateLocale {
  int id = 0;
  String locale = 'zhCN';
  String title = '';
  String details = '';
  String objectives = '';
  String endText = '';
  String completedText = '';
  String objectiveText1 = '';
  String objectiveText2 = '';
  String objectiveText3 = '';
  String objectiveText4 = '';
  int? verifiedBuild;

  QuestTemplateLocale();

  QuestTemplateLocale.fromJson(Map<String, dynamic> json) {
    id = (json['ID'] ?? json['id'] ?? 0) as int;
    locale = json['Locale']?.toString() ?? 'zhCN';
    title = json['Title']?.toString() ?? '';
    details = json['Details']?.toString() ?? '';
    objectives = json['Objectives']?.toString() ?? '';
    endText = json['EndText']?.toString() ?? '';
    completedText = json['CompletedText']?.toString() ?? '';
    objectiveText1 = json['ObjectiveText1']?.toString() ?? '';
    objectiveText2 = json['ObjectiveText2']?.toString() ?? '';
    objectiveText3 = json['ObjectiveText3']?.toString() ?? '';
    objectiveText4 = json['ObjectiveText4']?.toString() ?? '';
    verifiedBuild = json['VerifiedBuild'];
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
