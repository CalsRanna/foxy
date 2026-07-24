// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'game_object_quest_starter_entity.g.dart';

@FoxyFullEntity(table: 'gameobject_queststarter')
class GameObjectQuestStarterEntity with _GameObjectQuestStarterEntityMixin {
  @FoxyFullField('id', key: true)
  final int id;

  @FoxyFullField('quest', key: true)
  final int quest;

  const GameObjectQuestStarterEntity({this.id = 0, this.quest = 0});

  factory GameObjectQuestStarterEntity.fromJson(Map<String, dynamic> json) =>
      _GameObjectQuestStarterEntityMixin.fromJson(json);
}
