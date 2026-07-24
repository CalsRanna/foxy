import 'package:foxy/entity/creature_quest_ender_entity.dart';

class BriefCreatureQuestEnderEntity {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefCreatureQuestEnderEntity({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefCreatureQuestEnderEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureQuestEnderEntity(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
      name: json['name']?.toString() ?? '',
      localeName: json['Name']?.toString() ?? '',
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  CreatureQuestEnderKey get key => CreatureQuestEnderKey(id: id, quest: quest);
}
