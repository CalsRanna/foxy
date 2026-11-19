import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'creature_quest_starter_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('name')
@FoxyBriefField.text('localeName')
@FoxyFullEntity(table: 'creature_queststarter')
class CreatureQuestStarterEntity with _CreatureQuestStarterEntityMixin {
  @FoxyBriefField()
  @FoxyFieldMeaning.reference('生物', table: 'creature_template', column: 'entry')
  @FoxyFullField('id', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('任务', table: 'quest_template', column: 'ID')
  @FoxyFullField('quest', key: true)
  final int quest;

  const CreatureQuestStarterEntity({this.id = 0, this.quest = 0});

  factory CreatureQuestStarterEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureQuestStarterEntityMixin.fromJson(json);
}

extension BriefCreatureQuestStarterEntityDisplay
    on BriefCreatureQuestStarterEntity {
  String get displayName => localeName.isNotEmpty ? localeName : name;
}
