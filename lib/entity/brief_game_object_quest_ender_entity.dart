import 'package:foxy/entity/game_object_quest_ender_key.dart';

class BriefGameObjectQuestEnderEntity {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefGameObjectQuestEnderEntity({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefGameObjectQuestEnderEntity.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectQuestEnderEntity(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
      name: json['name']?.toString() ?? '',
      localeName: json['Name']?.toString() ?? '',
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  GameObjectQuestEnderKey get key =>
      GameObjectQuestEnderKey(id: id, quest: quest);
}
