import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'quest_template_locale_entity.g.dart';

// quest_template_locale 表模型（1:N locale，复合主键 ID + Locale）

@FoxyBriefEntity()
@FoxyFullEntity(table: 'quest_template_locale')
class QuestTemplateLocaleEntity with _QuestTemplateLocaleEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('locale', key: true)
  final String locale;

  @FoxyBriefField()
  @FoxyFullField('Title')
  final String title;

  @FoxyFullField('Details')
  final String details;

  @FoxyFullField('Objectives')
  final String objectives;

  @FoxyFullField('EndText')
  final String endText;

  @FoxyFullField('CompletedText')
  final String completedText;

  @FoxyFullField('ObjectiveText1')
  final String objectiveText1;

  @FoxyFullField('ObjectiveText2')
  final String objectiveText2;

  @FoxyFullField('ObjectiveText3')
  final String objectiveText3;

  @FoxyFullField('ObjectiveText4')
  final String objectiveText4;

  @FoxyFullField('VerifiedBuild')
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

  factory QuestTemplateLocaleEntity.fromJson(Map<String, dynamic> json) =>
      _QuestTemplateLocaleEntityMixin.fromJson(json);
}
