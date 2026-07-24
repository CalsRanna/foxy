// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_quest_starter_entity.g.dart';

@FoxyFullEntity(table: 'creature_queststarter')
class CreatureQuestStarterEntity with _CreatureQuestStarterEntityMixin {
  @FoxyFullField('id', key: true)
  final int id;

  @FoxyFullField('quest', key: true)
  final int quest;

  const CreatureQuestStarterEntity({this.id = 0, this.quest = 0});

  factory CreatureQuestStarterEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureQuestStarterEntityMixin.fromJson(json);
}
