import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'game_object_quest_starter_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('name')
@FoxyBriefField.text('localeName')
@FoxyFullEntity(table: 'gameobject_queststarter')
class GameObjectQuestStarterEntity with _GameObjectQuestStarterEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('id', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('quest', key: true)
  final int quest;

  const GameObjectQuestStarterEntity({this.id = 0, this.quest = 0});

  factory GameObjectQuestStarterEntity.fromJson(Map<String, dynamic> json) =>
      _GameObjectQuestStarterEntityMixin.fromJson(json);
}

extension BriefGameObjectQuestStarterEntityDisplay
    on BriefGameObjectQuestStarterEntity {
  String get displayName => localeName.isNotEmpty ? localeName : name;
}
