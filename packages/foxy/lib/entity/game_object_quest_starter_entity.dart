import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'game_object_quest_starter_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('name')
@FoxyBriefField.text('localeName')
@FoxyFullEntity(table: 'gameobject_queststarter')
class GameObjectQuestStarterEntity with _GameObjectQuestStarterEntityMixin {
  @FoxyBriefField()
  @FoxyFieldMeaning.reference(
    '游戏对象',
    table: 'gameobject_template',
    column: 'entry',
  )
  @FoxyFullField('id', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('任务', table: 'quest_template', column: 'ID')
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
