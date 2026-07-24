import 'package:foxy/entity/game_object_quest_starter_entity.dart';

class BriefGameObjectQuestStarterEntity {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefGameObjectQuestStarterEntity({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefGameObjectQuestStarterEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefGameObjectQuestStarterEntity(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
      name: json['name']?.toString() ?? '',
      localeName: json['Name']?.toString() ?? '',
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  GameObjectQuestStarterKey get key =>
      GameObjectQuestStarterKey(id: id, quest: quest);
}
