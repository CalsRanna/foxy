import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'creature_quest_ender_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('name')
@FoxyBriefField.text('localeName')
@FoxyFullEntity(table: 'creature_questender')
class CreatureQuestEnderEntity with _CreatureQuestEnderEntityMixin {
  @FoxyBriefField()
  @FoxyFieldMeaning.reference('生物', table: 'creature_template', column: 'entry')
  @FoxyFullField('id', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('任务', table: 'quest_template', column: 'ID')
  @FoxyFullField('quest', key: true)
  final int quest;

  const CreatureQuestEnderEntity({this.id = 0, this.quest = 0});

  factory CreatureQuestEnderEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureQuestEnderEntityMixin.fromJson(json);
}

extension BriefCreatureQuestEnderEntityDisplay
    on BriefCreatureQuestEnderEntity {
  String get displayName => localeName.isNotEmpty ? localeName : name;
}
