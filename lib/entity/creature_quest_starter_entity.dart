import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_quest_starter_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('name')
@FoxyBriefField.text('localeName')
@FoxyFullEntity(table: 'creature_queststarter')
class CreatureQuestStarterEntity with _CreatureQuestStarterEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('id', key: true)
  final int id;

  @FoxyBriefField()
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
