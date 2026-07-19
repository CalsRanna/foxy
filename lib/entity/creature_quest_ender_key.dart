import 'package:flutter/foundation.dart';
import 'package:foxy/entity/creature_quest_ender_entity.dart';

@immutable
final class CreatureQuestEnderKey {
  final int id;
  final int quest;

  const CreatureQuestEnderKey({required this.id, required this.quest});

  factory CreatureQuestEnderKey.fromEntity(CreatureQuestEnderEntity value) {
    return CreatureQuestEnderKey(id: value.id, quest: value.quest);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureQuestEnderKey &&
            id == other.id &&
            quest == other.quest;
  }

  @override
  int get hashCode => Object.hash(id, quest);
}
