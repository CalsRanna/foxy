import 'package:flutter/foundation.dart';
import 'package:foxy/entity/creature_quest_starter_entity.dart';

@immutable
final class CreatureQuestStarterKey {
  final int id;
  final int quest;

  const CreatureQuestStarterKey({required this.id, required this.quest});

  factory CreatureQuestStarterKey.fromEntity(CreatureQuestStarterEntity value) {
    return CreatureQuestStarterKey(id: value.id, quest: value.quest);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureQuestStarterKey &&
            id == other.id &&
            quest == other.quest;
  }

  @override
  int get hashCode => Object.hash(id, quest);
}
