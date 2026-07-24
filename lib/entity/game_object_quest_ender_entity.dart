import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'game_object_quest_ender_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('name')
@FoxyBriefField.text('localeName')
@FoxyFullEntity(table: 'gameobject_questender')
class GameObjectQuestEnderEntity with _GameObjectQuestEnderEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('id', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('quest', key: true)
  final int quest;

  const GameObjectQuestEnderEntity({this.id = 0, this.quest = 0});

  factory GameObjectQuestEnderEntity.fromJson(Map<String, dynamic> json) =>
      _GameObjectQuestEnderEntityMixin.fromJson(json);
}

extension BriefGameObjectQuestEnderEntityDisplay
    on BriefGameObjectQuestEnderEntity {
  String get displayName => localeName.isNotEmpty ? localeName : name;
}
