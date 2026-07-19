import 'package:foxy/entity/quest_template_key.dart';

class BriefQuestTemplateEntity {
  final int id;
  final String logTitle;
  final String localeTitle;
  final String questDescription;
  final String localeDetails;
  final int questType;
  final int questLevel;
  final int minLevel;

  const BriefQuestTemplateEntity({
    this.id = 0,
    this.logTitle = '',
    this.localeTitle = '',
    this.questDescription = '',
    this.localeDetails = '',
    this.questType = 2,
    this.questLevel = 1,
    this.minLevel = 0,
  });

  factory BriefQuestTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestTemplateEntity(
      id: json['ID'] ?? json['id'] ?? 0,
      logTitle: json['LogTitle']?.toString() ?? '',
      localeTitle: json['Title']?.toString() ?? '',
      questDescription: json['QuestDescription']?.toString() ?? '',
      localeDetails: json['Details']?.toString() ?? '',
      questType: json['QuestType'] ?? 2,
      questLevel: json['QuestLevel'] ?? 1,
      minLevel: json['MinLevel'] ?? 0,
    );
  }

  String get displayDescription =>
      localeDetails.isNotEmpty ? localeDetails : questDescription;

  String get displayTitle => localeTitle.isNotEmpty ? localeTitle : logTitle;

  QuestTemplateKey get key => QuestTemplateKey(id: id);
}
