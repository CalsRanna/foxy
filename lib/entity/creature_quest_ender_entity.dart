import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_quest_ender_entity.g.dart';

@FoxyFullEntity(table: 'creature_questender')
class CreatureQuestEnderEntity with _CreatureQuestEnderEntityMixin {
  @FoxyFullField('id', key: true)
  final int id;

  @FoxyFullField('quest', key: true)
  final int quest;

  const CreatureQuestEnderEntity({this.id = 0, this.quest = 0});

  factory CreatureQuestEnderEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureQuestEnderEntityMixin.fromJson(json);
}
